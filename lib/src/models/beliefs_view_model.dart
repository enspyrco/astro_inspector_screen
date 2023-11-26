import 'belief_node.dart';

/// [_MutableBeliefNode] is a private class which allows for mutating objects
/// during construction for easier tree building / conversion from json.
/// The public interface, [BeliefNode], makes the resulting object immutable
/// (not compleletely b/c List & Map are mutable but close enough for our purposes).
class _MutableBeliefNode implements BeliefNode {
  _MutableBeliefNode({required this.name});

  @override
  NodeStatus status = NodeStatus.unknown;
  @override
  NodeType type = NodeType.unknown;
  @override
  final String name;
  @override
  Object? value;
  @override
  final List<_MutableBeliefNode> children = [];
}

/// The [BeliefsViewModel] constructs a tree of [BeliefNode]s from the latest
/// beliefs and previous beliefs. Both sets of beliefs in json format, and have
/// passed over from the running app.
/// The resulting tree of [BeliefNode]s keeps unchanged beliefs as well as added,
/// edited or removed beliefs, so that the [BeliefsView] can visualise changes.
class BeliefsViewModel {
  BeliefsViewModel(
      Map<String, Object?> json, Map<String, Object?> previousJson) {
    _growTree(json: json, previousJson: previousJson, parentNode: _godNode);
  }

  /// A single hidden node whose children are the parents of all [BeliefNode]s
  final _godNode = _MutableBeliefNode(name: '');

  /// The parents of all [BeliefNode]s
  List<BeliefNode> get beliefs => _godNode.children;

  /// Recursively grow the tree from the given json & previousJson by adding
  /// children to the given node and calling [growTree] on each child.
  void _growTree(
      {required Object? json,
      required Object? previousJson,
      required _MutableBeliefNode parentNode}) {
    switch ((json, previousJson)) {
      case (null, List<Object?>()):
        parentNode.status = NodeStatus.removed;
        parentNode.type = NodeType.list;
        for (var i = 0; i < (previousJson as List).length; i++) {
          final newNode = _MutableBeliefNode(name: '$i');
          parentNode.children.add(newNode);
          _growTree(
              json: null, previousJson: previousJson[i], parentNode: newNode);
        }
      case (List<Object?>(), null):
        parentNode.status = NodeStatus.added;
        parentNode.type = NodeType.list;
        for (var i = 0; i < (json as List).length; i++) {
          final newNode = _MutableBeliefNode(name: '$i');
          parentNode.children.add(newNode);
          _growTree(json: json[i], previousJson: null, parentNode: newNode);
        }
      case (List<Object?>(), List<Object?>()):
        parentNode.status = NodeStatus.unchanged;
        parentNode.type = NodeType.list;
        for (var i = 0; i < (json as List).length; i++) {
          final newNode = _MutableBeliefNode(name: '$i');
          parentNode.children.add(newNode);
          _growTree(
            json: json[i],
            previousJson:
                i < (previousJson as List).length ? previousJson[i] : null,
            parentNode: newNode,
          );
        }
      case (null, Map<String, Object?>()):
        parentNode.status = NodeStatus.removed;
        parentNode.type = NodeType.object;
        for (var key in (previousJson as Map<String, Object?>).keys) {
          final newNode = _MutableBeliefNode(name: key);
          parentNode.children.add(newNode);
          _growTree(
              json: null, previousJson: previousJson[key], parentNode: newNode);
        }
      case (Map<String, Object?>(), null):
        parentNode.status = NodeStatus.added;
        parentNode.type = NodeType.object;
        for (var key in (json as Map<String, Object?>).keys) {
          final newNode = _MutableBeliefNode(name: key);
          parentNode.children.add(newNode);
          _growTree(json: json[key], previousJson: null, parentNode: newNode);
        }
      case (Map<String, Object?>(), Map<String, Object?>()):
        parentNode.status = NodeStatus.unchanged;
        parentNode.type = NodeType.object;
        for (var key in (json as Map<String, Object?>).keys) {
          final newNode = _MutableBeliefNode(name: key);
          parentNode.children.add(newNode);
          _growTree(
            json: json[key],
            previousJson: (previousJson as Map)[key],
            parentNode: newNode,
          );
        }
      case (null, _):
        parentNode.status = NodeStatus.removed;
        parentNode.type = NodeType.value;
        parentNode.value = previousJson;
      case (_, null):
        parentNode.status = NodeStatus.added;
        parentNode.type = NodeType.value;
        parentNode.value = json;
      case (_, _):
        parentNode.status = NodeStatus.unchanged;
        parentNode.type = NodeType.value;
        parentNode.value = json;
    }
  }
}

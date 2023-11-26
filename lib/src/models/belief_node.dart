enum NodeStatus { added, removed, unchanged, unknown }

enum NodeType { list, object, value, unknown }

abstract class BeliefNode {
  NodeStatus get status;
  NodeType get type;
  String get name;
  Object? get value;
  List<BeliefNode> get children;
}

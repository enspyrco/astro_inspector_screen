enum NodeType {
  list,
  object,
  value,
}

class BeliefNode {
  BeliefNode({this.title, Object? json})
      : nodeType = switch (json) {
          List<Object?>() => NodeType.list,
          Map<String, Object?>() => NodeType.object,
          _ => NodeType.value
        },
        children = switch (json) {
          List<Object?>() =>
            json.map((item) => BeliefNode(json: item)).toList(),
          Map<String, Object?>() => json.keys
              .map((key) => BeliefNode(title: key, json: json[key]))
              .toList(),
          _ => []
        };

  final NodeType nodeType;
  final String? title;
  final List<BeliefNode> children;
}

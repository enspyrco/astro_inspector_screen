enum NodeCategory {
  list,
  listAdded,
  listRemoved,
  object,
  objectAdded,
  objectRemoved,
  value,
  valueAdded,
  valueRemoved,
  nullValue,
}

class BeliefNode {
  BeliefNode(
      {required this.value,
      required Object? json,
      required Object? previousJson})
      : category = switch ((json, previousJson)) {
          (null, List<Object?>()) => NodeCategory.listRemoved,
          (List<Object?>(), null) => NodeCategory.listAdded,
          (List<Object?>(), List<Object?>()) => NodeCategory.list,
          (null, Map<String, Object?>()) => NodeCategory.objectRemoved,
          (Map<String, Object?>(), null) => NodeCategory.objectAdded,
          (Map<String, Object?>(), Map<String, Object?>()) =>
            NodeCategory.object,
          (null, null) => NodeCategory.nullValue,
          (null, _) => NodeCategory.valueRemoved,
          (_, null) => NodeCategory.valueAdded,
          (_, _) => NodeCategory.value,
        },
        children = switch ((json, previousJson)) {
          (null, List<Object?>()) => [
              for (var i = 0; i < (previousJson as List).length; i++)
                BeliefNode(
                  value: i,
                  json: null,
                  previousJson: previousJson[i],
                )
            ],
          (List<Object?>(), null) => [
              for (var i = 0; i < (json as List).length; i++)
                BeliefNode(
                  value: i,
                  json: json[i],
                  previousJson: null,
                )
            ],
          (List<Object?>(), List<Object?>()) => [
              for (var i = 0; i < (json as List).length; i++)
                BeliefNode(
                  value: i,
                  json: json[i],
                  previousJson: i >= (previousJson as List).length
                      ? null
                      : previousJson[i],
                )
            ],
          (null, Map<String, Object?>()) => [
              for (var key in (previousJson as Map<String, Object?>).keys)
                BeliefNode(
                  value: key,
                  json: null,
                  previousJson: previousJson[key],
                )
            ],
          (Map<String, Object?>(), null) => [
              for (var key in (json as Map<String, Object?>).keys)
                BeliefNode(
                  value: key,
                  json: json[key],
                  previousJson: null,
                )
            ],
          (Map<String, Object?>(), Map<String, Object?>()) => [
              for (var key in (json as Map<String, Object?>).keys)
                BeliefNode(
                  value: key,
                  json: json[key],
                  previousJson: (previousJson as Map)[key],
                )
            ],
          _ => []
        };

  final NodeCategory category;
  final Object value;
  final List<BeliefNode> children;
}

import 'package:json_utils/json_utils.dart';
import 'package:abstractions/beliefs.dart';

import '../beliefs/introspection_beliefs.dart';
import '../enums/lineage_shape.dart';

class CognitionSelected extends Conclusion<IntrospectionBeliefs> {
  final int _index;

  CognitionSelected(this._index);

  int get index => _index;

  /// Select a list item and also identify the appropriate lineage to be drawn.
  @override
  IntrospectionBeliefs conclude(IntrospectionBeliefs beliefs) {
    return updateSelectedAndLineage(beliefs, index);
  }

  @override
  toJson() => {
        'name_': 'SelectMission',
        'state_': {'index': index}
      };
}

/// Used by [CognitionSelected] and [CognitiveProcessAdded] conclusions to
/// select a cognition and calculate how each list item is involved in the
/// lineage. There are 5 possibilities - in between the `origin` and the
/// `endpoint` the list items are either a `connection` (one of the cognitions
/// in the the lineage) or `notConnection` (not in the sequence). Any items
/// beyond the origin have `null` and do not have any lineage drawn.
IntrospectionBeliefs updateSelectedAndLineage(
    IntrospectionBeliefs beliefs, int index) {
  var lineageFor = <int, LineageShape>{};

  // Process the selected cognition
  lineageFor[index] = LineageShape.endpoint;
  int currentIndex = index;
  var parentId = (beliefs.cognitiveProcesses[currentIndex]['cognition']
      as JsonMap)['parent_'];
  if (parentId == null) {
    // if first cognition is selected parent is null
    return beliefs.copyWith(selectedIndex: index, lineageFor: {});
  }
  currentIndex = beliefs.indexFor[parentId]!;

  // Move to the parent and process the cognition until there is no parent
  while (true) {
    parentId = (beliefs.cognitiveProcesses[currentIndex]['cognition']
        as JsonMap)['parent_'];

    if (parentId == null) {
      lineageFor[currentIndex] = LineageShape.origin;
      break;
    }

    lineageFor[currentIndex] = LineageShape.connection;

    currentIndex = beliefs.indexFor[parentId]!;
  }

  // Iterate over the cognitions from origin to endpoint and update anything unset
  // to `notConnection`.
  for (int i = index; i != currentIndex; i--) {
    lineageFor[i] ??= LineageShape.notConnection;
  }

  return beliefs.copyWith(selectedIndex: index, lineageFor: lineageFor);
}
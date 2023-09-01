import 'package:json_utils/json_utils.dart';
import 'package:abstractions/beliefs.dart';

import '../enums/lineage_shape.dart';
import '../state/introspection_beliefs.dart';

class SelectMission extends Conclusion<IntrospectionBeliefs> {
  final int _index;

  SelectMission(this._index);

  int get index => _index;

  /// Select a list item and also identify the appropriate lineage to be drawn.
  @override
  IntrospectionBeliefs conclude(state) =>
      updateSelectedAndLineage(state, index);

  @override
  toJson() => {
        'name_': 'SelectMission',
        'state_': {'index': index}
      };
}

/// Used by [SelectMission] & [AddMissionReport] to select a mission and
/// calculate how each list item is involved in the lineage. There are 5
/// possibilities - in between the `origin` and the `endpoint` the list items
/// are either a `connection` (one of the missions in the the lineage) or
/// `notConnection` (not in the sequence). Any items beyond the origin have
/// `null` and do not have any lineage drawn.
IntrospectionBeliefs updateSelectedAndLineage(
    IntrospectionBeliefs state, int index) {
  var lineageFor = <int, LineageShape>{};

  // Process the selected mission
  lineageFor[index] = LineageShape.endpoint;
  int currentIndex = index;
  var parentId =
      (state.missionReports[currentIndex]['mission'] as JsonMap)['parent_'];
  if (parentId == null) {
    // if first mission is selected parent is null
    return state.copyWith(selectedIndex: index, lineageFor: {});
  }
  currentIndex = state.indexFor[parentId]!;

  // Move to the parent and process the mission until there is no parent
  while (true) {
    parentId =
        (state.missionReports[currentIndex]['mission'] as JsonMap)['parent_'];

    if (parentId == null) {
      lineageFor[currentIndex] = LineageShape.origin;
      break;
    }

    lineageFor[currentIndex] = LineageShape.connection;

    currentIndex = state.indexFor[parentId]!;
  }

  // Iterate over the missions from origin to endpoint and update anything unset
  // to `notConnection`.
  for (int i = index; i != currentIndex; i--) {
    lineageFor[i] ??= LineageShape.notConnection;
  }

  return state.copyWith(selectedIndex: index, lineageFor: lineageFor);
}
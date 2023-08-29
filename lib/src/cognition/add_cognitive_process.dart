import 'package:json_utils/json_utils.dart';
import 'package:abstractions/beliefs.dart';

import '../state/introspection_beliefs.dart';
import 'select_mission.dart';

/// Used for adding a mission update to the list.
/// Also sets the selected index to the new mission update.
/// The incoming json is assumed to have the form:
/// `{ mission: {id_ : <id>, ... }`
class AddCognitiveProcess extends Conclusion<IntrospectionBeliefs> {
  AddCognitiveProcess(this._cognitiveProcessJson);

  final JsonMap _cognitiveProcessJson;

  int get cognitionId =>
      (_cognitiveProcessJson['mission'] as JsonMap)['id_'] as int;

  JsonMap get eventJson => JsonMap.unmodifiable(_cognitiveProcessJson);

  @override
  IntrospectionBeliefs update(beliefs) {
    var newState = beliefs.copyWith(
        missionReports: [...beliefs.missionReports, eventJson],
        selectedIndex: beliefs.missionReports.length,
        indexFor: {
          ...beliefs.indexFor,
          cognitionId: beliefs.missionReports.length
        });
    return updateSelectedAndLineage(
        newState, newState.missionReports.length - 1);
  }

  @override
  toJson() => {
        'name_': 'Add Mission Update',
        'state_': {'event': eventJson}
      };
}

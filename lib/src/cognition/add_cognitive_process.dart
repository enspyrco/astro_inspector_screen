import 'package:json_utils/json_utils.dart';
import 'package:abstractions/beliefs.dart';

import '../beliefs/introspection_beliefs.dart';
import 'select_cognition.dart';

/// Used for adding a cognitive process to the list.
/// Also sets the selected index to the new cognitive process.
/// The incoming json is assumed to have the form:
/// `{ cognition: {id_ : <id>, ... }`
class AddCognitiveProcess extends Conclusion<IntrospectionBeliefs> {
  AddCognitiveProcess(this._cognitiveProcessJson);

  final JsonMap _cognitiveProcessJson;

  int get cognitionId =>
      (_cognitiveProcessJson['cognition'] as JsonMap)['id_'] as int;

  JsonMap get eventJson => JsonMap.unmodifiable(_cognitiveProcessJson);

  @override
  IntrospectionBeliefs conclude(beliefs) {
    var newState = beliefs.copyWith(
        cognitiveProcesses: [...beliefs.cognitiveProcesses, eventJson],
        selectedIndex: beliefs.cognitiveProcesses.length,
        indexFor: {
          ...beliefs.indexFor,
          cognitionId: beliefs.cognitiveProcesses.length
        });
    return updateSelectedAndLineage(
        newState, newState.cognitiveProcesses.length - 1);
  }

  @override
  toJson() => {
        'name_': 'AddCognitiveProcess',
        'state_': {'event': eventJson}
      };
}

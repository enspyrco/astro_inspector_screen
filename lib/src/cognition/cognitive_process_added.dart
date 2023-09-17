import 'package:json_utils/json_utils.dart';
import 'package:abstractions/beliefs.dart';

import '../beliefs/introspection_beliefs.dart';
import 'cognition_selected.dart';

/// Used for adding a new cognitive process belief to [IntrospectionBeliefs].
/// Also sets the selected index to that of the new cognitive process.
/// The incoming json is assumed to have the form:
/// `{ cognition: {id_ : <id>, ... }`
class CognitiveProcessAdded extends Conclusion<IntrospectionBeliefs> {
  CognitiveProcessAdded(this._cognitiveProcessJson);

  final JsonMap _cognitiveProcessJson;

  int get cognitionId =>
      (_cognitiveProcessJson['cognition'] as JsonMap)['id_'] as int;

  JsonMap get eventJson => JsonMap.unmodifiable(_cognitiveProcessJson);

  @override
  IntrospectionBeliefs conclude(IntrospectionBeliefs beliefs) {
    var newBeliefs = beliefs.copyWith(
        cognitiveProcesses: [...beliefs.cognitiveProcesses, eventJson],
        selectedIndex: beliefs.cognitiveProcesses.length,
        indexFor: {
          ...beliefs.indexForId,
          cognitionId: beliefs.cognitiveProcesses.length
        });
    return updateSelectedAndLineage(
        newBeliefs, newBeliefs.cognitiveProcesses.length - 1);
  }

  @override
  toJson() => {
        'name_': 'AddCognitiveProcess',
        'state_': {'event': eventJson}
      };
}

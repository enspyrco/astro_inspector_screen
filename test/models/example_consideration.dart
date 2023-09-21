import 'package:abstractions/beliefs.dart';
import 'package:introspection/src/beliefs/introspection_beliefs.dart';

class ExampleConsideration extends Consideration<IntrospectionBeliefs> {
  @override
  Future<void> consider(
      BeliefSystem<IntrospectionBeliefs> beliefSystem) async {}

  @override
  toJson() => {'name_': 'TestAwayMission', 'state_': {}};
}

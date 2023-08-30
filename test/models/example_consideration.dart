import 'package:introspection/introspection.dart';
import 'package:abstractions/beliefs.dart';

class ExampleConsideration extends Consideration<IntrospectionBeliefs> {
  @override
  Future<void> consider(
      BeliefSystem<IntrospectionBeliefs> beliefSystem) async {}

  @override
  toJson() => {'name_': 'TestAwayMission', 'state_': {}};
}

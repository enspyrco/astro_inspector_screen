import 'package:abstractions/beliefs.dart';

import '../beliefs/example_beliefs.dart';
import 'example_updated.dart';

class GettingExample extends Consideration<ExampleBeliefs> {
  GettingExample();

  @override
  Future<void> consider(BeliefSystem<ExampleBeliefs> beliefSystem) async {
    for (int i = 0; i < 5; i++) {
      beliefSystem.conclude(const ExampleUpdated(
          'A very very very very very very very very very very very very very very very very very very long string'));
    }
  }

  @override
  toJson() => {'name_': 'GettingExample', 'state_': <String, Object?>{}};
}

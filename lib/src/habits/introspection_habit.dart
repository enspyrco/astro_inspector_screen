import 'dart:async';

import 'package:json_utils/json_utils.dart';
import 'package:abstractions/beliefs.dart';

class IntrospectionHabit<T extends CoreBeliefs> extends Habit<T> {
  final StreamController<JsonMap> _controller =
      StreamController<JsonMap>.broadcast();
  Stream<JsonMap> get stream => _controller.stream;

  @override
  void call(BeliefSystem beliefSystem, Cognition cognition) async {
    // Emit json describing the cognition and (potential) belief updates.
    _controller.add({
      'data': {
        'beliefs': beliefSystem.beliefs.toJson(),
        'cognition': cognition.toJson()
          ..['id_'] = cognition.hashCode
          ..['type_'] = cognition is Consideration ? 'consider' : 'conclude'
      },
      'type': 'perception:cognitive_process',
    });

    // Post an event with state change information that our
    // Flutter DevTools plugin can listen for.
    // postEvent('perception:cognitive_process', {
    //   'beliefs': beliefSystem.beliefs.toJson(),
    //   'cognition': cognition.toJson(),
    // });
  }
}

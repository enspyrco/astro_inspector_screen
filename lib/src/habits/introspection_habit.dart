import 'dart:async';

import 'package:json_utils/json_utils.dart';
import 'package:abstractions/beliefs.dart';

class IntrospectionHabit<T extends CoreBeliefs> extends Habit<T> {
  final StreamController<JsonMap> _controller =
      StreamController<JsonMap>.broadcast();
  Stream<JsonMap> get stream => _controller.stream;

  @override
  void call(BeliefSystem beliefSystem, Cognition cognition) async {
    // Emit json describing the mission and (potential) state change on
    // each mission.
    _controller.add({
      'data': {
        'state': beliefSystem.beliefs.toJson(),
        'mission': cognition.toJson()
          ..['id_'] = cognition.hashCode
          ..['type_'] = cognition is Consideration ? 'async' : 'sync'
      },
      'type': 'astro:mission_update',
    });

    // Post an event with state change information that our
    // Flutter DevTools plugin can listen for.
    // postEvent('astro:mission_update', {
    //   'state': beliefSystem.state.toJson(),
    //   'mission': mission.toJson(),
    // });
  }
}

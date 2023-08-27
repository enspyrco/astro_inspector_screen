import 'dart:async';

import 'package:json_utils/json_utils.dart';
import 'package:types_for_perception/beliefs.dart';

class SendMissionReportsToInspector<T extends CoreBeliefs>
    extends SystemCheck<T> {
  final StreamController<JsonMap> _controller =
      StreamController<JsonMap>.broadcast();
  Stream<JsonMap> get stream => _controller.stream;

  @override
  void call(MissionControl missionControl, Mission mission) async {
    // Emit json describing the mission and (potential) state change on
    // each mission.
    _controller.add({
      'data': {
        'state': missionControl.state.toJson(),
        'mission': mission.toJson()
          ..['id_'] = mission.hashCode
          ..['type_'] = mission is AwayMission ? 'async' : 'sync'
      },
      'type': 'astro:mission_update',
    });

    // Post an event with state change information that our
    // Flutter DevTools plugin can listen for.
    // postEvent('astro:mission_update', {
    //   'state': missionControl.state.toJson(),
    //   'mission': mission.toJson(),
    // });
  }
}

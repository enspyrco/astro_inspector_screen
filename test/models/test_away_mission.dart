import 'package:inspector_for_perception/inspector_for_perception.dart';
import 'package:types_for_perception/beliefs.dart';

class TestAwayMission extends AwayMission<InspectorState> {
  @override
  Future<void> flightPlan(
      MissionControl<InspectorState> missionControl) async {}

  @override
  toJson() => {'name_': 'TestAwayMission', 'state_': {}};
}

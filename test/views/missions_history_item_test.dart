import 'package:inspector_for_perception/inspector_for_perception.dart';
import 'package:inspector_for_perception/src/missions/add_mission_report.dart';
import 'package:inspector_for_perception/src/missions/select_mission.dart';
import 'package:inspector_for_perception/src/views/missions_history_view/missions_history_item.dart';
import 'package:test_utils_for_perception/astro_widgets_test_utils.dart';
import 'package:types_for_perception/json_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../models/test_away_mission.dart';

void main() {
  testWidgets('MissionsHistoryItem starts SelectMission on tap',
      (tester) async {
    const String missionName = 'Mission Name';
    const String missionType = 'MissionType';
    const JsonMap missionState = {'mission': {}};
    const index = 0;

    var widgetUnderTest = const MissionsHistoryItem(
      missionName: missionName,
      missionType: missionType,
      missionState: missionState,
      index: index,
    );

    var harness = WidgetTestHarness(
      initialState: InspectorState.initial,
      innerWidget: widgetUnderTest,
    );

    await tester.pumpWidget(harness.widget);

    /// When [SelectMission] is landed by the [widgetUnderTest], we need
    /// the [InspectorState] to have appropriate data or the [land] function will throw.
    /// We could just add appropriate initial state but I think it is clearer
    /// and a better test to start missions to setup the state.

    final testMission = TestAwayMission();

    /// Setup the [InspectorState] as if the inspected app launched a [TestAwayMission]
    /// The json injected into [AddMissionUpate] is created by the
    /// [SendMissionReportToInspector] system check.
    harness.land(AddMissionReport({
      'state': InspectorState.initial.toJson(),
      'mission': TestAwayMission().toJson()
        ..['id_'] = testMission.hashCode
        ..['type_'] = 'async'
    }));

    await tester.tap(find.byType(MissionsHistoryItem));

    // check that the expected mission was launched by the widget
    expect(
        harness.recordedMissions, containsA<SelectMission>(withIndex: index));
  });
}

Matcher containsA<T extends SelectMission>({required int withIndex}) {
  return contains(predicate((a) => a is T && a.index == withIndex));
}

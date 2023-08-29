import 'package:introspection/introspection.dart';
import 'package:introspection/src/cognition/add_cognitive_process.dart';
import 'package:introspection/src/cognition/select_mission.dart';
import 'package:introspection/src/views/cognition_history/cognition_history_item.dart';
import 'package:json_utils/json_utils.dart';
import 'package:test_utils_for_perception/test_utils_for_perception.dart';
import 'package:flutter_test/flutter_test.dart';

import '../models/example_consideration.dart';

void main() {
  testWidgets('MissionsHistoryItem starts SelectMission on tap',
      (tester) async {
    const String missionName = 'Mission Name';
    const String missionType = 'MissionType';
    const JsonMap missionState = {'mission': {}};
    const index = 0;

    var widgetUnderTest = const CognitionHistoryItem(
      missionName: missionName,
      missionType: missionType,
      missionState: missionState,
      index: index,
    );

    var harness = WidgetTestHarness(
      initialState: IntrospectionBeliefs.initial,
      innerWidget: widgetUnderTest,
    );

    await tester.pumpWidget(harness.widget);

    /// When [SelectMission] is landed by the [widgetUnderTest], we need
    /// the [InspectorState] to have appropriate data or the [land] function will throw.
    /// We could just add appropriate initial state but I think it is clearer
    /// and a better test to start missions to setup the state.

    final testMission = ExampleConsideration();

    /// Setup the [InspectorState] as if the inspected app launched a [TestAwayMission]
    /// The json injected into [AddMissionUpate] is created by the
    /// [SendMissionReportToInspector] system check.
    harness.land(AddCognitiveProcess({
      'state': IntrospectionBeliefs.initial.toJson(),
      'mission': ExampleConsideration().toJson()
        ..['id_'] = testMission.hashCode
        ..['type_'] = 'async'
    }));

    await tester.tap(find.byType(CognitionHistoryItem));

    // check that the expected mission was launched by the widget
    expect(
        harness.recordedMissions, containsA<SelectMission>(withIndex: index));
  });
}

Matcher containsA<T extends SelectMission>({required int withIndex}) {
  return contains(predicate((a) => a is T && a.index == withIndex));
}

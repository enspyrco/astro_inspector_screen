import 'package:introspection/src/beliefs/introspection_beliefs.dart';
import 'package:introspection/src/cognition/cognitive_process_added.dart';
import 'package:introspection/src/cognition/cognition_selected.dart';
import 'package:introspection/src/views/cognitions/cognition_view.dart';
import 'package:json_utils/json_utils.dart';
import 'package:test_utils_for_perception/test_utils_for_perception.dart';
import 'package:flutter_test/flutter_test.dart';

import '../models/example_consideration.dart';

void main() {
  testWidgets('CognitionView starts SelectCognition on tap', (tester) async {
    const String cognitionName = 'Mission Name';
    const String cognitionType = 'MissionType';
    const JsonMap cognitionValues = {'cognition': {}};
    const index = 0;

    var widgetUnderTest = const CognitionView(
      cognitionName: cognitionName,
      cognitionType: cognitionType,
      cognitionValues: cognitionValues,
      index: index,
    );

    var harness = WidgetTestHarness(
      initialBeliefs: IntrospectionBeliefs.initial,
      innerWidget: widgetUnderTest,
    );

    await tester.pumpWidget(harness.widget);

    /// When [SelectMission] is landed by the [widgetUnderTest], we need
    /// the [InspectorState] to have appropriate data or the [land] function will throw.
    /// We could just add appropriate initial state but I think it is clearer
    /// and a better test to start cognitions to setup the state.

    final testMission = ExampleConsideration();

    /// Setup the [InspectorState] as if the inspected app launched a [TestAwayMission]
    /// The json injected into [AddMissionUpate] is created by the
    /// [SendMissionReportToInspector] system check.
    harness.conclude(CognitiveProcessAdded({
      'beliefs': IntrospectionBeliefs.initial.toJson(),
      'cognition': ExampleConsideration().toJson()
        ..['id_'] = testMission.hashCode
        ..['type_'] = 'consider'
    }));

    await tester.tap(find.byType(CognitionView));

    // check that the expected cognition was considered by the widget
    expect(harness.recordedCognitions,
        containsA<CognitionSelected>(withIndex: index));
  });
}

Matcher containsA<T extends CognitionSelected>({required int withIndex}) {
  return contains(predicate((a) => a is T && a.index == withIndex));
}

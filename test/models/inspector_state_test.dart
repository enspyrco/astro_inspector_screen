import 'package:inspector_for_perception/src/state/inspector_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('InspectorState.addMissionReport throws on invalid input', () {
    var state = InspectorState.initial;
    // expect(() => state.addMissionReport({}),
    //     throwsA('added json has no `mission` key'));
    // expect(() => missionReports.add({'mission': 'blah'}),
    // throwsA(isA<_TypeError>()));
  });
}

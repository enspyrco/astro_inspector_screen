library inspector_for_perception;

import 'package:core_of_perception/core_of_perception.dart';
import 'package:json_utils/json_utils.dart';
import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:flutter/widgets.dart';
import 'package:types_for_perception/beliefs.dart';

import 'inspector_for_perception.dart';
import 'src/views/main_view.dart';

export 'initialize_inspector_for_perception.dart';
export 'src/missions/parenting_mission_control.dart';
export 'src/state/inspector_state.dart';
export 'src/system-checks/send_mission_reports_to_inspector.dart';

/// Visualise the data flow of an app by adding a [AstroInspectorScreen] widget
/// and passing in the [_onMissionReport] stream from the astro [MissionControl].
/// When used by the Inspector plugin, `serviceManager.service?.onExtensionEvent`
/// is transformed to a Stream<ReduxStateEvent>.
///
/// At this time, an event is either
/// - a 'mission update', consisting of the mission object and any corresponding
///   state change.
/// - a 'remove all' event to clear the mission updates data.
class AstroInspectorScreen extends StatefulWidget {
  const AstroInspectorScreen(this._onMissionReport, {super.key});

  final Stream<JsonMap>? _onMissionReport;

  @override
  State<AstroInspectorScreen> createState() => _AstroInspectorScreenState();
}

class _AstroInspectorScreenState extends State<AstroInspectorScreen> {
  @override
  void initState() {
    super.initState();
    Locator.add<MissionControl<InspectorState>>(
        DefaultMissionControl<InspectorState>(state: InspectorState.initial));
  }

  @override
  Widget build(BuildContext context) {
    return MainView(widget._onMissionReport);
  }
}

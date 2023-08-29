library introspection;

import 'package:percepts/percepts.dart';
import 'package:json_utils/json_utils.dart';
import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:flutter/widgets.dart';
import 'package:abstractions/beliefs.dart';

import 'introspection.dart';
import 'src/views/main_view.dart';

export 'initialize_introspection.dart';
export 'src/cognition/parenting_belief_system.dart';
export 'src/state/introspection_beliefs.dart';
export 'src/habits/introspection_habit.dart';

/// Visualise the data flow of an app by adding a [AstroInspectorScreen] widget
/// and passing in the [_onMissionReport] stream from the astro [BeliefSystem].
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
    Locator.add<BeliefSystem<IntrospectionBeliefs>>(
        DefaultBeliefSystem<IntrospectionBeliefs>(
            state: IntrospectionBeliefs.initial));
  }

  @override
  Widget build(BuildContext context) {
    return MainView(widget._onMissionReport);
  }
}

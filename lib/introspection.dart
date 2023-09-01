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

/// Visualise the data flow of an app by adding a [IntrospectionScreen] widget
/// and passing in the [_onCognition] stream from the [BeliefSystem].
/// When used by the introspection plugin, `serviceManager.service?.onExtensionEvent`
/// is transformed to a Stream<ReduxStateEvent>.
///
/// At this time, an event is either
/// - a 'mission update', consisting of the mission object and any corresponding
///   state change.
/// - a 'remove all' event to clear the mission updates data.
class IntrospectionScreen extends StatefulWidget {
  const IntrospectionScreen(this._onCognition, {super.key});

  final Stream<JsonMap>? _onCognition;

  @override
  State<IntrospectionScreen> createState() => _IntrospectionScreenState();
}

class _IntrospectionScreenState extends State<IntrospectionScreen> {
  @override
  void initState() {
    super.initState();
    Locator.add<BeliefSystem<IntrospectionBeliefs>>(
        DefaultBeliefSystem<IntrospectionBeliefs>(
            state: IntrospectionBeliefs.initial));
  }

  @override
  Widget build(BuildContext context) {
    return MainView(widget._onCognition);
  }
}

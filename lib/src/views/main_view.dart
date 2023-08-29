import 'dart:async';

import 'package:error_correction_in_perception/error_correction_in_perception.dart';
import 'package:json_utils/json_utils.dart';
import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:flutter/widgets.dart';
import 'package:abstractions/beliefs.dart';

import '../../introspection.dart';
import '../cognition/add_cognitive_process.dart';
import '../cognition/remove_all.dart';
import 'app_state_view/app_state_view.dart';
import 'cognition_history/cognition_history_view.dart';

/// The [MainView] lays out the [CognitionHistoryView] and [AppStateView].
///
/// The [MainView] takes a [Stream] of mission updates from [BeliefSystem],
/// listens to the stream and starts an appropriate Mission (as we are also
/// using astro for our state management) for each incoming event.
class MainView extends StatefulWidget {
  const MainView(this._onMissionReport, {super.key});

  final Stream<JsonMap>? _onMissionReport;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  StreamSubscription<JsonMap>? _subscription;

  @override
  void initState() {
    super.initState();

    if (widget._onMissionReport != null) {
      _subscription = widget._onMissionReport!.listen(
        (update) {
          if (update['type'] == 'astro:mission_update') {
            locate<BeliefSystem<IntrospectionBeliefs>>()
                .conclude(AddCognitiveProcess(update['data'] as JsonMap));
          } else if (update['type'] == 'astro:remove_all') {
            locate<BeliefSystem<IntrospectionBeliefs>>().conclude(RemoveAll());
          }
        },
        onError: (Object error, StackTrace trace) =>
            locate<BeliefSystem<IntrospectionBeliefs>>().conclude(
          CreateErrorReport(error, trace),
        ),
      );
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (widget._onMissionReport == null)
        ? const Text('Not connected to app...')
        : Row(
            children: [
              const CognitionHistoryView(),
              AppStateView(),
            ],
          );
  }
}

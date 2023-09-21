import 'dart:async';

import 'package:error_correction_in_perception/error_correction_in_perception.dart';
import 'package:json_utils/json_utils.dart';
import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:flutter/widgets.dart';
import 'package:abstractions/beliefs.dart';

import '../beliefs/introspection_beliefs.dart';
import '../cognition/cognitive_process_added.dart';
import '../cognition/remove_all.dart';
import 'beliefs_view/beliefs_view.dart';
import 'cognitions/cognitions_list_view.dart';

/// The [IntrospectionView] lays out the [CognitionsListView] and [BeliefsView].
///
/// The [IntrospectionView] takes a [Stream] of cognitive processed from the
/// [BeliefSystem], listens to the stream and starts an appropriate Cognition
/// (as we are also using perception for our state management) for each incoming
/// event.
class IntrospectionView extends StatefulWidget {
  const IntrospectionView(this._onMissionReport, {super.key});

  final Stream<JsonMap>? _onMissionReport;

  @override
  State<IntrospectionView> createState() => _IntrospectionViewState();
}

class _IntrospectionViewState extends State<IntrospectionView> {
  StreamSubscription<JsonMap>? _subscription;

  @override
  void initState() {
    super.initState();

    if (widget._onMissionReport != null) {
      _subscription = widget._onMissionReport!.listen(
        (update) {
          if (update['type'] == 'perception:cognitive_process') {
            locate<BeliefSystem<IntrospectionBeliefs>>()
                .conclude(CognitiveProcessAdded(update['data'] as JsonMap));
          } else if (update['type'] == 'perception:remove_all') {
            locate<BeliefSystem<IntrospectionBeliefs>>().conclude(RemoveAll());
          }
        },
        onError: (Object error, StackTrace trace) =>
            locate<BeliefSystem<IntrospectionBeliefs>>().conclude(
          CreateFeedback(error, trace),
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
              const CognitionsListView(),
              BeliefsView(),
            ],
          );
  }
}

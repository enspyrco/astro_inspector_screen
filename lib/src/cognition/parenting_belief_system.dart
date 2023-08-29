import 'package:abstractions/beliefs.dart';

import 'parented_cognition.dart';

/// An [AwayBeliefSystem] object is created by [BeliefSystem] on each call
/// to [AwayMision.flightPlan] for the purpose of allowing land/launch calls
/// inside `flightPlan` to automatically set the parent.
///
/// The call to `launch` & `land` is just passed on to [BeliefSystem.consider] &
/// [BeliefSystem.conclude], while setting the `parent` member of the mission.
class ParentingBeliefSystem<S extends CoreBeliefs> implements BeliefSystem<S> {
  ParentingBeliefSystem(
      BeliefSystem<S> beliefSystem, Consideration<S> currentMission)
      : _beliefSystem = beliefSystem,
        _currentMission = currentMission;
  final BeliefSystem<S> _beliefSystem;
  final Consideration<S> _currentMission;

  @override
  void conclude(Conclusion<S> mission) =>
      _beliefSystem.conclude(ParentedConclusion(mission, _currentMission));

  @override
  Future<void> consider(Consideration<S> mission) =>
      _beliefSystem.consider(ParentedConsideration(mission, _currentMission));

  @override
  Stream<S> get onBeliefUpdate => _beliefSystem.onBeliefUpdate;

  @override
  S get state => _beliefSystem.state;
}

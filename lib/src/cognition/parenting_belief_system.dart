import 'package:abstractions/beliefs.dart';

import 'parented_cognition.dart';

/// A [ParentingBeliefSystem] object is created by [BeliefSystem] on each call
/// to [Consideration.consider] for the purpose of allowing conclude/consider
/// calls inside `consider` to automatically set the parent.
///
/// The call to `consider` & `conclude` is just passed on to [BeliefSystem.consider]
/// & [BeliefSystem.conclude], while setting the `parent` member of the cognition.
class ParentingBeliefSystem<S extends CoreBeliefs> implements BeliefSystem<S> {
  ParentingBeliefSystem(
      BeliefSystem<S> beliefSystem, Consideration<S> currentConsideration)
      : _beliefSystem = beliefSystem,
        _currentConsideration = currentConsideration;
  final BeliefSystem<S> _beliefSystem;
  final Consideration<S> _currentConsideration;

  @override
  void conclude(Conclusion<S> conclusion) => _beliefSystem
      .conclude(ParentedConclusion(conclusion, _currentConsideration));

  @override
  Future<void> consider(Consideration<S> consideration) => _beliefSystem
      .consider(ParentedConsideration(consideration, _currentConsideration));

  @override
  Stream<S> get onBeliefUpdate => _beliefSystem.onBeliefUpdate;

  @override
  S get beliefs => _beliefSystem.beliefs;
}

import 'package:json_utils/json_utils.dart';
import 'package:abstractions/beliefs.dart';

class ParentedConclusion<S extends CoreBeliefs> implements Conclusion<S> {
  ParentedConclusion(this._conclusion, this.parent);

  // The inner mission, wrapped by this class
  final Conclusion<S> _conclusion;

  // The mission that created _mission
  final Consideration<S>? parent;

  @override
  JsonMap toJson() => {
        'name_': _conclusion.toJson()['name_'],
        'state_': _conclusion.toJson()['state_'],
        'type_': 'sync',
        'id_': _conclusion.hashCode,
        'parent_': parent?.hashCode,
      };

  @override
  S update(S state) => _conclusion.update(state);
}

class ParentedConsideration<S extends CoreBeliefs> implements Consideration<S> {
  ParentedConsideration(this._consideration, this.parent);

  // The inner mission, wrapped by this class
  final Consideration<S> _consideration;

  // The mission that created _mission
  final Consideration<S>? parent;

  @override
  JsonMap toJson() => {
        'name_': _consideration.toJson()['name_'],
        'state_': _consideration.toJson()['state_'],
        'type_': 'async',
        'id_': _consideration.hashCode,
        'parent_': parent?.hashCode,
      };

  @override
  Future<void> process(BeliefSystem<S> beliefSystem) =>
      _consideration.process(beliefSystem);
}

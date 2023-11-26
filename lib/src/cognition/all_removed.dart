import 'package:abstractions/beliefs.dart';

import '../beliefs/introspection_beliefs.dart';

/// A [AllRemoved] Conclusion is started when the app sends a
/// `remove_all` event to reset the IntrospectionView.
class AllRemoved extends Conclusion<IntrospectionBeliefs> {
  @override
  IntrospectionBeliefs conclude(beliefs) =>
      beliefs.copyWith(selectedIndex: null, cognitiveProcesses: []);

  @override
  toJson() => {'name_': 'RemoveAll', 'state_': <String, dynamic>{}};
}

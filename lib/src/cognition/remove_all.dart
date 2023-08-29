import 'package:abstractions/beliefs.dart';

import '../state/introspection_beliefs.dart';

/// A [RemoveAll] landing mission is started when the app sends a
/// `remove_all` event to reset the Inspector Screen.
class RemoveAll extends Conclusion<IntrospectionBeliefs> {
  @override
  IntrospectionBeliefs update(state) =>
      state.copyWith(selectedIndex: null, missionReports: []);

  @override
  toJson() => {'name_': 'RemoveAll', 'state_': <String, dynamic>{}};
}

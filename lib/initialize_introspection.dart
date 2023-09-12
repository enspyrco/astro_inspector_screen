import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:abstractions/beliefs.dart';

import 'src/habits/introspection_habit.dart';

void initializeIntrospection<S extends CoreBeliefs>() {
  if (const bool.fromEnvironment('IN-APP-INTROSPECTION')) {
    /// Create a Habit that sends cognitive processes to instrospection
    final sendCognitiveProcesses = IntrospectionHabit<S>();

    /// Add the habit to Locator so introspection can access the stream of cognitive processes
    Locator.add<IntrospectionHabit>(sendCognitiveProcesses);

    /// Add the habit to preConsideration & postConclusion habits so all
    /// cognitive processes are created and sent at the appropriate point.
    locate<Habits>().preConsideration.add(sendCognitiveProcesses);
    locate<Habits>().postConclusion.add(sendCognitiveProcesses);
  }
}

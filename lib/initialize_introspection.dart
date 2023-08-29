import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:abstractions/beliefs.dart';

import 'src/habits/introspection_habit.dart';

void initializeIntrospection<S extends CoreBeliefs>() {
  if (const bool.fromEnvironment('IN-APP-ASTRO-INSPECTOR')) {
    /// Create a SystemCheck that sends mission updates to the Inspector
    final sendMissionReports = IntrospectionHabit<S>();

    /// Add the system check to Locator so the Inspector can access the stream of mission reports
    Locator.add<IntrospectionHabit>(sendMissionReports);

    /// Add the system check to the preLaunch & postLand lists so all mission reports
    /// are created and sent at the appropriate point.
    locate<Habits>().preConsideration.add(sendMissionReports);
    locate<Habits>().postConclusion.add(sendMissionReports);
  }
}

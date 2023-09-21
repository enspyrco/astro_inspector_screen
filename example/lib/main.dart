import 'package:abstractions/beliefs.dart';
import 'package:flutter/material.dart';
import 'package:introspection/introspection.dart';
import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:percepts/percepts.dart';

import 'beliefs/example_beliefs.dart';
import 'views/example_screen.dart';

void main() async {
  // First check if the required dart-define has been set
  if (const bool.fromEnvironment('IN-APP-INTROSPECTION') != true) {
    throw 'The example must be run with a dart-define of \'IN-APP-INTROSPECTION\'=true set.\n'
        'One way to do so is to use the "introspection-example" VS Code launch config.';
  }

  // Set up percepts
  Locator.add<Habits>(DefaultHabits());
  Locator.add<ExampleBeliefs>(ExampleBeliefs.initial);
  initializeIntrospection<ExampleBeliefs>();
  final beliefSystem = DefaultBeliefSystem<ExampleBeliefs>(
      beliefs: locate<ExampleBeliefs>(),
      habits: locate<Habits>(),
      beliefSystemFactory: ParentingBeliefSystem.new);
  Locator.add<BeliefSystem<ExampleBeliefs>>(beliefSystem);

  runApp(
    MaterialApp(
      home: Row(
        children: [
          Expanded(
            flex: 1,
            child: Material(
              child: IntrospectionScreen(locate<IntrospectionHabit>().stream),
            ),
          ),
          const Expanded(flex: 1, child: ExampleScreen()),
        ],
      ),
    ),
  );
}

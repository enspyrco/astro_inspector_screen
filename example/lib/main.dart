import 'package:abstractions/beliefs.dart';
import 'package:flutter/material.dart';
import 'package:introspection/introspection.dart';
import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:percepts/percepts.dart';

import 'example_beliefs.dart';
import 'example_screen.dart';

void main() async {
  if (const bool.fromEnvironment('IN-APP-INTROSPECTION') != true) {
    throw 'The example must be run with a dart-define of \'IN-APP-INTROSPECTION\'=true set.\n'
        'One way to do so is to use the "introspection-example" VS Code launch config.';
  }

  Locator.add<Habits>(DefaultHabits());
  Locator.add<ExampleBeliefs>(ExampleBeliefs.initial);

  // The following will only work when run with a dart-define setting IN-APP-INTROSPECTION=true
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

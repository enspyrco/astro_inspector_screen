import 'package:abstractions/beliefs.dart';
import 'package:flutter/material.dart';
import 'package:locator_for_perception/locator_for_perception.dart';

import '../beliefs/example_beliefs.dart';
import '../cognition/getting_example.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  @override
  void initState() {
    super.initState();
    final beliefSystem = locate<BeliefSystem<ExampleBeliefs>>();
    beliefSystem.consider(GettingExample());
    beliefSystem.consider(GettingExample());
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('hello'),
    );
  }
}

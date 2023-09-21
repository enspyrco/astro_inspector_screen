import 'package:abstractions/beliefs.dart';

import '../beliefs/example_beliefs.dart';

class ExampleUpdated extends Conclusion<ExampleBeliefs> {
  const ExampleUpdated(this.newString);

  final String newString;

  @override
  ExampleBeliefs conclude(ExampleBeliefs beliefs) {
    return ExampleBeliefs(
      listOfStrings: [...beliefs.listOfStrings, newString],
      someObject: beliefs.someObject,
    );
  }

  @override
  toJson() => {
        'name_': 'ExampleConclusion',
        'state_': {'newString': newString},
      };
}

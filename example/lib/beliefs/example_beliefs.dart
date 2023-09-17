import 'package:abstractions/beliefs.dart';

class ExampleBeliefs implements CoreBeliefs {
  ExampleBeliefs({required this.listOfStrings, required this.someObject});

  final List<String> listOfStrings;
  final SomeObject someObject;

  static ExampleBeliefs get initial =>
      ExampleBeliefs(listOfStrings: [], someObject: SomeObject('title', 1.0));

  @override
  ExampleBeliefs copyWith({
    List<String>? listOfStrings,
    SomeObject? someObject,
  }) =>
      ExampleBeliefs(
        listOfStrings: listOfStrings ?? this.listOfStrings,
        someObject: someObject ?? this.someObject,
      );

  @override
  toJson() => {
        'listOfStrings': listOfStrings,
        'someObject': someObject.toJson(),
      };
}

class SomeObject {
  SomeObject(this.title, this.number);

  final String title;
  final double number;

  Map<String, Object?> toJson() => {'title': title, 'number': number};
}

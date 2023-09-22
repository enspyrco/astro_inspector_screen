import 'belief_node.dart';

class BeliefsViewModel {
  BeliefsViewModel(Map<String, Object?> json)
      : roots = json.keys.map((key) {
          return BeliefNode(title: key, json: json[key]);
        }).toList();

  final List<BeliefNode> roots;
}

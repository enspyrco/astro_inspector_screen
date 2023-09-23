import 'belief_node.dart';

class BeliefsViewModel {
  BeliefsViewModel(Map<String, Object?> json, Map<String, Object?> previousJson)
      : roots = json.keys.map((key) {
          return BeliefNode(
            value: key,
            json: json[key],
            previousJson: previousJson[key],
          );
        }).toList();

  final List<BeliefNode> roots;
}

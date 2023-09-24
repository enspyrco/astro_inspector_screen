import 'package:flutter/material.dart';

import '../../models/belief_node.dart';

class BeliefNodeView extends StatelessWidget {
  const BeliefNodeView({required this.node, super.key});

  final BeliefNode node;

  @override
  Widget build(BuildContext context) {
    final Color color = switch (node.status) {
      NodeStatus.unchanged => Colors.black,
      NodeStatus.added => Colors.green,
      NodeStatus.removed => Colors.red,
      _ => Colors.orange,
    };

    String maybeValue = '';
    if (node.children.isEmpty) {
      maybeValue = switch (node.type) {
        NodeType.list => ' : []',
        NodeType.object => ' : {}',
        _ => ' : ${node.value}',
      };
    }

    return Text(
      node.name + maybeValue,
      style: TextStyle(
        color: color,
      ),
    );
  }
}

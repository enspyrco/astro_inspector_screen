import 'package:flutter/material.dart';
import 'package:percepts/percepts.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';

import '../../beliefs/introspection_beliefs.dart';
import '../../models/belief_node.dart';
import '../../models/beliefs_view_model.dart';
import 'belief_node_view.dart';

class BeliefsView extends StatefulWidget {
  const BeliefsView({super.key});

  @override
  State<BeliefsView> createState() => _BeliefsViewState();
}

class _BeliefsViewState extends State<BeliefsView> {
  @override
  Widget build(BuildContext context) {
    return StreamOfConsciousness<IntrospectionBeliefs, BeliefsViewModel>(
      infer: (beliefs) =>
          BeliefsViewModel(beliefs.selectedState, beliefs.previousState),
      builder: (context, viewModel) {
        final treeController = TreeController<BeliefNode>(
          roots: viewModel.beliefs,
          childrenProvider: (BeliefNode node) => node.children,
        );

        return SizedBox(
          width: 300,
          child: AnimatedTreeView<BeliefNode>(
            treeController: treeController,
            nodeBuilder: (BuildContext context, TreeEntry<BeliefNode> entry) {
              return InkWell(
                onTap: () => treeController.toggleExpansion(entry.node),
                child: TreeIndentation(
                  entry: entry,
                  child: BeliefNodeView(node: entry.node),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

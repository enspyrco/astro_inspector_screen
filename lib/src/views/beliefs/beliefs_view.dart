import 'package:flutter/material.dart';
import 'package:percepts/percepts.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';

import '../../beliefs/introspection_beliefs.dart';
import 'belief_node.dart';
import 'beliefs_view_model.dart';

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
          roots: viewModel.roots,
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
                  child: switch (entry.node.category) {
                    NodeCategory.value => Text(
                        '${entry.node.value}',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    NodeCategory.valueAdded => Text(
                        '${entry.node.value}',
                        style: const TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    NodeCategory.valueRemoved => Text(
                        '${entry.node.value}',
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    NodeCategory.object => Text(
                        '${entry.node.value}',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    NodeCategory.objectAdded => Text(
                        '${entry.node.value}',
                        style: const TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    NodeCategory.objectRemoved => Text(
                        '${entry.node.value}',
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    NodeCategory.list => Text(
                        '${entry.node.value}',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    NodeCategory.listAdded => Text(
                        '${entry.node.value}',
                        style: const TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    NodeCategory.listRemoved => Text(
                        '${entry.node.value}',
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    _ => Text(
                        '${entry.node.value}',
                        style: const TextStyle(
                          color: Colors.orange,
                        ),
                      ),
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

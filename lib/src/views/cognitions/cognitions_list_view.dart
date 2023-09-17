import 'package:percepts/percepts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:json_utils/json_utils.dart';

import '../../beliefs/introspection_beliefs.dart';
import 'cognition_view.dart';

class CognitionsListView extends StatelessWidget {
  const CognitionsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5), // so starting space is same as the gaps
        Expanded(
          child: SizedBox(
            width: 300,
            child: StreamOfConsciousness<IntrospectionBeliefs, List<JsonMap>>(
                infer: (state) => state.cognitiveProcesses,
                builder: (context, cognitiveProcesses) {
                  return ListView.builder(
                      itemCount: cognitiveProcesses.length,
                      itemBuilder: (context, index) {
                        final cognitionData =
                            cognitiveProcesses[index]['cognition'] as JsonMap?;
                        if (cognitionData == null) {
                          return Container();
                        }
                        return CognitionView(
                          cognitionName:
                              cognitionData['name_'] as String? ?? '',
                          cognitionType:
                              cognitionData['type_'] as String? ?? '',
                          cognitionValues:
                              cognitionData['state_'] as JsonMap? ?? {},
                          index: index,
                        );
                      });
                }),
          ),
        )
      ],
    );
  }
}

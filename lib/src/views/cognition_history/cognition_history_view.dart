import 'package:percepts/percepts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:json_utils/json_utils.dart';

import '../../../introspection.dart';
import 'cognition_history_item.dart';

class CognitionHistoryView extends StatelessWidget {
  const CognitionHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5), // so starting space is same as the gaps
        Expanded(
          child: SizedBox(
            width: 300,
            child: StreamOfConsciousness<IntrospectionBeliefs, List<JsonMap>>(
                infer: (state) => state.missionReports,
                builder: (context, missionReports) {
                  return ListView.builder(
                      itemCount: missionReports.length,
                      itemBuilder: (context, index) {
                        final missionData =
                            missionReports[index]['mission'] as JsonMap?;
                        if (missionData == null) {
                          return Container();
                        }
                        return CognitionHistoryItem(
                          missionName: missionData['name_'] as String? ?? '',
                          missionType: missionData['type_'] as String? ?? '',
                          missionState: missionData['state_'] as JsonMap? ?? {},
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

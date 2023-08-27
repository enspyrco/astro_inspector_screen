import 'package:core_of_perception/core_of_perception.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:json_utils/json_utils.dart';

import '../../../inspector_for_perception.dart';
import 'missions_history_item.dart';

class MissionsHistoryView extends StatelessWidget {
  const MissionsHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5), // so starting space is same as the gaps
        Expanded(
          child: SizedBox(
            width: 300,
            child: OnStateChangeBuilder<InspectorState, List<JsonMap>>(
                transformer: (state) => state.missionReports,
                builder: (context, missionReports) {
                  return ListView.builder(
                      itemCount: missionReports.length,
                      itemBuilder: (context, index) {
                        final missionData =
                            missionReports[index]['mission'] as JsonMap?;
                        if (missionData == null) {
                          return Container();
                        }
                        return MissionsHistoryItem(
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

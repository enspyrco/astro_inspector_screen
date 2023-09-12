import 'package:percepts/percepts.dart';
import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:flutter/material.dart';
import 'package:abstractions/beliefs.dart';

import '../../beliefs/introspection_beliefs.dart';
import '../../beliefs/viewmodels/cognitive_process_view_model.dart';
import '../../cognition/select_cognition.dart';

class CognitionView extends StatelessWidget {
  const CognitionView({
    Key? key,
    required this.cognitionName,
    required this.cognitionType,
    required this.cognitionValues,
    required this.index,
  }) : super(key: key);

  final String cognitionName;
  final String cognitionType;
  final Map<String, dynamic> cognitionValues;
  final int index;

  @override
  Widget build(BuildContext context) {
    var isAsync = cognitionType == 'consider';

    return StreamOfConsciousness<IntrospectionBeliefs,
        CognitiveProcessViewModel>(infer: (state) {
      return CognitiveProcessViewModel(
          index == state.selectedIndex, state.lineageFor[index]?.shapeWidgets);
    }, builder: (context, vm) {
      return Stack(
        children: [
          SizedBox(
            height: 80,
            child: Padding(
              padding: EdgeInsets.only(
                  left: isAsync ? 5 : 20,
                  top: 5,
                  right: isAsync ? 20 : 5,
                  bottom: 5),
              child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: isAsync ? Colors.green : Colors.blue,
                        width: vm.isSelected ? 3 : 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  title: Text(cognitionName),
                  subtitle: vm.isSelected
                      ? Text(cognitionValues.toString())
                      : Container(),
                  onTap: () => locate<BeliefSystem<IntrospectionBeliefs>>()
                      .conclude(SelectCognition(index)),
                  tileColor: isAsync ? Colors.green[50] : Colors.blue[50]),
            ),
          ),
          if (vm.lineageShapes != null) ...vm.lineageShapes!
        ],
      );
    });
  }
}

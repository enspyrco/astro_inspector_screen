import 'package:error_correction_in_perception/error_correction_in_perception.dart';
import 'package:json_utils/json_utils.dart';
import 'package:abstractions/beliefs.dart';
import 'package:abstractions/error_correction.dart';
import 'package:collection/collection.dart';

import '../enums/lineage_shape.dart';

class IntrospectionBeliefs implements CoreBeliefs, ErrorCorrectionConcept {
  IntrospectionBeliefs(
      {required this.error,
      required this.cognitiveProcesses,
      required this.selectedIndex,
      required this.lineageFor,
      required this.indexFor});

  static IntrospectionBeliefs get initial => IntrospectionBeliefs(
        error: DefaultErrorCorrectionBeliefs.initial,
        cognitiveProcesses: UnmodifiableListView([]),
        selectedIndex: null,
        lineageFor: UnmodifiableMapView({}),
        indexFor: UnmodifiableMapView({}),
      );

  /// If there are errors (eg. decoding invalid json) we save an error message
  /// that the screen will display
  @override
  final DefaultErrorCorrectionBeliefs error;

  /// The list of cognitive processes, added to each time [BeliefSystem.consider] or
  /// [BeliefSystem.conclude] is called
  final List<JsonMap> cognitiveProcesses;

  /// [selectedIndex] is a nullable int, as 'nothing selected' is a valid state
  final int? selectedIndex;

  /// [indexFor] maps a cognition's id to its index in the list
  final Map<int, int> indexFor;

  /// [lineageFor] maps a cognition's index in the list to the appropriate lineage
  /// shape, which is drawn as part part of the list item
  final Map<int, LineageShape> lineageFor;

  /// Convenience getters to safely extract the current selected state and
  /// previous state from the [cognitiveProcesses]
  JsonMap get selectedState => (selectedIndex == null)
      ? {}
      : cognitiveProcesses[selectedIndex!]['beliefs'] as JsonMap;
  JsonMap get previousState => (selectedIndex == null || selectedIndex == 0)
      ? {}
      : cognitiveProcesses[selectedIndex! - 1]['beliefs'] as JsonMap;

  @override
  IntrospectionBeliefs copyWith(
      {DefaultErrorCorrectionBeliefs? error,
      List<JsonMap>? cognitiveProcesses,
      int? selectedIndex,
      Map<int, LineageShape>? lineageFor,
      Map<int, int>? indexFor}) {
    return IntrospectionBeliefs(
        error: error ?? this.error,
        cognitiveProcesses: cognitiveProcesses ?? this.cognitiveProcesses,
        selectedIndex: selectedIndex ?? this.selectedIndex,
        indexFor: indexFor ?? this.indexFor,
        lineageFor: lineageFor ?? this.lineageFor);
  }

  @override
  JsonMap toJson() => {
        'cognitiveProcesses':
            (cognitiveProcesses.isEmpty) ? {} : cognitiveProcesses.first,
        'error': error,
        'selectedIndex': selectedIndex,
        'lineageForIndex': lineageFor,
        'indexForCognitionId': indexFor
      };
}

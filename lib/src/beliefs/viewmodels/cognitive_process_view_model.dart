import 'package:flutter/widgets.dart';

/// ViewModel class for the [CognitiveProcess] widget
class CognitiveProcessViewModel {
  final bool isSelected;
  final List<Widget>? lineageShapes;

  CognitiveProcessViewModel(this.isSelected, this.lineageShapes);
}

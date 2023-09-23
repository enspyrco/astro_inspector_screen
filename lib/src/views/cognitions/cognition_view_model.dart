import 'package:flutter/widgets.dart';

/// ViewModel class for the [CognitionView]
class CognitionViewModel {
  final bool isSelected;
  final List<Widget>? lineageShapes;

  CognitionViewModel(this.isSelected, this.lineageShapes);
}

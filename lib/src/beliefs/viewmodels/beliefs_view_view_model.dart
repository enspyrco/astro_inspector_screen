import 'package:json_utils/json_utils.dart';

/// ViewModel class for the [BeliefsView] widget
class BeliefsViewViewModel {
  final JsonMap selectedAppState;
  final JsonMap previousAppState;

  BeliefsViewViewModel(this.selectedAppState, this.previousAppState);
}

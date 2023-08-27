import 'package:json_utils/json_utils.dart';

/// ViewModel class for the [AppStateView] widget
class AppStateViewViewModel {
  final JsonMap selectedAppState;
  final JsonMap previousAppState;

  AppStateViewViewModel(this.selectedAppState, this.previousAppState);
}

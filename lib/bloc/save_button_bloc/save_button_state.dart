part of 'save_button_bloc.dart';

abstract class SaveButtonState extends Equatable {
  final bool isSaveButtonEnabled = false;

  @override
  List<Object> get props => [];
}


class SaveButtonInitialState extends SaveButtonState {}

class SaveButtonEnabledState extends SaveButtonState {
  final bool isSaveButtonEnabled = true;
}

class SaveButtonDisabledState extends SaveButtonState {}

class SaveInProgressSaveButtonState extends SaveButtonState {
}

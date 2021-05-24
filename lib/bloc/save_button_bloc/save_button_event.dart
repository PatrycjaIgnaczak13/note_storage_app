part of 'save_button_bloc.dart';

abstract class SaveButtonEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialSaveButtonEvent extends SaveButtonEvent {}

class EnableSaveButtonEvent extends SaveButtonEvent {}

class DisableSaveButtonEvent extends SaveButtonEvent {}

class SaveInProgressSaveButtonEvent extends SaveButtonEvent {}
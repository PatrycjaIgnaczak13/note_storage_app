import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'save_button_event.dart';
part 'save_button_state.dart';

class SaveButtonBloc extends Bloc<SaveButtonEvent, SaveButtonState> {
  SaveButtonBloc() : super(SaveButtonInitialState());

  @override
  Stream<SaveButtonState> mapEventToState(
    SaveButtonEvent event,
  ) async* {
    if (event is InitialSaveButtonEvent) {
      yield* _mapInitialEventToState();
    }
    if (event is EnableSaveButtonEvent) {
      yield* _mapEnableSaveButtonEventToState();
    }
    if (event is DisableSaveButtonEvent) {
      yield* _mapDisableSaveButtonEventToState();
    }
    if (event is SaveInProgressSaveButtonEvent) {
      yield* _mapSaveInProgressSaveButtonEventToState();
    }
  }

  Stream<SaveButtonState> _mapInitialEventToState() async* {
    yield SaveButtonInitialState();
  }

  Stream<SaveButtonState> _mapEnableSaveButtonEventToState() async* {
    yield SaveButtonInitialState();
    yield SaveButtonEnabledState();
  }

  Stream<SaveButtonState> _mapDisableSaveButtonEventToState() async* {
    yield SaveButtonInitialState();
    yield SaveButtonDisabledState();
  }

  Stream<SaveButtonState> _mapSaveInProgressSaveButtonEventToState() async* {
    yield SaveInProgressSaveButtonState();
  }
}

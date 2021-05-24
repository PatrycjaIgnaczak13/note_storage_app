part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  @override
  List<Object> get props => [];
}

class NoteInitialState extends NoteState {}

class NoteListLoadingState extends NoteState {}

class AddNewNoteState extends NoteState {}

class NoteListLoadedState extends NoteState {
  NoteListLoadedState(this.noteList);

  final List<Note> noteList;
}

class AddTextToNewNoteState extends NoteState {
  AddTextToNewNoteState(this.text);

  final String text;
}

class ErrorNoteState extends NoteState {}
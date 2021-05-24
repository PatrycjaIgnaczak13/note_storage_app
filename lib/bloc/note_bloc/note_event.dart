part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialNoteEvent extends NoteEvent {}

class SaveNoteEvent extends NoteEvent {
  SaveNoteEvent(this.content, this.creationDate);

  late final String content;
  late final DateTime creationDate;
}

class AddTextToNewNoteEvent extends NoteEvent {
  AddTextToNewNoteEvent(this.text);

  final String text;
}



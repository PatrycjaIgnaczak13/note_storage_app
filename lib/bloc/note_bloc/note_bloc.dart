import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notestorage/models/note.dart';
import 'package:notestorage/services/note_database_service.dart';

part 'note_event.dart';

part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {

  NoteBloc(this._noteDatabaseService) : super(NoteInitialState());

  final NoteDatabaseService _noteDatabaseService;

  List<Note> _noteList = [];

  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    if (event is InitialNoteEvent) {
      yield* _mapInitialEventToState();
    }
    if (event is SaveNoteEvent) {
      yield* _mapAddNoteEventToStateWithMockedResponse(
          event.content, event.creationDate);
    }
    if (event is AddTextToNewNoteEvent) {
      yield NoteListLoadingState();
      yield AddTextToNewNoteState(event.text);
    }
  }

  Stream<NoteState> _mapInitialEventToState() async* {
    yield NoteListLoadingState();
    await _getNotes();
    yield NoteListLoadedState(_noteList);
  }

  Future<void> _getNotes() async {
    await _noteDatabaseService.getNoteList().then((value) {
      _noteList = value;
    });
  }

  Stream<NoteState> _mapAddNoteEventToState(
      String content, DateTime creationDate) async* {
    yield NoteListLoadingState();
    await _addNote(content, creationDate);
    yield NoteListLoadedState(_noteList);
  }

  Future<void> _addNote(String content, DateTime creationDate) async {
    await _noteDatabaseService
        .addToBox(Note(content: content, creationDate: creationDate));
    await _getNotes();
  }

  //mocked response for testing purposes only
  Stream<NoteState> _mapAddNoteEventToStateWithMockedResponse(
      String content, DateTime creationDate) async* {
    yield NoteListLoadingState();
    final bool response =
        await Future<bool>.delayed(const Duration(seconds: 2), () async {
      return _addNoteWithMockedResponse(content, creationDate);
    });
    yield response ? NoteListLoadedState(_noteList) : ErrorNoteState();
  }

  Future<bool> _addNoteWithMockedResponse(
      String content, DateTime creationDate) async {
    final bool mockedSuccess = Random().nextBool();

    if (mockedSuccess) {
      _noteDatabaseService
          .addToBox(Note(content: content, creationDate: creationDate));
      await _getNotes();
    }
    return mockedSuccess;
  }
}

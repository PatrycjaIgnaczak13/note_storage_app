import 'package:hive/hive.dart';
import 'package:notestorage/models/note.dart';

import '../utilities/constants.dart';

class NoteDatabaseService {

  factory NoteDatabaseService() {
    return _noteDatabaseService;
  }

  NoteDatabaseService._internal();

  static final NoteDatabaseService _noteDatabaseService = NoteDatabaseService
      ._internal();

  Future<Box<Note>> openNoteBox() async {
    final Box<Note> box = await Hive.openBox<Note>(noteBoxName);
    return box;
  }

  Future<List<Note>> getNoteList() async {
    final Box<Note> box = await openNoteBox();
    final List<Note> notes = box.values.toList().reversed.toList();
    return notes;
  }

  Future<void> addToBox(Note note) async {
    final Box<Note> box = await openNoteBox();
    await box.add(note);
  }

  Future<void> clearNoteBox() async {
    final Box<Note> box = await openNoteBox();
    await box.clear();
  }

}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notestorage/services/note_database_service.dart';

import 'bloc/note_bloc/note_bloc.dart';
import 'models/note.dart';
import 'note_storage_app.dart';

Future<void> main() async {
  await initHive();
  runApp(BlocProvider<NoteBloc>(
    create: (context) =>
    NoteBloc(NoteDatabaseService())
      ..add(InitialNoteEvent()),
    child: NoteStorageApp(),
  ));
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Note>(NoteAdapter());
}
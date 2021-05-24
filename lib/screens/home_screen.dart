import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notestorage/bloc/note_bloc/note_bloc.dart';
import 'package:notestorage/models/note.dart';
import 'package:notestorage/utilities/strings.dart';
import 'package:notestorage/utilities/style_utils.dart';

import 'add_note_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.of(context).notes),
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteListLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is NoteListLoadedState) {
            final List<Note> noteList = state.noteList;
            return noteList.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 60.0),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: noteList.length,
                    itemBuilder: (context, index) {
                      Note note = noteList[index];
                      return NoteCard(note: note);
                    },
                  )
                : Container();
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onAddNotePressed(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onAddNotePressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddNoteScreen(),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({Key? key, required this.note}) : super(key: key);

  final Note note;
  static const double _minNoteHeight = 80.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      color: noteBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: _minNoteHeight),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(note.content,
                    textAlign: TextAlign.center, style: noteContentStyle),
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4.0, 4.0, 8.0, 8.0),
                child: Text(
                  DateFormat(Strings.of(context).dateFormat)
                      .format(note.creationDate),
                  style: noteCreationDateStyle,
                ),
              )),
        ],
      ),
    );
  }
}

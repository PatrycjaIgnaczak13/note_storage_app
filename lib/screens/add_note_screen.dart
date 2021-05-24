import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notestorage/bloc/save_button_bloc/save_button_bloc.dart';
import 'package:notestorage/bloc/note_bloc/note_bloc.dart';
import 'package:notestorage/utilities/style_utils.dart';
import '../utilities/strings.dart';

class AddNoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SaveButtonBloc>(
      create: (context) => SaveButtonBloc(),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(Strings.of(context).addNote),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  BlocProvider.of<NoteBloc>(context).add(InitialNoteEvent());
                }),
          ),
          body: NewNote(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FractionallySizedBox(
              widthFactor: 0.6, child: FloatingSaveButton()),
        ),
      ),
    );
  }
}

class NewNote extends StatelessWidget {
  final int _minLineNumber = 3;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      color: noteBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SaveButtonBloc, SaveButtonState>(
          builder: (context, state) {
            return TextField(
              onChanged: (String text) {
                _onTextChanged(text, context);
              },
              maxLines: null,
              minLines: _minLineNumber,
              decoration: InputDecoration(
                labelText: Strings.of(context).yourNote,
                alignLabelWithHint: true,
                labelStyle: newNoteLabelStyle,
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
              cursorColor: newNoteCursorColor,
            );
          },
        ),
      ),
    );
  }

  void _onTextChanged(String text, BuildContext context) {
    _addTextAddedEventToNoteBloc(text, context);

    text.trim().isNotEmpty
        ? _addEnableButtonEventToSaveButtonBloc(context)
        : _addDisableButtonEventToSaveButtonBloc(context);
  }

  void _addTextAddedEventToNoteBloc(String text, BuildContext context) {
    BlocProvider.of<NoteBloc>(context).add(AddTextToNewNoteEvent(text));
  }

  void _addEnableButtonEventToSaveButtonBloc(BuildContext context) {
    BlocProvider.of<SaveButtonBloc>(context).add(EnableSaveButtonEvent());
  }

  void _addDisableButtonEventToSaveButtonBloc(BuildContext context) {
    BlocProvider.of<SaveButtonBloc>(context).add(DisableSaveButtonEvent());
  }
}

class FloatingSaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? text;
    return BlocListener<NoteBloc, NoteState>(
      listener: (context, state) {
        if (state is ErrorNoteState) {
          _showErrorSnackBar(context);
          _addEnableButtonEventToSaveButtonBloc(context);
        }
        if (state is AddTextToNewNoteState) {
          text = state.text;
        }
        if (state is NoteListLoadedState) {
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<SaveButtonBloc, SaveButtonState>(
        builder: (context, state) {
          if (state is SaveInProgressSaveButtonState) {
            return const Align(
              alignment: Alignment.bottomCenter,
              child: CircularProgressIndicator(),
            );
          } else {
            final bool isSavePossible =
                state.isSaveButtonEnabled && state is SaveButtonEnabledState;
            return FloatingActionButton.extended(
              onPressed: isSavePossible
                  ? () {
                      _onSaveButtonPressed(context, text!);
                    }
                  : null,
              backgroundColor: isSavePossible
                  ? enabledButtonBackgroundColor
                  : disabledButtonBackgroundColor,
              label: Text(
                Strings.of(context).save.toUpperCase(),
                style: TextStyle(
                  color: isSavePossible
                      ? enabledButtonTextColor
                      : disabledButtonTextColor,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void _addEnableButtonEventToSaveButtonBloc(BuildContext context) {
    BlocProvider.of<SaveButtonBloc>(context).add(EnableSaveButtonEvent());
  }

  void _onSaveButtonPressed(BuildContext context, String text) {
    FocusManager.instance.primaryFocus?.unfocus();
    _addSaveInProgressEventToSaveButtonBloc(context);
    _addSaveNoteEventToSaveButtonBloc(context, text);
  }

  void _addSaveInProgressEventToSaveButtonBloc(BuildContext context) {
    BlocProvider.of<SaveButtonBloc>(context)
        .add(SaveInProgressSaveButtonEvent());
  }

  void _addSaveNoteEventToSaveButtonBloc(BuildContext context, String text) {
    BlocProvider.of<NoteBloc>(context).add(SaveNoteEvent(text, DateTime.now()));
  }

  void _showErrorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(Strings.of(context).snackBarErrorMsg)));
  }
}

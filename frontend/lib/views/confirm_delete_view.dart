import 'package:flutter/material.dart';
import 'package:frontend/controllers/note_controller.dart';
import 'package:frontend/models/note_model.dart';

class ConfirmDelete extends StatelessWidget {
  final NotesModel note;
  final VoidCallback refreshCallback;

  const ConfirmDelete(
      {Key? key, required this.note, required this.refreshCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Note'),
      content: Text('Are you sure you want to delete this note?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await NoteController().deleteNote(note.id_notes!);
            refreshCallback();
            Navigator.pop(context, true);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Berhasil dihapus"),
                duration: Duration(seconds: 2),
              ),
            );
          },
          child: Text('Delete'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frontend/controllers/note_controller.dart';
import 'package:frontend/models/note_model.dart';

class ConfirmDeleteTrash extends StatelessWidget {
  final TrashModel trash;
  final VoidCallback refreshCallback;

  const ConfirmDeleteTrash(
      {Key? key, required this.trash, required this.refreshCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Trash'),
      content: Text('Are you sure you want to permanent delete this note ?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await NoteController().deleteTrash(trash.id_notes!);
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

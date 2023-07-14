import 'package:flutter/material.dart';
import 'package:frontend/controllers/note_controller.dart';
import 'package:frontend/models/note_model.dart';

class EditNoteWidget extends StatefulWidget {
  final NotesModel note;
  final VoidCallback refreshCallback;

  const EditNoteWidget({
    Key? key,
    required this.note,
    required this.refreshCallback,
  }) : super(key: key);

  @override
  _EditNoteWidgetState createState() => _EditNoteWidgetState();
}

class _EditNoteWidgetState extends State<EditNoteWidget> {
  final NoteController controller = NoteController();
  late TextEditingController _titleController;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title_note);
    _textController = TextEditingController(text: widget.note.text_note);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Future<void> updateNote() async {
    final updatedNote = EditNoteModel(
      id_user: widget.note.id_user,
      title_note: _titleController.text,
      text_note: _textController.text,
    );

    try {
      await controller.editNote(updatedNote, widget.note.id_notes);
      widget.refreshCallback();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Berhasil diupdate"),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal diupdate"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _textController,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Text',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: updateNote,
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}

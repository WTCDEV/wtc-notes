import 'package:flutter/material.dart';
import 'package:frontend/controllers/note_controller.dart';
import 'package:frontend/models/note_model.dart';
import 'package:frontend/shared/shared_preferences.dart';

class AddNoteWidget extends StatefulWidget {
  const AddNoteWidget({Key? key}) : super(key: key);

  @override
  State<AddNoteWidget> createState() => _AddNoteWidgetState();
}

class _AddNoteWidgetState extends State<AddNoteWidget> {
  late TextEditingController _titleController;
  late TextEditingController _textController;
  final NoteController _noteController = NoteController();
  int? idUser;



  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _textController = TextEditingController();
    readSharedPrefs();
  }

  Future<void> readSharedPrefs() async {
    final int? idUserPref = await SharedPrefUtils.readIdUser();
    setState(() {
      idUser = idUserPref;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'Text',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Action when the "Save" button is pressed
                  final title = _titleController.text;
                  final text = _textController.text;

                  final note = AddNoteModel(
                    id_user: idUser,
                    title_note: title,
                    text_note: text,
                  );

                  _noteController.addNote(note).then((_) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => route.isFirst,
                    ); // Navigate back to the home screen (NotesView) and remove all routes above it
                  });
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

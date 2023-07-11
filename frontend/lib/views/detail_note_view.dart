import 'package:flutter/material.dart';
import 'package:frontend/models/note_model.dart';
import 'package:intl/intl.dart';

class DetailNote extends StatelessWidget {
  final NotesModel note;

  const DetailNote({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMMd().format(note.date_note!);
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title_note!),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.text_note!,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Date: $formattedDate',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

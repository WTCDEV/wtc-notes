import 'package:flutter/material.dart';
import 'package:frontend/models/note_model.dart';
import 'package:intl/intl.dart';

class DetailTrash extends StatelessWidget {
  final TrashModel trash;

  const DetailTrash({Key? key, required this.trash}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMMd().format(trash.date_note!);
    return Scaffold(
      appBar: AppBar(
        title: Text(trash.title_note!),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                trash.text_note!,
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

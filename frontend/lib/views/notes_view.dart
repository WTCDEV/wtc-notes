import 'package:flutter/material.dart';
import 'package:frontend/controllers/note_controller.dart';
import 'package:frontend/models/note_model.dart';
import 'package:frontend/views/detail_note_view.dart';
import 'package:frontend/views/edit_note_view.dart';
import 'package:frontend/views/confirm_delete_view.dart';
import 'package:intl/intl.dart';

class NoteListWidget extends StatefulWidget {
  @override
  _NoteListWidgetState createState() => _NoteListWidgetState();
}

class _NoteListWidgetState extends State<NoteListWidget> {
  final NoteController controller = NoteController();
  List<NotesModel> notesList = [];

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    try {
      List<NotesModel> fetchedNotes = await controller.fetchNotes();
      setState(() {
        notesList = fetchedNotes;
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> refreshNotes() async {
    try {
      List<NotesModel> fetchedNotes = await controller.fetchNotes();
      setState(() {
        notesList = fetchedNotes;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes List'),
      ),
      body: FutureBuilder(
        future: Future.delayed(Duration(seconds: 2), () => true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return notesList.isEmpty
                ? Center(
                    child: Text('Notes Empty'),
                  )
                : ListView.separated(
                    itemCount: notesList.length,
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey,
                    ),
                    itemBuilder: (context, index) {
                      NotesModel note = notesList[index];
                      String formattedDate = note.date_note != null
                          ? DateFormat.yMMMd().format(note.date_note!)
                          : '';

                      return ListTile(
                        title: Text(
                          note.title_note ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              note.text_note ?? '',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Date: $formattedDate',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditNoteWidget(
                                      note: note,
                                      refreshCallback: refreshNotes,
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(Icons.edit),
                              tooltip: "Edit",
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ConfirmDelete(
                                      note: note,
                                      refreshCallback: refreshNotes,
                                    ),
                                  ),
                                );
                              },
                              tooltip: "Delete",
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailNote(
                                note: note,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
          } else {
            return Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }
}

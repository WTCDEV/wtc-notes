import 'package:flutter/material.dart';
import 'package:frontend/controllers/note_controller.dart';
import 'package:frontend/models/note_model.dart';
import 'package:frontend/views/confirm_delete_trash.dart';
import 'package:frontend/views/detail_trash_view.dart';

import 'package:intl/intl.dart';

class TrashListWidget extends StatefulWidget {
  @override
  _TrashListWidgetState createState() => _TrashListWidgetState();
}

class _TrashListWidgetState extends State<TrashListWidget> {
  final NoteController controller = NoteController();
  List<TrashModel> trashList = [];

  @override
  void initState() {
    super.initState();
    fetchTrash();
  }

  Future<void> fetchTrash() async {
    try {
      List<TrashModel> fetchedTrash = await controller.fetchTrash();
      setState(() {
        trashList = fetchedTrash;
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> refreshTrash() async {
    try {
      List<TrashModel> fetchedTrash = await controller.fetchTrash();
      setState(() {
        trashList = fetchedTrash;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trash List'),
      ),
      body: ListView.separated(
        itemCount: trashList.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
        ),
        itemBuilder: (context, index) {
          TrashModel trash = trashList[index];
          String formattedDate = trash.date_note != null
              ? DateFormat.yMMMd().format(trash.date_note!)
              : '';

          return ListTile(
            title: Text(
              trash.title_note ?? '',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trash.text_note ?? '',
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
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmDeleteTrash(
                          trash: trash,
                          refreshCallback: refreshTrash,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailTrash(trash: trash)));
            },
          );
        },
      ),
    );
  }
}

import 'dart:convert';
import 'package:frontend/models/note_model.dart';
import 'package:frontend/shared/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NoteController {
  static const String baseUrl = 'http://localhost:3000';
  static const String addNoteEndPoint = '/create-note';
  static const String trashNoteEndPoint = '/trash-notes/';
  static const String notesEndPoint = '/notes/';
  static const String editNoteEndPoint = '/edit-note/';
  static const String deleteNoteEndPoint = '/delete/';
  static const String deleteTrashEndPoint = '/permanent-delete/';
  static const String restoreTrashEndPoint = 'restore-note/';

  Future<void> addNote(AddNoteModel note) async {
    final url = Uri.parse(baseUrl + addNoteEndPoint);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(note.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        print('Note added successfully');
      } else {
        print('Failed to add note');
      }
    } catch (e) {
      print('An error occurred: $e');
      throw e;
    }
  }

  Future<void> editNote(EditNoteModel note, id_notes) async {
    final url = Uri.parse(baseUrl + editNoteEndPoint + '$id_notes');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(note.toJson());

    try {
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        print('Note edit successfully');
      } else {
        print('Failed to edit note');
      }
    } catch (e) {
      print('An error occurred: $e');
      throw e;
    }
  }

  Future<List<NotesModel>> fetchNotes() async {
    final int? id_user = await SharedPrefUtils.readIdUser();
    final url = Uri.parse(baseUrl + notesEndPoint + '$id_user');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.get(url, headers: headers);
      final jsonData = json.decode(response.body)['data'] as List<dynamic>;

      List<NotesModel> notesList = [];
      for (var item in jsonData) {
        NotesModel note = NotesModel.fromJson(item);
        notesList.add(note);
      }
      return notesList;
    } catch (e) {
      throw e;
    }
  }

  Future<List<TrashModel>> fetchTrash() async {
    final int? id_user = await SharedPrefUtils.readIdUser();
    final url = Uri.parse(baseUrl + trashNoteEndPoint + '$id_user');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.get(url, headers: headers);
      final jsonData = json.decode(response.body)['data'] as List<dynamic>;

      List<TrashModel> trashList = [];
      for (var item in jsonData) {
        TrashModel trash = TrashModel.fromJson(item);
        trashList.add(trash);
      }
      return trashList;
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteNote(int idNotes) async {
    final url = Uri.parse(baseUrl + deleteNoteEndPoint + '$idNotes');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        print('Note deleted successfully');
      } else {
        print('Failed to delete note');
      }
    } catch (e) {
      print('An error occurred: $e');
      throw e;
    }
  }

  Future<void> deleteTrash(int idNotes) async {
    final url = Uri.parse(baseUrl + deleteTrashEndPoint + '$idNotes');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        print('Note deleted successfully');
      } else {
        print('Failed to delete note');
      }
    } catch (e) {
      print('An error occurred: $e');
      throw e;
    }
  }
}

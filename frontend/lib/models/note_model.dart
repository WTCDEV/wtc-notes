import 'package:intl/intl.dart';

class NotesModel {
  final int? id_notes;
  final int? id_user;
  final DateTime? date_note;
  final String? title_note;
  final String? text_note;

  NotesModel({
    this.id_notes,
    this.id_user,
    this.date_note,
    this.title_note,
    this.text_note,
  });

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      id_notes: json['id_notes'],
      id_user: json['id_user'],
      date_note: DateTime.parse(json['date_note']!),
      title_note: json['title_note'],
      text_note: json['text_note'],
    );
  }
}

class TrashModel {
  final int? id_notes;
  final int? id_user;
  final DateTime? date_note;
  final String? title_note;
  final String? text_note;

  TrashModel({
    this.id_notes,
    this.id_user,
    this.date_note,
    this.title_note,
    this.text_note,
  });

  factory TrashModel.fromJson(Map<String, dynamic> json) {
    return TrashModel(
      id_notes: json['id_notes'],
      id_user: json['id_user'],
      date_note: DateTime.parse(json['date_note']!),
      title_note: json['title_note'],
      text_note: json['text_note'],
    );
  }
}


class AddNoteModel {
  int? id_user;
  String? title_note;
  String? text_note;

  AddNoteModel({
    this.id_user,
    this.title_note,
    this.text_note,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_user': id_user,
      'title_note': title_note,
      'text_note': text_note,
    };
  }
}


class EditNoteModel {
  int? id_user;
  String? title_note;
  String? text_note;

  EditNoteModel({
    this.id_user,
    this.title_note,
    this.text_note,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_user': id_user,
      'title_note': title_note,
      'text_note': text_note,
    };
  }
}



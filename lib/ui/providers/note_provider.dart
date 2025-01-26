import 'package:flutter/material.dart';
import 'package:stronglog/domain/models/exercise_model.dart';
import 'package:stronglog/domain/models/note_model.dart';
import 'package:stronglog/domain/services/exercise_service.dart';
import 'package:stronglog/domain/services/note_service.dart';

class NoteProvider with ChangeNotifier {
  late Future<List<Note>> _notes;
  final NoteService noteService = NoteService();

  Future<List<Note>> get notes {
    return _notes;
  }

  set notes(Future<List<Note>> notes) {
    _notes = notes;
    notifyListeners();
  }

  void shouldRefresh() {
    notifyListeners();
  }
}

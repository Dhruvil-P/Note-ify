import 'package:flutter/material.dart';
import 'package:notes_app/classes/note.dart';

class Notes with ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes {
    return [..._notes];
  }

  List<Note> get pinnedNotes {
    return [..._notes.where((note) => note.isPinned == true).toList()];
  }

  List<Note> get favoriteNotes {
    return [..._notes.where((note) => note.isFavorite == true).toList()];
  }

  void pinNote(String id) {
    Note note = _notes.firstWhere((note) => note.id == id);
    note.isPinned ? note.isPinned = false : note.isPinned = true;
    notifyListeners();
  }

  void favNote(String id) {
    Note note = _notes.firstWhere((note) => note.id == id);
    note.isFavorite ? note.isFavorite = false : note.isFavorite = true;
    notifyListeners();
  }

  void addNote(String title, String desc) {
    _notes.add(Note(
        id: DateTime.now().toString(),
        title: title,
        description: desc,
        timeCreated: DateTime.now(),
        isPinned: false,
        isFavorite: false));
    notifyListeners();
  }

  void removeNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  void updateNote(String id, String title, String desc) {
    var item = _notes.firstWhere((note) => note.id == id);
    item.title = title;
    item.description = desc;

    notifyListeners();
  }

  void reorderList(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    var item = _notes.removeAt(oldIndex);
    _notes.insert(newIndex, item);

    notifyListeners();
  }
}

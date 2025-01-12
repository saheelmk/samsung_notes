import 'package:flutter/material.dart';
import 'package:samsung_note/widgets/models/note_model.dart';

import 'package:get_storage/get_storage.dart';

final ValueNotifier<List<NoteModel>> notifier = ValueNotifier([]);

void onAddNotes(String title, String body, TextStyle textStyle) {
  final note = NoteModel(
    title: title,
    body: body,
    createdTime: DateTime.now(),
    textStyle: textStyle,
  );

  // Store the note in the notifier
  notifier.value = [...notifier.value, note];
  notifier.notifyListeners();

  // Save the notes to GetStorage
  saveNotesToStorage();
}

// Function to save notes to GetStorage
void saveNotesToStorage() {
  final box = GetStorage();
  List<Map<String, dynamic>> notesList = notifier.value.map((note) {
    return {
      'title': note.title,
      'body': note.body,
      'createdTime': note.createdTime.toIso8601String(),
      'textStyle': {
        'color': note.textStyle.color?.value,
        'fontSize': note.textStyle.fontSize,
        'fontWeight': note.textStyle.fontWeight?.index,
      },
    };
  }).toList();

  box.write('notes', notesList);
}

// Function to load notes from GetStorage
void loadNotesFromStorage() {
  final box = GetStorage();
  List<dynamic>? storedNotes = box.read('notes');

  if (storedNotes != null) {
    List<NoteModel> loadedNotes = storedNotes.map<NoteModel>((noteData) {
      // Get the color value and check for null
      int colorValue = noteData['textStyle']['color'] ??
          Colors.black.value; // Default to black if null

      return NoteModel(
        title: noteData['title'],
        body: noteData['body'],
        createdTime: DateTime.parse(noteData['createdTime']),
        textStyle: TextStyle(
          color: Color(colorValue),
          fontSize: noteData['textStyle']['fontSize'] ??
              20.0, // Default font size if null
          fontWeight: noteData['textStyle']['fontWeight'] != null
              ? FontWeight.values[noteData['textStyle']['fontWeight']]
              : FontWeight.normal, // Default weight if null
        ),
      );
    }).toList();

    notifier.value = loadedNotes;
    notifier.notifyListeners();
  }
}

void moveToRecycleBin(int index) {
  if (index >= 0 && index < notifier.value.length) {
    final note = notifier.value[index];
    notifier.value[index] = NoteModel(
      createdTime: DateTime.now(),
      title: note.title,
      body: note.body,
      isInRecycleBin: true,
      textStyle: note.textStyle, // Keep the same text style
    );
    notifier.notifyListeners();
  }
}

void onUpdateNotes(int index, String title, String body, TextStyle textStyle) {
  if (index >= 0 && index < notifier.value.length) {
    notifier.value[index] = NoteModel(
      createdTime: DateTime.now(),
      title: title,
      body: body,
      isInRecycleBin: notifier.value[index].isInRecycleBin,
      textStyle: textStyle, // Update the text style
    );
    notifier.notifyListeners();
  }
}

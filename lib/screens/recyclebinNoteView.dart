import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:samsung_note/themes/extension/theme.dart';
import 'package:samsung_note/widgets/models/note_model.dart';

class RecycleBinNoteView extends HookWidget {
  final NoteModel note;
  RecycleBinNoteView({required this.note});
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<ThemeWidget>()!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(note.title),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "Restore",
                style: TextStyle(
                    color: customColors.secondaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
          TextButton(
              onPressed: () {},
              child: Text(
                "Delete",
                style: TextStyle(
                    color: customColors.secondaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            note.body,
            style: note.textStyle,
          ),
        ),
      ),
    );
  }
}

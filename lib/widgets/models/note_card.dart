import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:samsung_note/functions/datafunction.dart';
import 'package:samsung_note/screens/note_view.dart';
import 'package:samsung_note/widgets/models/note_model.dart';

typedef CustomCallback = void Function(NoteModel note);

class NoteCardWidget extends HookWidget {
  const NoteCardWidget({
    super.key,
    required this.isIconVisible,
    required this.note,
    required this.index,
    required this.onUpdateNote,
    required this.onMoveToRecycle,
    this.onTap,
  });

  final NoteModel note;
  final int index;
  final VoidCallback isIconVisible;
  final Function(int, String, String, TextStyle) onUpdateNote;
  final CustomCallback? onTap;
  final Function(int) onMoveToRecycle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        isIconVisible();
      },
      onTap: onTap != null
          ? () => onTap!(note)
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext ctx) => NoteView(
                    onMoveToRecycle: onMoveToRecycle,
                    note: note,
                    index: index,
                    onUpdateNote: onUpdateNote,
                  ),
                ),
              );
            },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 160,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          note.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        note.body,
                        style: note.textStyle, // Default text style
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Text(
                    DateFormat('MMM d, yyyy\nh:mm a').format(note.createdTime),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

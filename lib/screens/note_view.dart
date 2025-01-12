import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:samsung_note/themes/extension/theme.dart';
import 'package:samsung_note/widgets/models/note_model.dart';

class NoteView extends HookWidget {
  const NoteView({
    super.key,
    required this.onMoveToRecycle,
    required this.note,
    required this.index,
    required this.onUpdateNote,
  });

  final NoteModel note;
  final int index;
  final Function(int, String, String, TextStyle) onUpdateNote;
  final Function(int) onMoveToRecycle;

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: note.title);
    final bodyController = TextEditingController(text: note.body);

    final customColors = Theme.of(context).extension<ThemeWidget>()!;
    final TextStyle currentTextStyle =
        note.textStyle; // Store current text style

    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            final updatedTitle = titleController.text;
            final updatedBody = bodyController.text;

            onUpdateNote(index, updatedTitle, updatedBody,
                currentTextStyle); // Pass the text style
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: TextField(
          controller: titleController,
          decoration: const InputDecoration(
            hintText: "Title",
            border: InputBorder.none,
          ),
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundColor: customColors.primaryColor,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.edit_document,
                color: customColors.secondaryColor,
              ),
            ),
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: customColors.primaryColor,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: customColors.secondaryColor,
              ),
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              print("Selected: $value");
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: customColors.randomColor,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Container(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Full screen",
                            style:
                                TextStyle(color: customColors.secondaryColor),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Tags",
                            style:
                                TextStyle(color: customColors.secondaryColor),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Save as file",
                            style:
                                TextStyle(color: customColors.secondaryColor),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Print",
                            style:
                                TextStyle(color: customColors.secondaryColor),
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.star, size: 20),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.share, size: 20),
                            ),
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Move note to the Recycle bin?",
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color: customColors
                                                          .secondaryColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                width: 1,
                                                height: 15,
                                                color: Colors.grey[400],
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  onMoveToRecycle(index);
                                                },
                                                child: Text(
                                                  "Move to Recycle bin",
                                                  style: TextStyle(
                                                      color: customColors
                                                          .secondaryColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.delete, size: 20),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: bodyController,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            style: currentTextStyle, // Apply custom text style
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
        ),
      ),
    );
  }
}

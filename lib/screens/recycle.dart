import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:samsung_note/functions/datafunction.dart';
import 'package:samsung_note/screens/recyclebinNoteView.dart';
import 'package:samsung_note/themes/extension/theme.dart';
import 'package:samsung_note/screens/one_ui_nested_scroll.dart';
import 'package:samsung_note/widgets/appDrawers/drawer.dart';
import 'package:samsung_note/widgets/checkBox.dart';
import 'package:samsung_note/widgets/models/note_model.dart';

class RecycleWidget extends HookWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isLongpressed = useState(true);
    final customColors = Theme.of(context).extension<ThemeWidget>()!;
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(
        settingsBackgroundColor: customColors.primaryColor,
        drawerColor: customColors.randomColor,
        textColor: customColors.secondaryColor,
        folderColor: customColors.buttonColor,
      ),
      body: ValueListenableBuilder<List<NoteModel>>(
        valueListenable: notifier, // Listen to the notifier
        builder: (context, notesList, child) {
          // Filter notes that are in the recycle bin
          final recycleBinNotes =
              notesList.where((note) => note.isInRecycleBin).toList();

          return OneUiNested(
            onTap: (note) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => RecycleBinNoteView(
                            note: note,
                          )));
            },
            onUpdateNotes: (p0, p1, p2, p3) {},
            iconButton3: isLongpressed.value
                ? IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                  )
                : const SizedBox(),
            isLongpressed.value
                ? IconButton(
                    onPressed: () {},
                    icon: const Text(
                      "Edit",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )
                : const SizedBox(),
            IconButton(
              onPressed: () {},
              icon: const Icon(null),
            ),

            menuButton: isLongpressed.value
                ? IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                  )
                : const CheckBoxWidget(),
            onLongPressed: () {
              isLongpressed.value = !isLongpressed.value;
            },
            expandedHeight: 300,
            toolbarHeight: 30,
            expandedWidget: Text(
              "Recycle bin",
              style:
                  TextStyle(fontSize: 30, color: customColors.secondaryColor),
            ),
            collapsedWidget: Text(
              "Recycle bin",
              style:
                  TextStyle(fontSize: 20, color: customColors.secondaryColor),
            ),
            bodyText:
                recycleBinNotes.isEmpty ? "No notes in the recycle bin" : "",
            subBodyText: Text(
              "Any notes you delete will stay in  \n  the Recycle bin for 30 days before they're \n deleted forever.",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
            ),
            backgroundColor: customColors.primaryColor,
            notes: recycleBinNotes, // Pass the filtered recycle bin notes
            onNoteDeleted: (int index) {},
          );
        },
      ),
      bottomNavigationBar: isLongpressed.value
          ? const SizedBox()
          : BottomSheet(
              onClosing: () {},
              builder: (ctx) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  color: customColors.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                // Restore selected notes
                                restoreAllNotes();
                                Navigator.pushReplacementNamed(
                                    context, '/home');
                              },
                              icon: Icon(
                                Icons.restore,
                                color: customColors.secondaryColor,
                              ),
                            ),
                            Text(
                              "Restore",
                              style:
                                  TextStyle(color: customColors.secondaryColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                // Permanently delete all notes
                                deleteAllNotes();
                              },
                              icon: Icon(
                                Icons.delete,
                                color: customColors.secondaryColor,
                              ),
                            ),
                            Text(
                              "Delete",
                              style:
                                  TextStyle(color: customColors.secondaryColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }

  void restoreAllNotes() {
    final notesList = notifier.value;
    for (final note in notesList.where((note) => note.isInRecycleBin)) {
      note.isInRecycleBin = false;
    }
    notifier.value = List.from(notesList);
    notifier.notifyListeners(); // Notify listeners to refresh the UI
  }

  void deleteAllNotes() {
    final notesList = notifier.value;
    notesList.removeWhere((note) => note.isInRecycleBin);
    notifier.value = List.from(notesList);
    notifier.notifyListeners(); // Notify listeners to refresh the UI
  }
}

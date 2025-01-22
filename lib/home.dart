import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:samsung_note/functions/datafunction.dart';
import 'package:samsung_note/screens/create_notes.dart';
import 'package:samsung_note/themes/extension/theme.dart';
import 'package:samsung_note/widgets/bottomNavigation.dart';
import 'package:samsung_note/widgets/checkBox.dart';
import 'package:samsung_note/widgets/appDrawers/drawer.dart';
import 'package:samsung_note/screens/one_ui_nested_scroll.dart';
import 'package:samsung_note/widgets/models/note_model.dart';

class SamsungNoteHomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isLongpressed = useState(true);
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final customColors = Theme.of(context).extension<ThemeWidget>()!;

    return Scaffold(
      key: scaffoldKey,
      drawer: AppDrawer(
        settingsBackgroundColor: customColors.primaryColor,
        drawerColor: customColors.randomColor,
        textColor: customColors.secondaryColor,
        folderColor: customColors.buttonColor,
      ),
      body: ValueListenableBuilder<List<NoteModel>>(
        valueListenable: notifier,
        builder: (context, notesList, child) {
          // Filter out notes that are in the recycle bin
          final visibleNotes =
              notesList.where((note) => !note.isInRecycleBin).toList();
          return OneUiNested(
            onMoveToRecycle: (index) {
              moveToRecycleBin(index);
            },
            onUpdateNotes: onUpdateNotes,
            iconButton3: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.picture_as_pdf_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            menuButton: isLongpressed.value
                ? IconButton(
                    onPressed: () => scaffoldKey.currentState?.openDrawer(),
                    icon: const Icon(Icons.menu),
                  )
                : const CheckBoxWidget(),
            onLongPressed: () => isLongpressed.value = !isLongpressed.value,
            expandedHeight: 400,
            toolbarHeight: 40,
            expandedWidget: Text(
              isLongpressed.value
                  ? "All notes"
                  : "${visibleNotes.length} Selected",
              style:
                  TextStyle(color: customColors.secondaryColor, fontSize: 28),
            ),
            collapsedWidget: Text(
              "All notes",
              style: TextStyle(
                color: customColors.secondaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            bodyText: visibleNotes.isEmpty ? "No notes" : "",
            subBodyText: const Text(
              "Tap Add button to create a note",
              style: TextStyle(color: Colors.grey),
            ),
            backgroundColor: customColors.primaryColor,
            notes: visibleNotes,
            onNoteDeleted: (index) {},
          );
        },
      ),
      floatingActionButton: isLongpressed.value
          ? Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: customColors.randomColor,
                shape: BoxShape.circle,
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black38,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext ctx) => CreateNotes(
                        appbarThings: customColors.secondaryColor,
                        backgroundColor: customColors.primaryColor,
                        onAddNote: onAddNotes,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.note_add_outlined),
                color: Colors.orange,
              ),
            )
          : BottomNavigationWidget(
              onUpdateNotes: (index) {
                moveToRecycleBin(index);
              },
              index: notifier.value.length,
              bgColor: customColors.primaryColor,
              color: customColors.secondaryColor,
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:samsung_note/functions/datafunction.dart';
import 'package:samsung_note/screens/manage_folder.dart';
import 'package:samsung_note/screens/recycle.dart';
import 'package:samsung_note/screens/settings.dart';
import 'package:samsung_note/widgets/models/note_model.dart';

class AppDrawer extends HookWidget {
  final Color drawerColor;
  final Color textColor;
  final Color settingsBackgroundColor;
  final Color folderColor;

  AppDrawer({
    required this.drawerColor,
    required this.textColor,
    required this.settingsBackgroundColor,
    required this.folderColor,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<Map<String, dynamic>>> folderNotifier =
        ValueNotifier<List<Map<String, dynamic>>>([]);
    return Drawer(
      backgroundColor: drawerColor,
      child: ListView(
        children: [
          ListTile(
            trailing: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext ctx) => SettingsWidget(
                      containerColor: drawerColor,
                      textcolors: textColor,
                      backgroundColor: settingsBackgroundColor,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.settings),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 15),
              TextButton.icon(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/home");
                },
                label: Text(
                  "All notes",
                  style: TextStyle(
                    fontSize: 20,
                    color: textColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                icon: Icon(
                  Icons.book_outlined,
                  color: textColor,
                ),
              ),
              ValueListenableBuilder<List<NoteModel>>(
                valueListenable: notifier, // Use foldernotes
                builder: (context, notesList, child) {
                  if (notesList.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: Text(
                        "${notesList.length}",
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    );
                  }
                  return const SizedBox(); // Empty widget if no notes
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 15),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => RecycleWidget()),
                  );
                },
                label: Text(
                  "Recycle bin",
                  style: TextStyle(
                    fontSize: 20,
                    color: textColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                icon: Icon(
                  Icons.delete_outline,
                  color: textColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 78),
                child: ValueListenableBuilder<List<NoteModel>>(
                  valueListenable: notifier, // Use foldernotes
                  builder: (context, notesList, child) {
                    final recycleBinCount = notesList
                        .where((note) => note.isInRecycleBin)
                        .length; // Count notes in Recycle Bin
                    if (recycleBinCount > 0) {
                      return Text(
                        "$recycleBinCount",
                        style: TextStyle(
                          color: textColor,
                        ),
                      );
                    }
                    return const SizedBox(); // Empty widget if no recycle bin notes
                  },
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              "..............................................",
              style: TextStyle(letterSpacing: 2, color: Colors.grey),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 15),
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.pushNamed(context, '/folder');
                },
                label: Text(
                  "Folders",
                  style: TextStyle(
                    fontSize: 20,
                    color: textColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                icon: Icon(
                  Icons.folder_outlined,
                  color: textColor,
                ),
              ),
            ],
          ),
          // Add the ValueListenableBuilder here to dynamically show the folders
          ValueListenableBuilder<List<Map<String, dynamic>>>(
            valueListenable: folderNotifier,
            builder: (context, folders, child) {
              return Column(
                children: folders.map((folder) {
                  return Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: ListTile(
                      onLongPress: () {},
                      leading:
                          Icon(Icons.folder_outlined, color: folder["color"]),
                      title: Text(
                        folder["name"],
                        style: TextStyle(color: textColor),
                      ),
                      onTap: () {
                        // Handle folder selection
                        Navigator.pushNamed(context, '/folder', arguments: {
                          'folderName': folder['name'],
                          'folderColor': folder['color'],
                          'subfolders': folder['subfolders'],
                        });
                      },
                    ),
                  );
                }).toList(),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, right: 35),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: folderColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext ctx) => ManageFolderScreen(
                      folderNotifier: folderNotifier,
                      backgroundCOlor: settingsBackgroundColor,
                      boxColor: drawerColor,
                      textColor: textColor,
                    ),
                  ),
                );
              },
              child: Text(
                "Manage folders",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

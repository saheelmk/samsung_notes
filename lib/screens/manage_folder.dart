import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:samsung_note/widgets/alertContainer.dart';

class ManageFolderScreen extends HookWidget {
  final Color backgroundCOlor;
  final Color boxColor;
  final Color textColor;
  ValueNotifier<List<Map<String, dynamic>>> folderNotifier =
      ValueNotifier<List<Map<String, dynamic>>>([]);
  ManageFolderScreen({
    super.key,
    required this.backgroundCOlor,
    required this.boxColor,
    required this.textColor,
    required this.folderNotifier,
  });

  @override
  @override
  Widget build(BuildContext context) {
    // List of folders stored as state

    void addFolder(String folderName, Color folderColor,
        [Map<String, dynamic>? parentFolder]) {
      if (parentFolder == null) {
        // Add as a main folder
        folderNotifier.value = [
          ...folderNotifier.value,
          {
            "name": folderName,
            "color": folderColor,
            "subfolders": <Map<String, dynamic>>[], // Explicitly typed
          },
        ];
      } else {
        // Add as a subfolder
        List<Map<String, dynamic>> updatedFolders =
            folderNotifier.value.map((folder) {
          if (folder == parentFolder) {
            // Update the specific folder with the new subfolder
            return {
              ...folder,
              "subfolders": [
                ...(folder["subfolders"] as List<Map<String, dynamic>>),
                {
                  "name": folderName,
                  "color": folderColor,
                  "subfolders": <Map<String, dynamic>>[], // Explicitly typed
                },
              ],
            };
          }
          return folder;
        }).toList();

        folderNotifier.value = updatedFolders; // Notify the ValueNotifier
      }
    }

    // Recursive widget to display folders and subfolders
    Widget buildFolderList(List<Map<String, dynamic>> folders) {
      return Column(
        children: folders.map((folder) {
          return Column(
            key: ValueKey(folder["name"]),
            children: [
              PopupMenuButton<String>(
                color: boxColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onSelected: (value) {
                  if (value == "createSubfolder") {
                    // Show dialog to create subfolder
                    showDialog(
                      context: context,
                      builder: (BuildContext ctx) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text(
                          "Create subfolder",
                          style: TextStyle(fontSize: 18),
                        ),
                        content: AlertContainer(
                          onAdd: (name, color) =>
                              addFolder(name, color, folder),
                        ),
                      ),
                    );
                  } else if (value == "rename") {
                    // Show dialog to rename folder
                    TextEditingController controller =
                        TextEditingController(text: folder["name"]);
                    showDialog(
                      context: context,
                      builder: (BuildContext ctx) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text("Rename Folder"),
                        content: TextField(
                          controller: controller,
                          decoration:
                              const InputDecoration(hintText: "Enter new name"),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              if (controller.text.isNotEmpty) {
                                folder["name"] =
                                    controller.text; // Update folder name
                                folderNotifier
                                    .notifyListeners(); // Notify change
                                Navigator.pop(ctx); // Close dialog
                              }
                            },
                            child: const Text("Rename"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(ctx), // Close dialog
                            child: const Text("Cancel"),
                          ),
                        ],
                      ),
                    );
                  } else if (value == "delete") {
                    // Show confirmation dialog for deleting the folder
                    showDialog(
                      context: context,
                      builder: (BuildContext ctx) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text("Delete Folder"),
                        content: const Text(
                            "Are you sure you want to delete this folder?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Remove the folder from the list
                              folderNotifier.value = folderNotifier.value
                                  .where((f) => f != folder)
                                  .toList();
                              folderNotifier.notifyListeners();
                              Navigator.pop(ctx); // Close dialog
                            },
                            child: const Text("Delete"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(ctx), // Close dialog
                            child: const Text("Cancel"),
                          ),
                        ],
                      ),
                    );
                  }
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: "createSubfolder",
                      child: Text("Create subfolder"),
                    ),
                    PopupMenuItem(
                      value: "rename",
                      child: Text("Rename"),
                    ),
                    PopupMenuItem(
                      value: "delete",
                      child: Text("Delete"),
                    ),
                  ];
                },
                child: ListTile(
                  leading: Icon(Icons.folder_outlined, color: folder["color"]),
                  title: Text(
                    folder["name"],
                    style: TextStyle(color: textColor),
                  ),
                ),
              ),
              Divider(
                color: Colors.grey[350],
                indent: 10,
                endIndent: 10,
              ),
              // Recursive call for subfolders
              if (folder["subfolders"].isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: buildFolderList(folder["subfolders"]),
                ),
            ],
          );
        }).toList(),
      );
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        backgroundColor: backgroundCOlor,
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: backgroundCOlor,
          title: const Text("Manage folders"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          titleSpacing: 0.0,
        ),
        body: ValueListenableBuilder<List<Map<String, dynamic>>>(
          valueListenable: folderNotifier,
          builder: (context, folderList, _) {
            return ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: boxColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Folders header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () {},
                            label: Text(
                              "Folders",
                              style: TextStyle(fontSize: 16, color: textColor),
                            ),
                            icon: Icon(
                              Icons.folder_outlined,
                              color: textColor,
                            ),
                            style: TextButton.styleFrom(
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Text("${folderList.length}"),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.grey[350],
                        indent: 10,
                        endIndent: 10,
                      ),
                      // Display folder list
                      buildFolderList(folderList),
                      // Create folder button
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        child: TextButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext ctx) => AlertDialog(
                                backgroundColor: Colors.white,
                                title: const Text(
                                  "Create folder",
                                  style: TextStyle(fontSize: 18),
                                ),
                                content: AlertContainer(
                                  onAdd: addFolder,
                                ),
                              ),
                            );
                          },
                          label: Text(
                            "Create folder",
                            style: TextStyle(fontSize: 16, color: textColor),
                          ),
                          icon: const Icon(
                            Icons.add,
                            color: Colors.green,
                          ),
                          style: TextButton.styleFrom(
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

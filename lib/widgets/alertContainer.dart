// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';

// class AlertContainer extends HookWidget {
//   final Function(String, Color) onAdd;

//   AlertContainer({required this.onAdd});

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController folderNameController = TextEditingController();
//     final List<Color> colors = [
//       Colors.grey,
//       Colors.red,
//       Colors.orange,
//       Colors.yellow,
//       Colors.lightGreen,
//       Colors.green,
//       Colors.cyan,
//       Colors.pinkAccent,
//       Colors.purple,
//       Colors.lightBlue,
//       Colors.blue,
//       Colors.brown,
//     ];
//     final selectedColor = useState<Color?>(null);

//     return SizedBox(
//       height: 280,
//       width: 500,
//       child: Column(
//         children: [
//           TextField(
//             controller: folderNameController,
//             decoration: InputDecoration(
//               hintText: "Folder name",
//               hintStyle: TextStyle(
//                   color: Colors.grey[500], fontWeight: FontWeight.normal),
//               enabledBorder: const UnderlineInputBorder(
//                 borderSide: BorderSide(
//                   color: Colors.black,
//                   width: 2.0,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               Text(
//                 "Colour",
//                 style: TextStyle(color: Colors.grey[400]),
//               ),
//               const SizedBox(width: 15),
//               const Text(
//                 "....................................",
//                 style: TextStyle(letterSpacing: 2),
//               )
//             ],
//           ),
//           const SizedBox(height: 30),
//           SizedBox(
//             height: 100, // Set a fixed height for the GridView
//             child: GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 6, // Six colors per row
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 1.0,
//               ),
//               itemCount: colors.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     selectedColor.value = colors[index];
//                   },
//                   child: CircleAvatar(
//                     backgroundColor: colors[index],
//                     radius: 20,
//                     child: selectedColor.value == colors[index]
//                         ? const Icon(
//                             Icons.check,
//                             color: Colors.white,
//                           )
//                         : null,
//                   ),
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text(
//                   "Cancel",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16),
//                 ),
//               ),
//               Container(
//                 width: 1,
//                 height: 15,
//                 color: Colors.grey[400],
//               ),
//               TextButton(
//                 onPressed: () {
//                   final folderName = folderNameController.text;
//                   if (folderName.isNotEmpty && selectedColor.value != null) {
//                     onAdd(folderName, selectedColor.value!);
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: const Text(
//                   "Add",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// AlertContainer.dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AlertContainer extends HookWidget {
  final Function(String, Color) onAdd;

  AlertContainer({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final TextEditingController folderNameController = TextEditingController();
    final List<Color> colors = [
      Colors.grey,
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.lightGreen,
      Colors.green,
      Colors.cyan,
      Colors.pinkAccent,
      Colors.purple,
      Colors.lightBlue,
      Colors.blue,
      Colors.brown,
    ];
    final selectedColor = useState<Color?>(null);

    return SizedBox(
      height: 280,
      width: 500,
      child: Column(
        children: [
          // Folder name input
          TextField(
            controller: folderNameController,
            decoration: InputDecoration(
              hintText: "Folder name",
              hintStyle: TextStyle(
                  color: Colors.grey[500], fontWeight: FontWeight.normal),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Color picker header
          Row(
            children: [
              Text(
                "Colour",
                style: TextStyle(color: Colors.grey[400]),
              ),
              const SizedBox(width: 15),
              const Text(
                "....................................",
                style: TextStyle(letterSpacing: 2),
              )
            ],
          ),
          const SizedBox(height: 30),
          // Color picker grid
          SizedBox(
            height: 100,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.0,
              ),
              itemCount: colors.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    selectedColor.value = colors[index];
                  },
                  child: CircleAvatar(
                    backgroundColor: colors[index],
                    radius: 20,
                    child: selectedColor.value == colors[index]
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        : null,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              Container(
                width: 1,
                height: 15,
                color: Colors.grey[400],
              ),
              TextButton(
                onPressed: () {
                  final folderName = folderNameController.text;
                  if (folderName.isNotEmpty && selectedColor.value != null) {
                    onAdd(folderName, selectedColor.value!);
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Add",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

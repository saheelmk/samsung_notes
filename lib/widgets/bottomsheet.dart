import 'package:flutter/material.dart';

class BottomsheetWidget extends StatelessWidget {
  final Color textColor;
  BottomsheetWidget({super.key, required this.textColor});
  final List<Color> colors = [
    Colors.grey, // First color
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
    Colors.brown, // Last color
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Create folder",
              style: TextStyle(fontSize: 20, color: textColor),
            ),
            const SizedBox(height: 16),

            // Folder Name TextField
            TextField(
              decoration: InputDecoration(
                labelText: "Folder name",
                fillColor: Colors.grey,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                contentPadding: EdgeInsets.only(bottom: 1),
              ),
            ),
            const SizedBox(height: 16),

            // Color Section Label
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Colour",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  "..................................................",
                  style: TextStyle(letterSpacing: 2, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Color Picker GridView
            SizedBox(
              height: 100, // Set a fixed height for the GridView
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6, // Six colors per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.3,
                ),
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      backgroundColor: colors[index],
                      radius: 20, // Adjust size here if needed
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Cancel and Add Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: textColor,
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
                  onPressed: () {},
                  child: Text(
                    "Add",
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

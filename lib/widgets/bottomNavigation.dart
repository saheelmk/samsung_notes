import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({
    super.key,
    required this.color,
    required this.bgColor,
    required this.index,
    required this.onUpdateNotes,
  });
  final Color color;
  final Color bgColor;
  final int index;
  final Function(int) onUpdateNotes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconWithLabel(
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.drive_file_move_outlined,
                  size: 20,
                ),
              ),
              "Move",
              color),
          _buildIconWithLabel(
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                  size: 20,
                ),
              ),
              "Share",
              color),
          _buildIconWithLabel(
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isDismissible: true, // Allows dismissing by tapping outside
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(15), // Rounded top corners
                      ),
                    ),
                    backgroundColor: bgColor,
                    builder: (BuildContext context) {
                      return Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Move note to the Recycle bin?",
                              style: TextStyle(
                                fontSize: 15,
                                color: color,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: color,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.grey,
                                  height: 20,
                                  width: 1,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    onUpdateNotes(index);
                                  },
                                  child: Text(
                                    "Move to Recycle bin",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: color,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                icon: Icon(
                  Icons.delete,
                  size: 20,
                ),
              ),
              "Delete all",
              color),
          _buildIconWithLabel(
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  size: 20,
                ),
              ),
              "More",
              color),
        ],
      ),
    );
  }
}

Widget _buildIconWithLabel(IconButton icon, String label, Color color) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      icon,
      Text(
        label,
        style: TextStyle(fontSize: 10, color: color),
      ),
    ],
  );
}

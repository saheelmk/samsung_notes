import 'package:flutter/material.dart';

class FontColorSelector extends StatefulWidget {
  final bool showFonColorpalte;
  final VoidCallback onclose;
  final Function(Color) onColorSelected;
  FontColorSelector(
      {required this.showFonColorpalte,
      required this.onclose,
      required this.onColorSelected});
  @override
  _FontColorSelectorState createState() => _FontColorSelectorState();
}

class _FontColorSelectorState extends State<FontColorSelector> {
  int _selectedColorIndex = 0; // Index to track the selected color

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white, // Background color for the selector
        border: Border.all(
          color: Colors.grey[350]!, // Border color
          width: 1.0, // Border width
        ),
        borderRadius: const BorderRadius.all(Radius.circular(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row with Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Font colour",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  widget.onclose();
                  // Add your logic to close/hide the selector
                },
              ),
            ],
          ),
          const SizedBox(height: 15),
          // Color Selector Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(Colors.primaries.length, (index) {
                return _buildColorOption(
                  Colors.primaries[index], // Using Colors.primaries
                  index ==
                      _selectedColorIndex, // Check if this color is selected
                  () {
                    setState(() {
                      _selectedColorIndex =
                          index; // Update selected color index
                    });
                    widget.onColorSelected(
                        Colors.primaries[index]); //call the call back
                  },
                );
              }),
            ),
          ),

          const SizedBox(height: 15),
          // Pagination Indicator Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color:
                      index == 0 ? Colors.grey : Colors.grey.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildColorOption(Color color, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          if (isSelected) // Show check icon if selected
            const Icon(
              Icons.check,
              color: Colors.white,
              size: 18,
            ),
        ],
      ),
    );
  }
}

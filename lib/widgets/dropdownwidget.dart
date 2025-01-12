import 'package:flutter/material.dart';

class SizeDropdownItems {
  // List of sizes from 6 to 64
  static List<DropdownMenuItem<int>> getItems() {
    final List<int> sizes = List.generate(59, (index) => index + 6);

    return sizes.map((int size) {
      return DropdownMenuItem<int>(
        value: size,
        child: Text('$size'),
      );
    }).toList();
  }
}

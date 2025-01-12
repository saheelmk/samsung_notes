import 'package:flutter/material.dart';

class NoteModel {
  final String title;
  final String body;
  final DateTime createdTime;
  bool isInRecycleBin; // Ensure you have this property
  final TextStyle textStyle; // Add textStyle to the model

  NoteModel({
    required this.title,
    required this.body,
    required this.createdTime,
    this.isInRecycleBin = false, // Default to false if not specified

    TextStyle? textStyle,
  }) : textStyle = textStyle ?? const TextStyle(); // Set a default TextStyle
}

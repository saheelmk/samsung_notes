import 'package:flutter/material.dart';
import 'package:samsung_note/themes/extension/theme.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  extensions: [
    ThemeWidget(
        primaryColor: Color.fromRGBO(246, 246, 246, 0.8),
        secondaryColor: Colors.black,
        randomColor: Colors.white,
        buttonColor: Colors.grey[100]!),
  ],
);

final ThemeData darkTheme = ThemeData.dark().copyWith(
  extensions: [
    ThemeWidget(
      primaryColor: Colors.black38,
      secondaryColor: Color.fromRGBO(242, 242, 242, 0.8),
      randomColor: Colors.grey[900]!,
      buttonColor: Colors.grey[800]!,
    ),
  ],
);

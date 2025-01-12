import 'package:flutter/material.dart';

class ThemeWidget extends ThemeExtension<ThemeWidget> {
  final Color primaryColor;
  final Color secondaryColor;
  final Color randomColor;
  final Color buttonColor;

  ThemeWidget({
    required this.primaryColor,
    required this.secondaryColor,
    required this.randomColor,
    required this.buttonColor,
  });

  @override
  ThemeWidget copyWith(
      {Color? primaryColor,
      Color? secondaryColor,
      Color? randomColor,
      Color? buttonColor}) {
    return ThemeWidget(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      randomColor: randomColor ?? this.randomColor,
      buttonColor: buttonColor ?? this.buttonColor,
    );
  }

  @override
  ThemeWidget lerp(ThemeWidget? other, double t) {
    if (other is! ThemeWidget) {
      return this;
    }
    return ThemeWidget(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      randomColor: Color.lerp(randomColor, other.randomColor, t)!,
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t)!,
    );
  }
}

import 'package:flutter/material.dart';

class CheckBoxWidget extends StatefulWidget {
  const CheckBoxWidget({super.key});

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool? isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      tristate: false,
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value;
        });
      },
    );
  }
}

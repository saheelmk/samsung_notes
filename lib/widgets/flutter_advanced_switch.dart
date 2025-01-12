import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class FLutterSwitch extends StatefulWidget {
  const FLutterSwitch({super.key});

  @override
  State<FLutterSwitch> createState() => _FLutterSwitchState();
}

class _FLutterSwitchState extends State<FLutterSwitch> {
  final _controller = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return AdvancedSwitch(
      controller: _controller,
      activeColor: Colors.orange[800]!,
      inactiveColor: Colors.grey,
      borderRadius: BorderRadius.circular(20),
      width: 35,
      height: 20,
    );
  }
}

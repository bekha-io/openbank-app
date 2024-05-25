import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  const Heading({super.key, required this.text, required this.level});

  final String text;
  final int level;

  double getFontSize() {
    switch (level) {
      case 1:
        return 48;
      case 2:
        return 38;
      case 3:
        return 30;
      case 4:
        return 20;
      case 5:
        return 18;
      case 6:
        return 16;
      default:
        return 16;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: getFontSize()),
    );
  }
}

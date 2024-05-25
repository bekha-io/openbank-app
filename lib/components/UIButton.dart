import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class UIButton extends StatefulWidget {
  const UIButton({super.key, required this.text, this.onPressed});

  final String text;
  final void Function()? onPressed;

  @override
  State<UIButton> createState() => _UIButtonState();
}

class _UIButtonState extends State<UIButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: double.maxFinite,
      child: TextButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
              padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 12, horizontal: 24)),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              backgroundColor: WidgetStatePropertyAll(Colors.black)),
          child: Text(
            widget.text,
            style: TextStyle(color: Colors.white, fontSize: 18),
          )),
    );
  }
}

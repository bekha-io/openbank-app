import 'package:flutter/material.dart';
import 'package:openbankapp/utils.dart';

class UITextInput extends StatefulWidget {
  const UITextInput(
      {super.key,
      required this.label,
      this.validator,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.maxLength,
      this.prefixText,
      this.obscure = false});

  final String label;
  final bool obscure;
  final String? prefixText;
  final int? maxLength;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  @override
  State<UITextInput> createState() => _UITextInputState();
}

class _UITextInputState extends State<UITextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      style: TextStyle(fontSize: 18),
      obscureText: widget.obscure,
      decoration: InputDecoration(
          fillColor: Color.fromARGB(255, 255, 255, 255),
          filled: true,
          prefix: widget.prefixText != null
              ? Text(
                  widget.prefixText!,
                )
              : null,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Colors.grey, width: 1.2)),
          labelText: widget.label,
          labelStyle: TextStyle(color: Colors.grey),
          floatingLabelStyle: TextStyle(
              fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold)),
    );
  }
}

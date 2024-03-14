// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscure;
  final TextEditingController controller;
  final FocusNode? focusNode;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.obscure,
    required this.controller,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x9c9c9c9c)),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          )),
          fillColor: const Color(0x00efefef),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade400)),
    );
  }
}

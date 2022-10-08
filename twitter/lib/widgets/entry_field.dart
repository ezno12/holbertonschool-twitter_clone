import 'package:flutter/material.dart';

class CustomEntryField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  late final bool isPassword;
  // ignore: prefer_const_constructors_in_immutables
  CustomEntryField(
      {Key? key,
      required this.hint,
      required this.controller,
      required this.isPassword})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      // ignore: prefer_const_constructors
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            filled: true, //<-- SEE HERE
            fillColor: Colors.grey.shade200,
            hintText: hint,
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.blue),
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
      ),
    );
  }
}
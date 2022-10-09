// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFlatButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  // ignore: prefer_const_constructors_in_immutables
  CustomFlatButton({
    Key? key,
    required this.label,
    required this.onPressed(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      // ignore: prefer_const_constructors
      child: Padding(
        // ignore: prefer_const_constructors
        padding: EdgeInsets.fromLTRB(50, 20, 50, 0),
        child: TextButton(
          child: Center(
            child: Container(
              child: Text(
                label,
                style: GoogleFonts.mulish(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          onPressed: () {
            onPressed();
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ))),
        ),
      ),
    );
  }
}
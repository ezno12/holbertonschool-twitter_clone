// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/entry_field.dart';
import '../widgets/flat_button.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    _emailController = _emailController;

    super.initState();
  }

  @override
  void dispose() {
    _emailController = _emailController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
            color: Colors.blue,
            onPressed: (() {
              Navigator.of(context).pop();
            }),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          // ignore: prefer_const_constructors
          title: Text(
            "Forget Password",
            style: TextStyle(color: Colors.black),
          )),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // ignore: prefer_const_constructors
            SizedBox(
              height: 150,
            ),
            // ignore: prefer_const_constructors
            Center(
              child: Text(
                "Forget password",
                style: GoogleFonts.mulish(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Enter your email address below to",
                style: GoogleFonts.mulish(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
            Center(
              child: Text(
                "recevie password reset instrection",
                style: GoogleFonts.mulish(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
            Center(
              child: CustomEntryField(
                hint: 'Enter Email',
                controller: _emailController,
                isPassword: false,
              ),
            ),
            Center(
              child: CustomFlatButton(
                label: "Submit",
                onPressed: () {},
              ),
            ),
          ],
        ),
      )),
    );
  }
}
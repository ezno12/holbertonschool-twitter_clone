import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twitter/widgets/flat_button.dart';
import '../widgets/entry_field.dart';

class SingIn extends StatefulWidget {
  const SingIn({super.key});

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  late TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _emailController = _emailController;
    _passwordController = _passwordController;
    super.initState();
  }

  @override
  void dispose() {
    _emailController = _emailController;
    _passwordController = _passwordController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 247, 246, 246),
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          // ignore: prefer_const_constructors
          title: Text(
            "Sing in",
            style: TextStyle(color: Colors.black),
          )),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          // ignore: prefer_const_constructors
          Container(
            height: 100,
            child: Image.asset('images/twitterIcon.png'),
          ),
          CustomEntryField(
            hint: 'Enter email',
            controller: _emailController,
            isPassword: false,
          ),
          CustomEntryField(
            hint: 'Enter password',
            controller: _passwordController,
            isPassword: true,
          ),
          Center(
            child: CustomFlatButton(
              label: "Submit",
              onPressed: () {
                //redirect after sumbit to sgin in!!!
              },
            ),
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: (() {
             //for sign up redirect
            }),
            child: Center(
              child: Text('Sign up',
                  style: GoogleFonts.mulish(
                    color: Colors.blue,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  )),
            ),
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: (() {
              //for forget password redirect
            }),
            child: Center(
              child: Text('Forget password?',
                  style: GoogleFonts.mulish(
                    color: Colors.blue,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
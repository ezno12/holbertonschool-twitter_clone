import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/widgets/flat_button.dart';
import '../providers/auth_state.dart';
import '../widgets/entry_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _confirmController = TextEditingController();

  @override
  void initState() {
    _nameController = _nameController;
    _passwordController = _passwordController;
    _emailController = _emailController;
    _confirmController = _confirmController;

    super.initState();
  }

  @override
  void dispose() {
    _nameController = _nameController;
    _emailController = _emailController;
    _passwordController = _passwordController;
    _confirmController = _confirmController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 246, 246),
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
            "Sing Up",
            style: TextStyle(color: Colors.black),
          )),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ignore: prefer_const_constructors
              SizedBox(
                height: 75,
              ),

              CustomEntryField(
                hint: 'Enter Name',
                controller: _nameController,
                isPassword: false,
              ),
              CustomEntryField(
                hint: 'Enter Email',
                controller: _emailController,
                isPassword: false,
              ),
              CustomEntryField(
                hint: 'Enter Password',
                controller: _passwordController,
                isPassword: true,
              ),
              CustomEntryField(
                hint: 'confirm Password',
                controller: _confirmController,
                isPassword: true,
              ),
              Center(
                child: CustomFlatButton(
                  label: "Submit",
                  onPressed: signUpUser,
                ),
              ),
              // ignore: prefer_const_constructors
            ],
          ),
        ),
      ),
    );
  }

  void signUpUser() async {
    final ifSignUp = await Auth().attemptSignUp(
        email: _emailController.text.trim(),
        name: _nameController.text.trim(),
        password: _passwordController.text.trim(),
        passwordConfirmation: _confirmController.text.trim()
    );
    String errorMsg = '';
    switch (ifSignUp) {
      case Errors.none:
        errorMsg = 'Account Created!';
        break;
      case Errors.weakError:
        errorMsg = 'The password provided is too weak.';
        break;
      case Errors.matchError:
        errorMsg = 'Passwords doesn’t match.';
        break;
      case Errors.existsError:
        errorMsg = 'An account already exists with that email.';
        break;
      case Errors.error:
        errorMsg = 'Failed to Login! Please try later.';
        break;
      default:
        errorMsg = 'Unknown error';
    }
    final snackBar = SnackBar(
      content: Text(errorMsg),
      backgroundColor: ifSignUp == Errors.none ? Colors.green : Colors.red,
      action: SnackBarAction(
        label: '',
        onPressed: () {
         },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter/widgets/showSnackbar.dart';

import '../screens/signin_screen.dart';

class Auth extends ChangeNotifier {
  final auth.FirebaseAuth _FirebaseAuth = auth.FirebaseAuth.instance;

   Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _FirebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      showSnackBar(
          context, e.message!); // Displaying the usual firebase error message
    }
  }
    Future<void> sendEmailVerification(BuildContext context) async {
    try {
     _FirebaseAuth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email verification sent!');
    } on auth.FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Display error message
    }
  }

   Future <SingIn> logout()  async{
    await auth.FirebaseAuth.instance.signOut();
    notifyListeners();
    return new SingIn();
}
}

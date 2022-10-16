import 'package:flutter/material.dart';
import 'package:twitter/providers/share_state.dart';
import 'package:twitter/screens/signin_screen.dart';
import 'package:provider/provider.dart';
import 'package:twitter/providers/auth_state.dart';


void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SharedState()),
       ChangeNotifierProvider(create: (_) => Auth())
    ],
    // ignore: prefer_const_constructors
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SingIn(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:twitter/providers/share_state.dart';
import 'package:twitter/screens/home_screen.dart';
import 'package:twitter/screens/signin_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SharedState())
    ],
    // ignore: prefer_const_constructors
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

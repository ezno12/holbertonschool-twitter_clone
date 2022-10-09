import 'package:flutter/material.dart';
import 'package:twitter/widgets/side_bar_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blueAccent,

        // ignore: prefer_const_constructors
        title: Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: SideBarMenu(),
    );
  }
}
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../widgets/users_search_results_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchconttroller = TextEditingController();
  @override
  void initState() {
    _searchconttroller = _searchconttroller;
    super.initState();
  }

  @override
  void dispose() {
    _searchconttroller = _searchconttroller;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        leading: Padding(
          padding: const EdgeInsets.all(6),
          child: CircleAvatar(
            maxRadius: 10,
            backgroundImage: NetworkImage(
                'https://intranet.hbtn.io/assets/holberton-logo-full-default-9c9d1742abc6ffb045e9b4af78ba85770bf39126bcf2c43af9d6a53ee4aabd3d.png'),
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Container(
          height: 38,
          child: TextField(
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade500,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none),
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                hintText: "Search.."),
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings_outlined,
                color: Colors.lightBlue,
              ))
        ],
      ),
      body: SafeArea(child: ListView.builder(
        itemBuilder: (context, index) {
          return UsersSearchResultsWidget(
            name: 'red',
            imgUrl:
                'https://intranet.hbtn.io/assets/holberton-logo-full-default-9c9d1742abc6ffb045e9b4af78ba85770bf39126bcf2c43af9d6a53ee4aabd3d.png',
            username: 'redxx',
          );
        },
      )),
    );
  }
}
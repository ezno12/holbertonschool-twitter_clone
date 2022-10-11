// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsersSearchResultsWidget extends StatelessWidget {
  late final String name;
  late final String username;
  late final String imgUrl;
  UsersSearchResultsWidget(
      {Key? key,
      required this.name,
      required this.username,
      required this.imgUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      title: Text(
        name,
        style: GoogleFonts.mulish(
          fontSize: 12,
        ),
      ),
      subtitle: Text(
        '@$username',
        style: GoogleFonts.mulish(
          fontSize: 12,
        ),
      ),
    );
  }
}
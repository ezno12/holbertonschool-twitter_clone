import 'package:flutter/material.dart';
import '../models/user.dart';
import '../providers/auth_state.dart';

class ProfileScreen extends StatefulWidget {
  final String userID;
  const ProfileScreen({Key? key, required this.userID}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    getAsync();
  }

  var user;
  var auth;
  var postsList;

  Future<void> getAsync() async {
    try {
      user = await User().getUserByID(widget.userID);
      auth = await Auth().getCurrentUserModel();
    } catch (e) {
      print(e);
    }
    if (mounted) setState(() {});
  }
  String buttonText = 'None';

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: User().getUserByID(widget.userID),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Scaffold(
            backgroundColor: Color.fromARGB(255, 247, 246, 246),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (User == null || auth == null) {
          return const Scaffold(
            backgroundColor: Color.fromARGB(255, 247, 246, 246),
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          User data = snapshot.data as User;


          var size = MediaQuery.of(context).size;

          if (data.userID == auth.userID) {
            buttonText = 'Edit profile';
          } else if (data.followersList.contains(auth.userID)) {
            buttonText = 'Unfollow';
          } else {
            buttonText = 'Follow';
          }

          return Scaffold(
            body: ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: [
              
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                      image: NetworkImage(data.coverImgUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ]
            )
          );
        }
   } );

  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twitter/providers/auth_state.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../screens/profile_screen.dart';


class PostWidget extends StatefulWidget {
  final Post post;
  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {

  var user;
  var auth;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    getAsync();
  }

  Future<void> getAsync() async {
    try {
      user = await User().getUserByID(widget.post.userID);
      auth = await Auth().getCurrentUserModel();

    } catch (e) {
      print(e);
    }
    if (mounted) setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    if (user == null || auth == null) {
      return Center(
          child: Container(
            height: 30,
            width: 30,
            margin: const EdgeInsets.symmetric(vertical: 50),
            child: const CircularProgressIndicator(),
          )
      );
    }
    final Post post = widget.post;

    isLiked = post.likeList.contains(auth.userID) ? true : false;

    return ListTile(
      leading: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen(userID: post.userID)),
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.imageUrl),
              ),
            ),
          ),
        ],
      ),
      title: Row(
        children: [
          SizedBox(
            height: 20,
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen(userID: post.userID)),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  user.displayName,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),

            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 5, 5),
            child: user.isVerified ?
              Row(
                children: [
                  const SizedBox(width: 5),
                  Icon(
                    Icons.verified_rounded,
                    size: 10,
                    color: user.isVerified ? Colors.lightBlue : Colors.transparent,
                  ),
                ],
              ) :
              const SizedBox(width: 1),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 5, 5),
            child: Text(
              '@${user.userName}',
              style: GoogleFonts.raleway(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
      subtitle: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              post.text,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Colors.black,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child:
                Icon(
                  Icons.mode_comment_outlined,
                  size: 18,
                  color: Colors.grey.shade400,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                child:
                const Text('2'),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                child:
                Icon(
                  Icons.repeat_rounded,
                  size: 18,
                  color: Colors.grey.shade400,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                child:
                const Text('2'),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                child: IconButton(
                  onPressed: () {
                    setState(
                          () {
                        if (!isLiked) {
                          Post().setPostLike(post, auth.userID).then((_) {
                            setState(() {
                              post.likeCount++;
                              isLiked = true;
                            });
                          });
                        } else {
                          Post().delPostLike(post, auth.userID).then((_) {
                            setState(() {
                              post.likeCount--;
                              isLiked = false;
                            });
                          });

                        }
                      },
                    );
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: isLiked ? Colors.red : Colors.grey.shade400,
                    size: 18,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
                width: 90,
                margin: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                child: Text(post.likeCount.toString()),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                alignment: AlignmentDirectional.topEnd,
                child: Icon(
                  Icons.share,
                  size: 18,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          )
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(
            Icons.more_horiz_outlined,
            size: 20,
            color: Colors.black,
          ),
        ],
      ),
    );
    }
    }

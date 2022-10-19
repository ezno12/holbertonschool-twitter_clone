import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/post.dart';

class EditPostScreen extends StatefulWidget {
  final String userID;
  const EditPostScreen({Key? key, required this.userID}) : super(key: key);

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final TextEditingController _tweetController = TextEditingController();
  var data;

  Future addPost() async {
    var errorValue;
    bool isError = false;
    String snackMsg = '';

    if (_tweetController.text == '') {
      errorValue = Errors.valueError;
    } else {
      errorValue = await Post().addPostFirebase(
          Post(
            text: _tweetController.text,
            userID: widget.userID,
          )
      );
    }

    if (errorValue != Errors.none) isError = true;

    switch (errorValue) {
      case Errors.none:
        snackMsg = 'Your post has been created.';
        setState(() {
          _tweetController.text = '';
        });
        break;
      case Errors.valueError:
        snackMsg = "Your post can't be empty.";
        break;
      case Errors.error:
        snackMsg = "An error occurred! Try again later";
        break;
    }

    final snackBar = SnackBar(
      content: Text(snackMsg),
      backgroundColor: isError ? Colors.red : Colors.green,
      action: SnackBarAction(
        label: '',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


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
          }
          data = snapshot.data as User;
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: const Color.fromARGB(255, 247, 246, 246),
              leading: CloseButton(
                color: Colors.black,
                onPressed: (() {
                  Navigator.of(context).pop();
                }),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: ElevatedButton(
                    onPressed: addPost,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    child: const Text(
                      'Tweet',
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 15),
                    Column(
                      children: [
                        SizedBox(height: 10,),
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 25,
                          backgroundImage: NetworkImage(data.imageUrl),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    Container(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: 300,
                        child: TextField(
                          controller: _tweetController,
                          maxLines: 6,
                          decoration: const InputDecoration(
                            hintText: 'Write your post here...',
                          ),
                        ),
                      ),
                    ),
                    ],
                  ),
              ],
            ),

          );
        }
    );
  }
}
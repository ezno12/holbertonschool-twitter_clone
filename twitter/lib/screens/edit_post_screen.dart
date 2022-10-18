import 'package:flutter/material.dart';
import '../models/user.dart';

class EditPostScreen extends StatefulWidget {
  final String userID;
  const EditPostScreen({Key? key, required this.userID}) : super(key: key);

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final TextEditingController _tweetController = TextEditingController();
  var data;


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
                    onPressed: (){},
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
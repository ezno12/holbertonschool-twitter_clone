import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../providers/auth_state.dart';


class EditProfileScreen extends StatefulWidget {
  final String userID;
  const EditProfileScreen({Key? key, required this.userID}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  PlatformFile? pickedProfileImg;
  PlatformFile? pickedCoverImg;
  UploadTask? uploadTask;

  @override
  void initState() {
    super.initState();
    getAsync();
  }
  String buttonText = '';
  var data;
  var user;
  var auth;

  Future<void> getAsync() async {
    try {
      auth = await Auth().getCurrentUserModel();
    } catch (e) {
      print(e);
    }
    if (mounted) setState(() {});
  }
  
  Future selectProfileImg() async {
    final String txtDisplayName = _nameController.text;
    final String txtUserName = _userNameController.text;
    final String txtBio = _bioController.text;
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedProfileImg = result.files.first;

      _nameController.text = txtDisplayName;
      _userNameController.text = txtUserName;
      _bioController.text = txtBio;
    });
  }


  Future selectCoverImg() async {
    final String txtDisplayName = _nameController.text;
    final String txtUserName = _userNameController.text;
    final String txtBio = _bioController.text;
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedCoverImg = result.files.first;
      _nameController.text = txtDisplayName;
      _userNameController.text = txtUserName;
      _bioController.text = txtBio;
    });
  }

  Future<String> uploadImage(PlatformFile? picket) async {
    final path = 'files/${picket!.name}';
    final file = File(picket.path!);

    final ref = FirebaseStorage.instance.ref().child(path);

    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() { print('inside when completed name controller: ${_nameController.text}');});

    print('inside name controller: ${_nameController.text}');

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: ${urlDownload}');
    return urlDownload;
  }

  Future saveChanges() async {
    String snackMsg = '';
    bool isError = false;
    final String displayName = _nameController.text;
    final String userName = _userNameController.text;
    final String bio = _bioController.text;
    try {
      final String coverImgUrl = pickedCoverImg != null ? await uploadImage(pickedCoverImg) : data.coverImgUrl;
      final String imageUrl = pickedProfileImg != null ? await uploadImage(pickedProfileImg) : data.imageUrl;
      //set changed values to user
      data.coverImgUrl = coverImgUrl;
      data.imageUrl = imageUrl;
      data.displayName = displayName != '' ? displayName: data.displayName;
      data.userName = userName != '' ? userName : data.userName;
      data.bio = bio != '' ? bio : data.bio;

      await User().saveChangesFirebase(data);
      snackMsg = 'Profile was updated successfully!';
      pickedCoverImg = null;
      pickedProfileImg = null;
    } catch(e) {
      isError = true;
      snackMsg = 'Update profile failed! Try again later';
    } finally {
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
  }

  // returnProfile(userID) => Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => EditProfileScreen(userID: userID)),
  // );

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
        _nameController.text = _nameController.text != '' && _nameController.text != data.displayName ? _nameController.text : data.displayName;
        _userNameController.text = _userNameController.text != '' && _userNameController.text != data.userName ? _userNameController.text : data.userName;
        _bioController.text = _bioController.text != '' && _bioController.text!= data.bio ? _bioController.text : data.bio;

        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: const Color.fromARGB(255, 247, 246, 246),
            //centerTitle: true,
            leading: BackButton(
              color: Colors.blue,
              onPressed: (() {
                Navigator.of(context).pop();
              }),
            ),
            title: const Text(
              "Edit profile",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => setState(() {saveChanges();}), // Navigator.of(context).pop(),
                child: const Text(
                  'Save',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                  ),
                ),
              ),
            ],
          ),
          body: ListView(
            children: [
              TextButton(
                onPressed: selectCoverImg,
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                      image: pickedCoverImg != null ?
                        Image.file(File(pickedCoverImg!.path!), width: double.infinity, fit: BoxFit.cover).image
                          :
                        NetworkImage(data.coverImgUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                      child: Icon(
                        color: Colors.white.withOpacity(0.9),
                        Icons.photo_camera_outlined,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: selectProfileImg,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 45,
                          child: CircleAvatar(
                            radius: 43,
                            backgroundImage: pickedProfileImg!= null ?
                              Image.file(File(pickedProfileImg!.path!), fit: BoxFit.cover,).image
                              :
                              NetworkImage(data.imageUrl),
                            child: CircleAvatar(
                              backgroundColor: Colors.black.withOpacity(0.5),
                              radius: 43,
                              child: Center(
                                child: Icon(
                                  color: Colors.white.withOpacity(0.9),
                                  Icons.photo_camera_outlined,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        )
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16,
                      ),
                    ),
                    TextField(
                      controller: _nameController,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      'Username',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16,
                      ),
                    ),
                    TextField(
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      controller: _userNameController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      'Bio',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16,
                      ),
                    ),
                    TextField(
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      controller: _bioController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ],
          ),

        );
      }
    );
  }
}

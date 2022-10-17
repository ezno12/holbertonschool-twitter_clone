import 'package:random_string/random_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final usersRef = FirebaseFirestore.instance.collection('users').withConverter<User>(
  fromFirestore: (snapshot, _) {
    User.fromJson(snapshot.data()!);
    return User.fromJson(
      snapshot.data() ?? {},
    );
  },
  toFirestore: (user, _) => user.toJson(),
);

class User {
  String key;
  String userID;
  String email;
  String userName;
  String displayName;
  String imageUrl;
  int followers ;
  int following;
  List<dynamic> followersList;
  List<dynamic> followingList;

  User({
    String key = '',
    String userID = '',
    String email = '',
    String userName = '',
    String displayName = '',
    String imageUrl = 'https://freepngimg.com/thumb/google/66726-customer-account-google-service-button-search-logo.png',
    int followers = 0,
    int following = 0,
    List<dynamic> followersList = const [],
    List<dynamic> followingList = const [],
  }) : this._(
    key: uuid.v4(),
    userID: userID,
    email: email,
    userName: randomAlphaNumeric(8),
    displayName: displayName,
    imageUrl: imageUrl,
    followers: followers,
    following: following,
    followersList: followersList,
    followingList: followingList,
  );

  User._({
    required this.key,
    required this.userID,
    required this.email,
    required this.userName,
    required this.displayName,
    required this.imageUrl,
    required this.followers,
    required this.following,
    required this.followersList,
    required this.followingList,
  });

  User.fromJson(Map<dynamic, dynamic> map)
      : key = map['key'],
        userID = map['userID'],
        email = map['email'],
        userName = map['userName'],
        displayName = map['displayName'],
        imageUrl = map['imageUrl'],
        followers = map['followers'],
        following = map['following'],
        followersList = map['followersList'],
        followingList = map['followingList'];


  Map<String, dynamic> toJson() => {
    'key': key,
    'userID': userID,
    'email': email,
    'userName': userName,
    'displayName': displayName,
    'imageUrl': imageUrl,
    'followers': followers,
    'following': following,
    'followersList': followersList,
    'followingList': followingList,
  };
}
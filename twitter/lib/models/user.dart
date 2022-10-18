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
  String bio;
  String coverImgUrl;
  bool isVerified;

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
    String bio = 'No bio available',
    String coverImgUrl = 'https://images.wondershare.com/repairit/aticle/2021/08/twitter-header-photo-issues-1.jpg',
    bool isVerified = false,
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
    bio: bio,
    coverImgUrl: coverImgUrl,
    isVerified: isVerified,
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
    required this.bio,
    required this.coverImgUrl,
    required this.isVerified,
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
        followingList = map['followingList'],
        bio = map['bio'],
        coverImgUrl = map['coverImgUrl'],
        isVerified = map['isVerified'];


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
    'bio': bio,
    'coverImgUrl': coverImgUrl,
    'isVerified': isVerified,
  };

  Future<User> getUserByID(String userID) async {

    Query query = usersRef.where("userID", isEqualTo: userID);
    QuerySnapshot querySnapshot = await query.get();

    return querySnapshot.docs.first.data() as User;
  }

  Future<List<User>> getUsersListBySearch() async {

    Query query = usersRef.where("userID", isEqualTo: userID);

    QuerySnapshot querySnapshot = await query.get();
    List<User>? allUsers = querySnapshot.docs.map((doc) => doc.data()).cast<User>().toList();

    return allUsers;
  }

  Future<void> saveChangesFirebase(User user) async {
    String userDocID = await getPostReference(user.userID);

    await usersRef.doc(userDocID).update(
        {
          'coverImgUrl': user.coverImgUrl,
          'imageUrl': user.imageUrl,
          'displayName': user.displayName,
          'userName': user.userName,
          'bio': user.bio,
        }
    );
    print('executed update profile');
  }
   Future<String> getPostReference(String userID) async {
    return FirebaseFirestore.instance
        .collection('users')
        .where('userID', isEqualTo: userID)
        .get()
        .then((value) {
          for (var element in value.docs) {
            return element.id;
          }
          return '';
        });
  }
}
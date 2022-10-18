import 'package:cloud_firestore/cloud_firestore.dart';

final postRef = FirebaseFirestore.instance.collection('posts').withConverter<Post>(
  fromFirestore: (snapshot, _) {
    Post.fromJson(snapshot.data()!);
    return Post.fromJson(
      snapshot.data() ?? {},
    );
  },
  toFirestore: (post, _) => post.toJson(),
);

enum Errors {none, valueError, error}

class Post {
  String text;
  String userID;
  int likeCount;
  List<dynamic> likeList;

  Post({
    this.text = '',
    this.userID = '',
    this.likeCount = 0,
    this.likeList = const [],
  });

  Post.fromJson(Map<dynamic, dynamic> map)
    : text =  map['text'],
      userID = map['userID'],
      likeCount = map['likeCount'],
      likeList = map['likeList'];

  Map<String, dynamic> toJson() => {
    'text': text,
    'userID': userID,
    'likeCount': likeCount,
    'likeList': likeList,
  };

  Future addPostFirebase(Post post) async {

    return await postRef.doc().set(post).then((value) => Errors.none)
     .catchError((error) {
       print(error);
       return Errors.error;
     });
  }

  Future<List<Post>> getAllPostList() async {

    QuerySnapshot querySnapshot = await postRef.get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).cast<Post>().toList();

    return allData;
  }

  Future<List<Post>> getCurrentUserPosts(String userID) async {
    Query query = postRef.where('userID', isEqualTo: userID);

    QuerySnapshot querySnapshot = await query.get();

    List<Post> allPosts = querySnapshot.docs.map((doc) => doc.data()).cast<Post>().toList();

    return allPosts;
  }

  Future setPostLike(Post post, String userID) async {
    String postID = await getPostReference(post.userID, post.text);

    post.likeList.insert(0, userID);

    await postRef.doc(postID).update(
        {'likeList': post.likeList, 'likeCount': post.likeList.length }
    );
    print('executed like');
  }

  Future delPostLike(Post post, String userID) async {
    String postID = await getPostReference(post.userID, post.text);

    post.likeList.remove(userID);

    await postRef.doc(postID).update(
        {'likeList': post.likeList, 'likeCount': post.likeList.length }
    );
    print('executed dislike');
  }

  Future<String> getPostReference(String userID, String text) async {
    return FirebaseFirestore.instance
        .collection('posts')
        .where('userID', isEqualTo: userID)
        .where('text', isEqualTo: text)
        .get()
        .then((value) {
      for (var element in value.docs) {
        return element.id;
      }
      return '';
    });
  }

}

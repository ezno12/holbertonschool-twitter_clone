// ignore_for_file: prefer_collection_literals

class User {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;

   User({this.uid, this.email, this.firstName, this.secondName});

   // receiving data from server
  factory User.fromMap(map) {
    return User(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
    );
  }

    // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
    };
  }

}
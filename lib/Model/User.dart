import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  late String id;
  late String fullname;
  late String pseudo;
  late String email;
  late String avatar;

  User(DocumentSnapshot snapshot) {
    id = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    fullname = map['FULLNAME'];
    pseudo = map['PSEUDO'];
    email = map['EMAIL'];
    avatar = map['AVATAR'];
  }
}
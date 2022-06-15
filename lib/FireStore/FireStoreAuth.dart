import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:amazon/Model/User.dart' as UserModel;

class FireStoreAuth {

  final auth = FirebaseAuth.instance;
  final fire_user = FirebaseFirestore.instance.collection('Users');

  Future <UserModel.User> getUser(uid) async {
    DocumentSnapshot snapshot = await fire_user.doc(uid).get();
    return UserModel.User(snapshot);
  }

  addUser(String uid, Map<String, dynamic> map) {
    fire_user.doc(uid).set(map);
  }

  Future <UserModel.User> register(String pseudo, String fullname, String email, String password) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    User userFirebase = result.user!;
    String uid = userFirebase.uid;
    Map<String, dynamic> map = {
      'FULLNAME': fullname,
      'PSEUDO': pseudo,
      'EMAIL': email,
      'AVATAR': null
    };
    addUser(uid, map);
    return getUser(uid);
  }

  Future<UserModel.User> login(String email, String password) async {
    UserCredential result = await auth.signInWithEmailAndPassword(email: email, password: password);
    String uid = result.user!.uid;
    return getUser(uid);
  }
}
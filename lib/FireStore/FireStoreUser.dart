import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStoreUser {

  final auth = FirebaseAuth.instance;
  final fire_user = FirebaseFirestore.instance.collection('Users');
  final storage = FirebaseStorage.instance;

  updateUser(String uid , Map<String,dynamic> map){
    fire_user.doc(uid).update(map);
  }

  Future<String> storeImg(Uint8List bytes) async {
    TaskSnapshot tskSnapshot = await storage.ref('UserAvatar/${auth.currentUser!.uid + DateTime.now().toString()}').putData(bytes);
    String url = await tskSnapshot.ref.getDownloadURL();
    return url;
  }
}
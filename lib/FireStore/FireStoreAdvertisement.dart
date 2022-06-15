import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Model/Advertisement.dart';

class FireStoreAdvertisement {

  final fire_advertisement = FirebaseFirestore.instance.collection('Advertisements');
  final storage = FirebaseStorage.instance;

  Future<Advertisement> getAds() async {
    DocumentSnapshot snapshot = await fire_advertisement.doc().get();
    return Advertisement(snapshot);
  }

  createAd(String name, String description) async {
    Map<String, dynamic> map = {
      'NAME': name,
      'DESCRIPTION': description
    };
    await fire_advertisement.add(map);
  }

  updateAd(String uid, Map<String, dynamic> map) {
    fire_advertisement.doc(uid).update(map);
  }

  deleteAd(String uid) {
    fire_advertisement.doc(uid).delete();
  }

  Future<String> storeImg(Uint8List bytes) async {
    TaskSnapshot tskSnapshot = await storage.ref('Ad/${DateTime.now().toString()}').putData(bytes);
    String url = await tskSnapshot.ref.getDownloadURL();
    return url;
  }
}
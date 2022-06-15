import 'package:cloud_firestore/cloud_firestore.dart';

class Advertisement {

  late String id;
  late String name;
  late String description;
  late String image;
  DateTime created = DateTime.now();

  Advertisement(DocumentSnapshot snapshot) {
    id = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    name = map['NAME'];
    description = map['DESCRIPTION'];
    image = map['IMAGE'];
    Timestamp timestamp = map['CREATED'];
    created = timestamp.toDate();
  }
}
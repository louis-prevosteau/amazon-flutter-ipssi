import 'package:amazon/FireStore/FireStoreAdvertisement.dart';
import 'package:amazon/Model/Advertisement.dart';
import 'package:amazon/View/CreateAd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Dashboard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Ads'),
      ),
      body: dashboardPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return CreateAd();
              }
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget dashboardPage() {
    return StreamBuilder<QuerySnapshot>(
      stream: FireStoreAdvertisement().fire_advertisement.snapshots(),
      builder: (context, snapshots) {
        if (!snapshots.hasData) {
          return Text('No Ads');
        } else {
          List documents = snapshots.data!.docs;
          return ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: documents.length,
            itemBuilder: (context, index) {
              Advertisement ad = Advertisement(documents[index]);
              return Dismissible(
                direction: DismissDirection.startToEnd,
                onDismissed: (DismissDirection direction) {
                  FireStoreAdvertisement().deleteAd(ad.id);
                },
                key: Key(ad.id),
                child: Card(
                  elevation: 20,
                  color: Colors.lightGreen,
                  child: ListTile(
                    title: Text(ad.name),
                    subtitle: Text(ad.description),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
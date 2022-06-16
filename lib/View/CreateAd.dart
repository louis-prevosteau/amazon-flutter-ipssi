import 'package:amazon/FireStore/FireStoreAdvertisement.dart';
import 'package:amazon/View/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreateAd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CreateAdState();
  }
}

class CreateAdState extends State<CreateAd> {

  String name = '';
  String description = '';
  DateTime created = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add an advertisement')
      ),
      body: Padding(
        child: createAdPage(),
        padding: const EdgeInsets.all(10),
      ),
    );
  }

  Widget createAdPage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10,),
          TextField(
            decoration: InputDecoration(
              hintText: 'Name'
            ),
            onChanged: (String value) {
              setState(() {
                name = value;
              });
            },
          ),
          const SizedBox(height: 10,),
          TextField(
            decoration: InputDecoration(
                hintText: 'Description'
            ),
            onChanged: (String value) {
              setState(() {
                description = value;
              });
            },
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
          ),
          const SizedBox(height: 10,),
          ElevatedButton(
              onPressed: () {
                FireStoreAdvertisement().createAd(name, description);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Dashboard();
                }));
              },
              child: Text('Add')
          )
        ],
      ),
    );
  }
}
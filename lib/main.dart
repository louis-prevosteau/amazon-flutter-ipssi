import 'package:amazon/FireStore/FireStoreAuth.dart';
import 'package:amazon/Model/globalModels.dart';
import 'package:amazon/View/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {

// ...
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String fullname = '';
  String pseudo = '';
  String email = '';
  String password = '';
  bool isRegister = true;
  List<bool> selection = [true, false];


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
        child: authPage(),
        padding: const EdgeInsets.all(10),
      )
    );
  }

  Widget authPage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10,),
          ToggleButtons(
              children: const [
                Text('Register'),
                Text('Login')
              ],
              isSelected: selection,
              onPressed: (index) {
                index == 0 ? {
                  setState(() {
                    selection[0] = true;
                    selection[1] = false;
                    isRegister = true;
                  })
                } :
                {
                    setState(() {
                      selection[0] = false;
                      selection[1] = true;
                      isRegister = false;
                    }
                  )
                };
              },
          ),
          (isRegister) ? TextField(
            decoration: InputDecoration(
              hintText: 'Nom Complet'
            ),
            onChanged: (String value) {
              setState(() {
                fullname = value;
              });
            },
          ) : Container(),
          (isRegister) ? TextField(
            decoration: InputDecoration(
                hintText: 'Pseudo'
            ),
            onChanged: (String value) {
              setState(() {
                pseudo = value;
              });
            },
          ) : Container(),
          const SizedBox(height: 10,),
          TextField(
              decoration: InputDecoration(
                  hintText: 'Email'
              ),
              onChanged: (String value) {
                setState(() {
                  email = value;
                });
              }
          ),
          const SizedBox(height: 10,),
          TextField(
            obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Mot de passe'
              ),
              onChanged: (String value) {
                setState(() {
                  password = value;
                });
              }
          ),
          const SizedBox(height: 10,),
          ElevatedButton(
              onPressed: ()  => isRegister == true ? register() : login(),
              child: Text('Valider')
          )
        ],
      ),
    );
  }

  register() {
    FireStoreAuth().register(pseudo, fullname, email, password).then((value) {
      setState(() {
        GlobalUser = value;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Dashboard();
      }));
    });
  }
  
  login() {
    FireStoreAuth().login(email, password).then((value) {
      setState(() {
        GlobalUser = value;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Dashboard();
      }));
    });
  }
}

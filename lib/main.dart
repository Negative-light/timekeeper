import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:timekeeper/charge_codes_widget.dart';
import 'package:timekeeper/clock_in_widget.dart';
import 'package:timekeeper/projects_widget.dart';
import 'package:timekeeper/stats_widget.dart';
import 'package:timekeeper/today_info_widget.dart';
import 'package:timekeeper/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Database db = Database.instance;
  db._connectToDatabase();

  runApp(const MyApp());
}
class Database {
  //singleton class database reference
  Database._privateConstructor();
  static final Database _instance = Database._privateConstructor();
  static Database get instance => _instance;

  //firestore database reference
  dynamic db;

  //get firestore reference
  void _connectToDatabase() async {
    await Firebase.initializeApp (
      options: DefaultFirebaseOptions.currentPlatform,
    );

    db = FirebaseFirestore.instance;
  }

  //get a user by username
  dynamic getUser(String username){
    dynamic user;
    db.collection("users").where("name", isEqualTo: username).get().then(
          (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          user =  docSnapshot;
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return user;
  }

  //publishes user to db
  void storeUser(String email, String name, String password, int phone,  supervisorId){
    final users = db.collection("users");

    final data = <String, dynamic>{
      "email": email,
      "name": name,
      "password" : password,
      "phone": phone,
      "supervisorId": supervisorId,
    };

    db.collection("users").add(data).then((documentSnapshot) =>
        print("Added Data with ID: ${documentSnapshot.id}"),
        onError: (e) => print("Error adding user : $e"));
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timekeeper',
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
      home: const MyHomePage(title: 'Clock-In'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
  int _currentNavIndex = 2;
  final screens = [
    StatsWidget(),
    const TodayWidget(),
    const ClockInWidget(),
    ChargeCodesWidget(),
    const ProjectsWidget()
  ];


  void _incrementCounter() {
    Database db = Database.instance;
    dynamic lUser = db.getUser("testUser");
    db.storeUser("testEmail123@123.com", "10:37test", "password", 4572843234, "e3482945234");
  }


  void _onNavBarClick(int index) {
    setState(() {
      _currentNavIndex = index;
    });
  }

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
      body:  IndexedStack(index: _currentNavIndex, children: screens,),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(label: "Stats", icon: Icon(Icons.accessibility)),
          BottomNavigationBarItem(label: "Today", icon: Icon(Icons.accessibility)),
          BottomNavigationBarItem(icon: Icon(Icons.hourglass_empty), label: "HOME"),
          BottomNavigationBarItem(label: "Charge Codes", icon: Icon(Icons.accessibility)),
          BottomNavigationBarItem(label: "Projects", icon: Icon(Icons.accessibility)),
        ],
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.black,
        currentIndex: _currentNavIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: _onNavBarClick,
      ),

    );
  }


  }





// ignore_for_file: avoid_print


import 'package:flutter/material.dart';

import 'package:timekeeper/charge_codes_widget.dart';
import 'package:timekeeper/clock_in_widget.dart';
import 'package:timekeeper/login_page/login_page.dart';
import 'package:timekeeper/projects_widget.dart';
import 'package:timekeeper/stats_widget.dart';
import 'package:timekeeper/today_info_widget.dart';
import 'package:timekeeper/database_interface.dart';
import 'package:timekeeper/data_model.dart';


Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Database db = Database.instance;
  db.connectToDatabase();

  runApp(const MyApp());
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
      home:  const Main()
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  createState() => _MainAppState();
}

class _MainAppState extends State<Main> {
  final bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    //TODO: Check if user is logged in or not
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Time Keeper",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,

      ),
      home: _isLoggedIn ? const MyHomePage(title: "Time Keeper") : const LoginPage()
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
    ProjectsWidget()
  ];


  void _onNavBarClick(int index) {
    setState(() {
      _currentNavIndex = index;
    });

    //test to get data
    Database db = Database.instance;
    db.getUser('testUser', 'password');
    db.getChargeCodes();

    DataModel dm = DataModel.instance;
    print('id = ${dm.user.id}');
    print('name = ${dm.user.name}');
    print('password = ${dm.user.password}');
    print('email = ${dm.user.email}');
    print('phone = ${dm.user.phone}');
    print('supervisor id = ${dm.user.supervisorId}');

    for(int i = 0; i < dm.chargeCodes.length; i++) {
      print('id = ${dm.chargeCodes[i].id}');
      print('name = ${dm.chargeCodes[i].name}');
      print('budget = ${dm.chargeCodes[i].budget}');
      print('description = ${dm.chargeCodes[i].description}');
      print('status = ${dm.chargeCodes[i].status}');
      print('project = ${dm.chargeCodes[i].project}');
    }

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




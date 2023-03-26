import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timekeeper/dataModel.dart';
import 'package:timekeeper/firebase_options.dart';

import 'objects/charge_code.dart';
import 'objects/user.dart';

class Database {
  //singleton class database reference
  Database._privateConstructor();

  static final Database _instance = Database._privateConstructor();

  static Database get instance => _instance;

  //firestore database reference
  dynamic db;

  //get firestore reference
  void connectToDatabase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    db = FirebaseFirestore.instance;
  }

  //get a user by username
  bool getUser(String username, String password) {
    bool gotUser = false;
    db
        .collection("users")
        .where("name", isEqualTo: username)
        .where("password", isEqualTo: password)
        .get()
        .then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          gotUser = true;
          final data = docSnapshot.data() as Map<String, dynamic>;
          User user = User();
          user.id = docSnapshot.id;
          user.email = data['email'];
          user.name = data['name'];
          user.password = data['password'];
          user.phone = data['phone'];
          user.supervisorId = data['supervisorId'];
          user.isLoggedIn = true;
          DataModel.instance.user = user;
        }
      },
      onError: (e) => print("Error completing: $e"),
    );

    return gotUser;
  }

  //publishes user to db
  void storeUser(
      String email, String name, String password, int phone, supervisorId) {
    final data = <String, dynamic>{
      "email": email,
      "name": name,
      "password": password,
      "phone": phone,
      "supervisorId": supervisorId,
    };

    db.collection("users").add(data).then(
        (documentSnapshot) =>
            print("Added Data with ID: ${documentSnapshot.id}"),
        onError: (e) => print("Error adding user : $e"));
  }

  bool getChargeCodes() {
    bool gotCodes = false;
    db.collection("chargeCodes").get().then(
      (querySnapshot) {
        print("Successfully completed");
        List<ChargeCode> chargeCodes = <ChargeCode>[];
        for (var docSnapshot in querySnapshot.docs) {
          gotCodes = true;
          final data = docSnapshot.data() as Map<String, dynamic>;
          ChargeCode cc = ChargeCode(
              docSnapshot.id,
              data['Budget'],
              data['Name'],
              data['Description'],
              data['Description'],
              data['Project'],
              data['OwnerId']);
          chargeCodes.add(cc);
        }
        DataModel.instance.chargeCodes = chargeCodes;
      },
      onError: (e) => print("Error completing: $e"),
    );
    return gotCodes;
  }
}
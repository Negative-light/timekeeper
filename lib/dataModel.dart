class DataModel {
  //singleton class data model reference
  DataModel._privateConstructor();
  static final DataModel _instance = DataModel._privateConstructor();
  static DataModel get instance => _instance;

  //current user
  User user =  User();

  //list containing charge code objects
  List<ChargeCode> chargeCodes = <ChargeCode>[];
}

class User {
  bool isLoggedIn = false;
  String id = "";
  String email = "";
  String name = "";
  String password = "";
  int phone = 0;
  String supervisorId = "";
}

class ChargeCode {
  String id = "";
  int budget = 0;
  int status = 0;
  String description = "";
  String name = "";
  String ownerId = "";
  String project = "";
}
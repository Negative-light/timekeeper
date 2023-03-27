import 'objects/charge_code.dart';
import 'objects/user.dart';
import 'objects/punch_in.dart';
import 'objects/client.dart';
import 'objects/projects.dart';
import 'objects/user_budget.dart';
class DataModel {
  //singleton class data model reference
  DataModel._privateConstructor();
  static final DataModel _instance = DataModel._privateConstructor();
  static DataModel get instance => _instance;

  //current user
  User user =  User();

  //list containing charge code objects
  List<ChargeCode> chargeCodes = <ChargeCode>[];
    //list containing charge code objects
}




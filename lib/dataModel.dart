import 'objects/charge_code.dart';
import 'objects/user.dart';
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




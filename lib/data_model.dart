import 'objects/project.dart';
import 'objects/user_budget.dart';
import 'objects/charge_code.dart';
import 'objects/user.dart';
import 'objects/client.dart';
import 'objects/punch_in.dart';

class DataModel {
  //singleton class data model reference
  DataModel._privateConstructor();
  static final DataModel _instance = DataModel._privateConstructor();
  static DataModel get instance => _instance;

  //current user
  User user =  User();

  //list containing charge code objects
  List<ChargeCode> chargeCodes = <ChargeCode>[];
    
  //list containing punch in objects 
  List<UserBudget> userBudget = <UserBudget>[];
     
  //list containing clients
  List<Client> clients = <Client>[];
      
  //list containing projects 
  List<Project> projects = <Project> [];
      
  //list containing punch ins
  List<PunchIn> punches = <PunchIn> [];
  
}




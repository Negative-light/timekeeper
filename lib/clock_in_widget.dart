
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'database_interface.dart';
import 'data_model.dart';
import 'objects/charge_code.dart';
import 'objects/Punch_in.dart';

class ClockInWidget extends StatefulWidget {
  const ClockInWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ClockInState();
}
 /* Widget build(BuildContext context) {

  CollectionReference referenceToProj = Database.instance.db.collection('Punch In');
    _projectStream = referenceToProj.snapshots();
  State<StatefulWidget> createState() => _ClockInState();
  return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: _codeStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              if (snapshot.connectionState == ConnectionState.active)
              {
                QuerySnapshot querySnapshot = snapshot.data;
                var ClocckIn = [];
                for (var docSnapshot in querySnapshot.docs) {
                  final data = docSnapshot.data() as Map<String, dynamic>;

                //get project name corresponding to the current charge code
                 String name = "";
                 for(Clock  in DataModel.instance.clock_in){
                   final data = docSnapshot.data() as Map<String, dynamic>;
                clock_in C = Clock_IN();
             C.Punchintime = DateTime(2023);
             C.Chargecode = (data['Chargecode']).toString();
             C.punch in type = data['punch in type']
             C.userID = (data['User ID']).toString();
             
             ClockIn.add(C);
               } */
class ClockButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Icon icon;

  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    shape: const CircleBorder(),
    //padding: const EdgeInsets.all(100),
    backgroundColor: Colors.blue,
    foregroundColor: Colors.black,
    minimumSize: Size.infinite,
  );

  const ClockButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: onPressed,
        style: buttonStyle,
        child: icon,
      ),
    );
  }
}

enum ClockInState {
  clockIn,
  lunch,
  lunchClockIn,
  clockOut
}

class _ClockInState extends State<ClockInWidget> {

  ClockInState _currentState =
      ClockInState.clockIn; //0 => Clock In Button Only, 1 => Clock Out & Lunch, 2 => Clock out



  @override
  Widget build(BuildContext context) {
    if (_currentState == ClockInState.clockIn || _currentState == ClockInState.lunchClockIn) {
      //Clock In Only
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              fit: FlexFit.tight,
              flex: 10,
              child: ClockButton(
                onPressed: _clockIn,
                icon: const Icon(Icons.access_time_filled),
              )),
          const Flexible(fit: FlexFit.loose, flex: 1,child: Text("Clock In"),)
        ],
      );
    } else if (_currentState == ClockInState.lunch) {
      //Clock Out OR Lunch
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              fit: FlexFit.tight,
              flex: 10,
              child: ClockButton(
                onPressed: _lunch,
                icon: const Icon(Icons.access_time),
              )),
          const Flexible(fit: FlexFit.loose, flex: 1,child: Text("Lunch"),),
          Flexible(
            fit: FlexFit.tight,
            flex: 10,
            child: ClockButton(
              onPressed: _clockOut,
              icon: const Icon(Icons.access_alarms),
            ),
          ),
          const Flexible(fit: FlexFit.loose, flex: 1,child: Text("Clock Out"),)
        ],
      );
    } else if (_currentState == ClockInState.clockOut) {
      //Clock OUT
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 10,
            child: ClockButton(
              onPressed: _clockOut,
              icon: const Icon(Icons.access_alarms),
            ),
          ),
          const Flexible(fit: FlexFit.loose, flex: 1,child: Text("Clock Out"),)
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [Text("ERROR UNKNOWN STATE")],
      );
    }
  }

  void _clockIn() {
    //TODO: Set Clock in in Database
  
    setState(() {

      if(_currentState == ClockInState.clockIn)
        {
         DateTime dt = DateTime.now();
    
          //log("NEXT STATE LUNCH");
          _currentState = ClockInState.lunch;
         //interface.store_time(ClockInState.clockIn);
         Database.instance.store_time("", dt, ClockInState.clockIn.index, 1);
        }
      else if (_currentState == ClockInState.lunchClockIn){
        //log("NEXT STATE CLOCK OUT");
        _currentState = ClockInState.clockOut;
       DateTime dt = DateTime.now();
        //interface.store_time(ClockInState.lunchClockIn);
        Database.instance.store_time("", dt, ClockInState.lunchClockIn.index, 1);
      }

    });
  }

  void _lunch() {
    //TODO: Set Lunch in Database
    
    setState(() {
     _currentState = ClockInState.lunchClockIn;
       DateTime dt = DateTime.now();
       Database.instance.store_time("", dt, ClockInState.lunch.index, 1);
     //interface.store_time(ClockInState.lunch);
      //log("NEXT STATE LUNCH CLOCK IN");

    });
  }

  void _clockOut() {
    //TODO: Set Clock Out in Database
       //interface.store_time(ClockInState.clockOut);

    setState(() {

      _currentState = ClockInState.clockIn;
    });
    DateTime dt = DateTime.now();
    Database.instance.store_time("", dt, ClockInState.clockOut.index, 1);
  }
}

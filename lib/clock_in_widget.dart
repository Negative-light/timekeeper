import 'dart:developer';

import 'package:flutter/material.dart';

class ClockInWidget extends StatefulWidget {
  const ClockInWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ClockInState();
}

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
        children: [
          Flexible(
              fit: FlexFit.tight,
              flex: 4,
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
          //log("NEXT STATE LUNCH");
          _currentState = ClockInState.lunch;
        }
      else if (_currentState == ClockInState.lunchClockIn){
        //log("NEXT STATE CLOCK OUT");
        _currentState = ClockInState.clockOut;
      }

    });
  }

  void _lunch() {
    //TODO: Set Lunch in Database
    setState(() {
     _currentState = ClockInState.lunchClockIn;
     //log("NEXT STATE LUNCH CLOCK IN");

    });
  }

  void _clockOut() {
    //TODO: Set Clock Out in Database
    setState(() {
      _currentState = ClockInState.clockIn;
    });
  }
}

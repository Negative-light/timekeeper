import 'package:flutter/material.dart';

class ClockInWidget extends StatefulWidget {
  const ClockInWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ClockInState();
}

class clockButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Icon icon;

  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    shape: const CircleBorder(),
    //padding: const EdgeInsets.all(100),
    backgroundColor: Colors.blue,
    foregroundColor: Colors.black,
    minimumSize: Size.infinite,
  );

  const clockButton({super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: onPressed, style: buttonStyle, child: icon,),);
  }

}

class _ClockInState extends State<ClockInWidget> {
  int _currentState =
  0; //0 => Clock In Button Only, 1 => Clock Out & Lunch, 2 => Clock out
  int _nextState = 1;


  @override
  Widget build(BuildContext context) {
    if (_currentState == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: clockButton(onPressed: _clockIn,
                icon: const Icon(Icons.access_time_filled),)
          ),
        ],
      );
    } else if (_currentState == 1) {
      //Clock Out OR Lunch
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: clockButton(
                onPressed: _clockOut, icon: const Icon(Icons.access_time),)
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: clockButton(
              onPressed: _lunch, icon: const Icon(Icons.access_alarms),
            ),
          ),
        ],
      );
    } else if (_currentState == 2) {
      //Clock OUT
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: clockButton(
              onPressed: _clockOut, icon: const Icon(Icons.access_time),),
          )
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
      _currentState = _nextState;
      if (_nextState == 2) {
        _nextState = 0;
      } else {
        _nextState = 1;
      }
    });
  }

  void _lunch() {
    //TODO: Set Lunch in Database
    setState(() {
      _currentState = 0;
      _nextState = 2;
    });
  }

  void _clockOut() {
    //TODO: Set Clock Out in Database
    setState(() {
      _currentState = 0;
      _nextState = 1;
    });
  }
}

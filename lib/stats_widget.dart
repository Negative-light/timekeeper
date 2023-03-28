import 'package:flutter/material.dart';

class StatsWidget extends StatelessWidget {
  StatsWidget({super.key});
  static DateTime now = DateTime.now();
  final DateTime clickIn = DateTime(now.year, now.day, now.month, 9, 0 ,0);
  final double avgWorkedHours = 8.12;
  final totalWorkedThisWeek = 41.5;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            Card(
            child: Column(
              children: [
                const Text('Today'),
                Text('Clock in $clickIn'),
                Text('Clock out $now'),
                const Text('Lunch NONE')

              ],
            ),
          ),
            Card(
              child: Column(
                children: [
                  const Text('Status'),
                  Text('Averga Worked Hours: $avgWorkedHours'),
                  Text('Total Worked This Week $totalWorkedThisWeek')
                ],
              ),
            )
          ]
        ));
  }
}

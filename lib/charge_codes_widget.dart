import 'package:flutter/material.dart';


class ChargeCodesWidget extends StatelessWidget {
  ChargeCodesWidget({super.key});
  final chargeCodes = [];

  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 4, children: chargeCodes.map((chargeCode) {
      return Card(
        child:
        Column(
            children: [
              Text(chargeCode.name),
              Text(chargeCode.description),
              Text("${chargeCode.estimatedHours}"),
              Text("${chargeCode.projectId}"),
              Text("${chargeCode.id}")
            ],
        ),
      );
    }).toList(),);
  }
  
}
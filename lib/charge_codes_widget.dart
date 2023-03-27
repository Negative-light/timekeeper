import 'package:flutter/material.dart';
import 'objects/charge_code.dart';


class ChargeCodesWidget extends StatelessWidget {
  ChargeCodesWidget({super.key});
  final chargeCodes = [
    ChargeCode(
      name: 'Charge Code 1',
      description: 'Description of Charge Code 1',
      id: 1,
      projectId: 1,
      hourlyRate: 100.0,
      estimatedHours: 8,
    ),
    ChargeCode(
      name: 'Charge Code 2',
      description: 'Description of Charge Code 1',
      id: 2,
      projectId: 1,
      hourlyRate: 100.0,
      estimatedHours: 12,
    ),
    ChargeCode(
      name: 'Charge Code 1',
      description: 'Description of Charge Code 1',
      id: 3,
      projectId: 1,
      hourlyRate: 80.0,
      estimatedHours: 4,
    ),
    ChargeCode(
      name: 'Charge Code 1',
      description: 'Description of Charge Code 1',
      id: 4,
      projectId: 1,
      hourlyRate: 100.0,
      estimatedHours: 8,
    ),
  ];

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
import 'package:flutter/material.dart';
import 'package:timekeeper/data_model.dart';


class ChargeCodesWidget extends StatelessWidget {
  ChargeCodesWidget({super.key});
  List chargeCodes = [];

  @override
  Widget build(BuildContext context) {
    print("REBUILDING WIDGET");
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
  void refresh(){
    DataModel dm = DataModel.instance;
    for(var code in dm.chargeCodes){
        chargeCodes.add(code);
        print("setting charge codes");
    }
  }
  
}
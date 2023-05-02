import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'database_interface.dart';
import 'data_model.dart';
import 'objects/charge_code.dart';
import 'objects/project.dart';


class ChargeCodesWidget extends StatelessWidget {
  ChargeCodesWidget({super.key});
  late Stream<QuerySnapshot> _codeStream;

  @override
  Widget build(BuildContext context) {

    CollectionReference referenceToProj = Database.instance.db.collection('chargeCodes');
    _codeStream = referenceToProj.snapshots();

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
                var codes = [];
                for (var docSnapshot in querySnapshot.docs) {
                  final data = docSnapshot.data() as Map<String, dynamic>;

                  //get project name corresponding to the current charge code
                 String name = "";
                 for(Project p in DataModel.instance.projects){
                   if (p.id == data['Project']){
                     name = p.name;
                   }
                 }

                  ChargeCode c = ChargeCode(
                      docSnapshot.id,
                      data['Budget'],
                      data['Status'],
                      data['Description'].toString(),
                      data['Name'].toString(),
                      data['OwnerId'].toString(),
                      name);
                  codes.add(c);
                }

                return GridView.count(
                  crossAxisCount: 4,
                  children: codes.map((chargeCode) {
                  return Card(
                    child:

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(chargeCode.name),
                        Text(chargeCode.description),
                        Text("Budgeted hours: 1500"),
                        Text("Project: ${chargeCode.project}"),
                        Text("Charge Id: ${chargeCode.id}")
                      ],
                    ),
                  );
                }).toList(),);
              }

              return Center(child: CircularProgressIndicator());
            }
        )
    );

  }

  
}
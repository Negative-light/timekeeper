import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'database_interface.dart';
import 'objects/project.dart';

class ProjectsWidget extends StatelessWidget {

  late Stream<QuerySnapshot> _projectStream;
  ProjectsWidget({super.key});

  @override
  Widget build(BuildContext context) {

    CollectionReference referenceToProj = Database.instance.db.collection('Projects');
    _projectStream = referenceToProj.snapshots();

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _projectStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.connectionState == ConnectionState.active)
          {
            QuerySnapshot querySnapshot = snapshot.data;
            var projects = [];
            for (var docSnapshot in querySnapshot.docs) {
              final data = docSnapshot.data() as Map<String, dynamic>;
              Project p = Project();
              p.id = "1";
              p.name = (data['Name']).toString();
              p.leadUserId = (data['Lead']).toString();
              p.client = (data['Client']).toString();
              p.projectBudget = data['Budget'];
              p.startDate = DateTime(2023);
              projects.add(p);
            }
            return GridView.count(
               crossAxisCount: 4,
               children: projects.map((project) {
                // Find the client for this project
                // final client = clients.firstWhere((client) => client.id == project.client);

                 return Card(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(project.name),
                       Text(project.client),
                       Text("Budget: ${project.projectBudget}"),
                       Text("Start date: ${project.startDate}"),
                     ],
                   ),
                 );
               }).toList(),
             );
          }

          return Center(child: CircularProgressIndicator());
        }
      )
    );

  }
}
import 'package:flutter/material.dart';

import 'objects/client.dart';
import 'objects/project.dart';


class ProjectsWidget extends StatelessWidget {
  final clients = [
    Client(
      id: "1",
      name: "Acme Corporation",
      contactPerson: "John Doe",
      phoneNumber: "555-1234",
      emailAddress: "jdoe@acme.com",
    ),
    Client(
      id: "2",
      name: "Widget Co.",
      contactPerson: "Jane Smith",
      phoneNumber: "555-5678",
      emailAddress: "jsmith@widgetco.com",
    ),
  ];

  final projects = [
    Project(
      id: 1,
      name: "Project 1",
      leadUserId: "user1",
      client: "1",
      projectBudget: 10000,
      startDate: DateTime.now(),
    ),
    Project(
      id: 2,
      name: "Project 2",
      leadUserId: "user2",
      client: "2",
      projectBudget: 5000,
      startDate: DateTime.now().add(const Duration(days: 30)),
    ),
    Project(
      id: 3,
      name: "Project 3",
      leadUserId: "user1",
      client: "1",
      projectBudget: 7500,
      startDate: DateTime.now().add(const Duration(days: 60)),
    ),
  ];

  ProjectsWidget({super.key});



  @override
  Widget build(BuildContext context) {
    // Sort the projects by start date
    projects.sort((a, b) => a.startDate.compareTo(b.startDate));

    return GridView.count(
      crossAxisCount: 4,
      children: projects.map((project) {
        // Find the client for this project
        final client = clients.firstWhere((client) => client.id == project.client);

        return Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(project.name),
              Text(client.name),
              Text("Start date: ${project.startDate}"),
              Text("Budget: \$${project.projectBudget}"),
            ],
          ),
        );
      }).toList(),
    );
  }
}
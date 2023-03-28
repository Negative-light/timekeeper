import 'package:flutter/material.dart';

class ProjectsWidget extends StatelessWidget {
  final clients = [  ];

  final projects = [  ];

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
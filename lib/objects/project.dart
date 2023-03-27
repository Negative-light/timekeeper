class Project {
  final int id;
  final String name;
  final String leadUserId;
  final String client;
  final DateTime startDate;


  final int projectBudget;

  Project({
    required this.id,
    required this.name,
    required this.leadUserId,
    required this.client,
    required this.projectBudget,
    required this.startDate,
  });
}
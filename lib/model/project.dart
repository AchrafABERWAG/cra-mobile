class Project {
  final int id;
  final String name;
  final String type;
  final String startDate;
  final String endDate;

  const Project({
    required this.id,
    required this.name,
    required this.type,
    required this.startDate,
    required this.endDate,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
    );
  }
}

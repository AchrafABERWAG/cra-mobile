class Activity {
  final int id;
  final String name;
  final String type;
  final String createOn;
  final String updateOn;

  const Activity({
    required this.id,
    required this.name,
    required this.type,
    required this.createOn,
    required this.updateOn,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      createOn: json['createOn'] as String,
      updateOn: json['updateOn'] as String,
    );
  }
}

class Role {
  final int id;
  final String name;
  final String createOn;
  final String updateOn;

  const Role({
    required this.id,
    required this.name,
    required this.createOn,
    required this.updateOn,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    int id = json['id'] as int;
    String name = json['name'];
    String createOn = json['createOn'];
    String updateOn = json['updateOn'];

    return Role(id: id, name: name, createOn: createOn, updateOn: updateOn);
  }
}

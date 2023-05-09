import 'package:committer_cra/model/member.dart';

class Team {
  final int id;
  final String name;
  final String image;
  final String description;
  final List<Member> members;
  //final String email;
  final String createOn;
  final String updateOn;

  const Team({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.members,
    required this.createOn,
    required this.updateOn,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    int id = int.parse(json['id']);
    final name = json['name'] as String;
    final image = json['image'] as String;
    final description = json['description'] as String;
    final data = json['members'] as List<dynamic>?;
    final members = data != null
        ? data.map((m) => Member.fromJson(m)).toList()
        : <Member>[];
    return Team(
        id: json['id'] as int,
        name: json['name'] as String,
        image: json['image'] as String,
        description: json['description'] as String,
        members: members,
        createOn: json['createOn'] as String,
        updateOn: json['updateOn'] as String);
  }
}

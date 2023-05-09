import 'package:committer_cra/model/activity.dart';
import 'package:committer_cra/model/user.dart';

class Member {
  int? id;
  Activity activity;
  User user;
  String role;
  String createOn;
  String updateOn;

  Member(
      {this.id,
      required this.activity,
      required this.user,
      required this.role,
      required this.createOn,
      required this.updateOn});

  factory Member.fromJson(Map<String, dynamic> json) {
    int id = json['id'] as int;
    User user = User.fromJson(json['user']);
    Activity activity = Activity.fromJson(json['activity']);
    String role = json['role'];
    String createOn = json['createOn'];
    String updateOn = json['updateOn'];
    return Member(
        id: id,
        activity: activity,
        user: user,
        role: role,
        createOn: createOn,
        updateOn: updateOn);
  }
}

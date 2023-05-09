import 'package:committer_cra/model/user.dart';
import 'activity.dart';

class Task {
  final int id;
  final User user;
  final Activity activity;
  final DateTime executionDate;
  final DateTime createOn;
  final DateTime updateOn;
  final double quantity;

  const Task({
    required this.id,
    required this.user,
    required this.activity,
    required this.executionDate,
    required this.createOn,
    required this.updateOn,
    required this.quantity,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    int id = int.parse(json['id'].toString());
    User user = User.fromJson(json['user']);
    Activity activity = Activity.fromJson(json['activity']);
    DateTime executionDate = DateTime.parse(json['executionDate'].toString());
    DateTime createOn = DateTime.parse(json['createOn'].toString());
    DateTime updateOn = DateTime.parse(json['updateOn'].toString());
    double quantity = double.parse(json['quantity'].toString());
    return Task(
      id: id,
      user: user,
      activity: activity,
      executionDate: executionDate,
      createOn: createOn,
      updateOn: updateOn,
      quantity: quantity,
    );
  }
}

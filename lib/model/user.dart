import 'package:committer_cra/model/role.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String createOn;
  final String updateOn;
  final String address;
  final Role role;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.createOn,
    required this.updateOn,
    required this.address,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    print('USER $json');
    Role role = Role.fromJson(json['role']);
    return User(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      createOn: json['createOn'] as String,
      updateOn: json['updateOn'] as String,
      address: json['address'] as String,
      role: role,
    );
  }
}

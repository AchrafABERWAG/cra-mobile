import 'dart:io';
import 'package:committer_cra/model/member.dart';
import 'package:committer_cra/model/activity.dart';
import 'package:committer_cra/model/task.dart';
import 'package:committer_cra/model/team.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/client.dart';
import 'model/project.dart';
import 'model/role.dart';
import 'model/user.dart';

const String apiUrl = 'http://192.168.56.1:8080';
const String storageKey = 'token';

Future getTokenFromStorage() async {
  final storage = await SharedPreferences.getInstance();
  return storage.getString(storageKey);
}

Future<int> signInWithEmailAndPassword(String email, String password) async {
  final response = await http.post(Uri.parse('$apiUrl/token'),
      headers: {
        'Accept': 'Application/json',
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$email:$password'))}'
      },
      body: null);

  final storage = await SharedPreferences.getInstance();
  storage.remove(storageKey);
  await storage.setString(storageKey, response.body);
  print(response.statusCode);
  return response.statusCode;
}

Future<List<Client>> fetchClients() async {
  final response = await http.get(
    Uri.parse('$apiUrl/clients'),
    headers: {
      HttpHeaders.authorizationHeader: 'bearer ${await getTokenFromStorage()}'
    },
  );
  final responseJson = jsonDecode(response.body).cast<Map<String, dynamic>>();

  return responseJson.map<Client>((json) => Client.fromJson(json)).toList();
}

Future<List<Project>> fetchProjects() async {
  final response = await http.get(
    Uri.parse('$apiUrl/projects'),
    headers: {
      HttpHeaders.authorizationHeader: 'bearer ${await getTokenFromStorage()}'
    },
  );
  final responseJson = jsonDecode(response.body).cast<Map<String, dynamic>>();

  return responseJson.map<Project>((json) => Project.fromJson(json)).toList();
}

Future<List<Activity>> fetchActivities() async {
  final response = await http.get(
    Uri.parse('$apiUrl/activities'),
    headers: {
      HttpHeaders.authorizationHeader: 'bearer ${await getTokenFromStorage()}'
    },
  );
  final responseJson = jsonDecode(response.body).cast<Map<String, dynamic>>();

  return responseJson.map<Activity>((json) => Activity.fromJson(json)).toList();
}

Future<List<Team>> fetchTeams() async {
  final response = await http.get(
    Uri.parse('$apiUrl/teams'),
    headers: {
      HttpHeaders.authorizationHeader: 'bearer ${await getTokenFromStorage()}'
    },
  );
  final responseJson = jsonDecode(response.body).cast<Map<String, dynamic>>();

  return responseJson.map<Team>((json) => Team.fromJson(json)).toList();
}

Future<User> fetchMe() async {
  final response = await http.get(
    Uri.parse('$apiUrl/users/me'),
    headers: {
      HttpHeaders.authorizationHeader: 'bearer ${await getTokenFromStorage()}'
    },
  );
  return User.fromJson(jsonDecode(response.body));
}

Future<List<Task>> fetchTasks() async {
  final response = await http.get(
    Uri.parse('$apiUrl/tasks'),
    headers: {
      HttpHeaders.authorizationHeader: 'bearer ${await getTokenFromStorage()}'
    },
  );
  final responseJson = jsonDecode(response.body).cast<Map<String, dynamic>>();

  return responseJson.map<Task>((json) => Task.fromJson(json)).toList();
}

Future<List<Role>> fetchRoles() async {
  final response = await http.get(
    Uri.parse('$apiUrl/roles'),
    headers: {
      HttpHeaders.authorizationHeader: 'bearer ${await getTokenFromStorage()}'
    },
  );
  final responseJson = jsonDecode(response.body).cast<Map<String, dynamic>>();

  return responseJson.map<Role>((json) => Role.fromJson(json)).toList();
}

Future<Client> addClient(String name, String email, String phone, String siret,
    String tva, String address) async {
  final response = await http.post(Uri.parse('$apiUrl/clients'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'bearer ${await getTokenFromStorage()}'
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'phone': phone,
        'siret': siret,
        'tva': tva,
        'address': address,
      }));

  print(response.body);
  print(response.statusCode);
  return Client.fromJson(jsonDecode(response.body));
}

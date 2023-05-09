import 'package:flutter/material.dart';
import 'package:simple_gravatar/simple_gravatar.dart';
import '../api.dart';
import '../model/user.dart';
import '../service/local_notification.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late Future<User> UserProfil;
  late User user;

  @override
  void initState() {
    super.initState();
    UserProfil = fetchMe();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: FutureBuilder<User>(
            future: UserProfil,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return UsersList(
                  user: snapshot.data!,
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class UsersList extends StatelessWidget {
  final User user;

  const UsersList({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final LocalNotificationService service;
    service = LocalNotificationService();
    service.intialize();
    return ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: user.id,
        itemBuilder: ((context, index) {
          var gravatar = Gravatar(user.email);
          String url = gravatar.imageUrl(
              size: 100,
              defaultImage: GravatarImage.retro,
              rating: GravatarRating.pg,
              fileExtension: true);
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Material(
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  elevation: 8,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(children: <Widget>[
                        Image.network(url),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      user.firstName,
                                      style: const TextStyle(
                                          fontFamily: 'lambda', fontSize: 19),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  const Divider(),
                                  Text(
                                    'Name: ${user.firstName} ${user.lastName}',
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'email: ${user.email}',
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'phone: ${user.phone}',
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'role: ${user.role.name}',
                                    textAlign: TextAlign.center,
                                  ),
                                  const Divider(),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Start Date : ${user.createOn}',
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            ),
                                            const SizedBox(
                                              height: 1.5,
                                            ),
                                            Text(
                                              'End Date : ${user.updateOn}',
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            )
                                          ],
                                        ),
                                      ]),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Align(
                                      alignment: Alignment.center,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.blueGrey,
                                        ),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Notification'),
                                      ))
                                ]))
                      ]))));
        }));
  }
}

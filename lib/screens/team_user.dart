import 'package:flutter/material.dart';
import 'package:simple_gravatar/simple_gravatar.dart';

import '../api.dart';
import '../model/task.dart';

class TeamUserScreen extends StatefulWidget {
  const TeamUserScreen({super.key});

  @override
  State<TeamUserScreen> createState() => _TeamUserScreenState();
}

class _TeamUserScreenState extends State<TeamUserScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team User',
      theme: ThemeData(),
      home: Scaffold(
        body: Center(
          child: FutureBuilder<List<Task>>(
            future: fetchTasks(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return TeamUser(teamUsers: snapshot.data!);
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

class TeamUser extends StatelessWidget {
  const TeamUser({super.key, required this.teamUsers});

  final List<Task> teamUsers;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: (teamUsers.length),
        itemBuilder: ((context, index) {
          var gravatar = Gravatar(teamUsers[index].user.email);
          String url = gravatar.imageUrl(
              size: 50,
              defaultImage: GravatarImage.mp,
              rating: GravatarRating.pg,
              fileExtension: true);
          return ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(url),
              backgroundColor: Colors.transparent,
            ),
            title: Text(
              '${teamUsers[index].user.firstName}, ${teamUsers[index].user.lastName}',
              textAlign: TextAlign.left,
            ),
            subtitle: Text(
              '${teamUsers[index].activity.name} ,${teamUsers[index].activity.type}',
              textAlign: TextAlign.left,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blueGrey,
                  ),
                  onPressed: () async {
                    print(
                        '----------------contenu Validé par le VALIDATOR---------------------');
                  },
                  child: const Text('Validé'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blueGrey,
                  ),
                  onPressed: () async {
                    print(
                        '---------------------contenu refusé par le VALIDATOR------------------');
                  },
                  child: const Text('refusé'),
                ),
              ],
            ),
          );
        }),
      )),
      const Divider(height: 3, thickness: 2, color: Color(0xff86b7e9)),
      TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.blueGrey,
        ),
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Return to members'),
      ),
    ]);
  }
}

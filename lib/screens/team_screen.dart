import 'package:committer_cra/model/team.dart';
import 'package:committer_cra/screens/member_screen.dart';
import 'package:flutter/material.dart';
import 'package:simple_gravatar/simple_gravatar.dart';
import '../api.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team 1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: FutureBuilder<List<Team>>(
            future: fetchTeams(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return TeamList(teams: snapshot.data!);
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

class TeamList extends StatelessWidget {
  const TeamList({super.key, required this.teams});

  final List<Team> teams;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: teams.length,
        itemBuilder: ((context, index) {
          var gravatar = Gravatar(teams[index].image);
          String url = gravatar.imageUrl(
              size: 50,
              defaultImage: GravatarImage.monsterid,
              rating: GravatarRating.pg,
              fileExtension: true);
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) =>
                          MemberList(members: teams[index].members)));
            },
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(url),
              backgroundColor: Colors.transparent,
            ),
            title: Text(
              teams[index].name,
              textAlign: TextAlign.left,
            ),
            subtitle: Text(
              teams[index].description,
              textAlign: TextAlign.left,
            ),
          );
        }));
  }
}

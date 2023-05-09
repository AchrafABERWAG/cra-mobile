import 'package:committer_cra/screens/team_user.dart';
import 'package:flutter/material.dart';
import 'package:simple_gravatar/simple_gravatar.dart';
import '../model/member.dart';

class MemberList extends StatelessWidget {
  const MemberList({
    super.key,
    required this.members,
  });

  final List<Member> members;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(children: [
      Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: members.length,
              itemBuilder: ((context, index) {
                var gravatar = Gravatar(members[index].user.email);
                String url = gravatar.imageUrl(
                    size: 50,
                    defaultImage: GravatarImage.retro,
                    rating: GravatarRating.pg,
                    fileExtension: true);
                return ListTile(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => TeamUser()));
                  },
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(url),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(
                    '${members[index].user.firstName}, ${members[index].user.lastName}',
                    textAlign: TextAlign.left,
                  ),
                  subtitle: Text(members[index].role),
                );
              }))),
      const Divider(height: 3, thickness: 2, color: Color(0xff86b7e9)),
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text("Return to teams"),
      )
    ]));
  }
}

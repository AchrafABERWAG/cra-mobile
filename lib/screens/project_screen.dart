import 'package:flutter/material.dart';
import '../api.dart';
import '../model/project.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: FutureBuilder<List<Project>>(
            future: fetchProjects(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ProjectsList(projects: snapshot.data!);
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

class ProjectsList extends StatelessWidget {
  const ProjectsList({super.key, required this.projects});

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: projects.length,
        itemBuilder: ((context, index) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Text(
                              projects[index].name,
                              style: const TextStyle(
                                fontFamily: 'lambda',
                                fontSize: 19,
                              ),
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            const Divider(),
                            Text(
                              'Type: ${projects[index].type}',
                              textAlign: TextAlign.left,
                            ),
                            const Divider(),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Start Date : ${projects[index].startDate}',
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                      const SizedBox(
                                        height: 1.5,
                                      ),
                                      Text(
                                        'End Date : ${projects[index].endDate}',
                                        style: const TextStyle(fontSize: 13),
                                      )
                                    ],
                                  ),
                                ]),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ]),
                  )));
        }));
  }
}

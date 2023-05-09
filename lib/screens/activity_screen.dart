import 'package:flutter/material.dart';
import '../api.dart';
import '../model/activity.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: FutureBuilder<List<Activity>>(
            future: fetchActivities(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ActivitiesList(activities: snapshot.data!);
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

class ActivitiesList extends StatelessWidget {
  const ActivitiesList({super.key, required this.activities});

  final List<Activity> activities;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: activities.length,
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
                              activities[index].name,
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
                              'Name: ${activities[index].name}, Type: ${activities[index].type}',
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
                                        'Start Date : ${activities[index].createOn}',
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                      const SizedBox(
                                        height: 1.5,
                                      ),
                                      Text(
                                        'End Date : ${activities[index].updateOn}',
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

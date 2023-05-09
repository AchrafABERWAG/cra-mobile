import 'package:committer_cra/model/activity.dart';
import 'package:flutter/material.dart';
import '../api.dart';
import '../model/task.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: FutureBuilder<List<Task>>(
            future: fetchTasks(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return TasksList(tasks: snapshot.data!);
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

class TasksList extends StatelessWidget {
  const TasksList({super.key, required this.tasks});

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfCalendar(
      view: CalendarView.month,
      dataSource: MeetingDataSource(_getDataSource()),
      firstDayOfWeek: 1,
      monthViewSettings: const MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        showTrailingAndLeadingDates: false,
        showAgenda: true,
        agendaViewHeight: 300,
        agendaItemHeight: 70,
      ),
    ));
  }
}

List<Task> _getDataSource() {
  final List<Task> tasks = <Task>[];
  final List<Activity> activities = <Activity>[];
  const Activity name = Activity(
      id: 5, name: 'name', type: 'type', createOn: '', updateOn: 'updateOn');
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(Duration(hours: 7));
  return tasks;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Task> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

// class TaskDataSource extends CalendarDataSource {
//   TaskDataSource(List<Task> source) {
//     appointments = source;
//   }

//   DateTime getExcutionDate(int index) {
//     return appointments![index].executionDate;
//   }

//   DateTime getCreatedOn(int index) {
//     return appointments![index].createOn;
//   }

//   DateTime getUpdateOn(int index) {
//     return appointments![index].updateOn;
//   }
// }
// final DateTime date = DateTime.now();
// TaskDataSource? _getCalendarDataSource(){
//   List<Task> appointments = <Task>[];
//   appointments.add(Task(executionDate: date, createOn: date, updateOn: date,));
// }

import 'package:committer_cra/screens/activity_screen.dart';
import 'package:committer_cra/screens/client_screen.dart';
import 'package:committer_cra/screens/project_screen.dart';
import 'package:committer_cra/screens/team_screen.dart';
import 'package:committer_cra/screens/team_user.dart';
import 'package:committer_cra/screens/user_screen.dart';
import 'package:committer_cra/service/local_notification.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class MyStatefulWidget extends StatefulWidget {
  final String title;

  const MyStatefulWidget({super.key, required this.title});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  late String _title;

  @override
  initState() {
    super.initState();
    _title = 'Activity';
  }

  @override
  Widget build(BuildContext context) {
    final LocalNotificationService service;
    service = LocalNotificationService();
    service.intialize();
    return Scaffold(
      appBar: AppBar(
          title: Text(_title),
          backgroundColor: const Color(0xff86b7e9),
          actions: <Widget>[
            Badge(
                position: BadgePosition.topEnd(top: 0, end: 7),
                showBadge: true,
                badgeColor: const Color.fromARGB(255, 255, 0, 0),
                badgeContent: const Text('9',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    )),
                borderRadius: BorderRadius.circular(15),
                child: IconButton(
                  icon: const Icon(
                    Icons.add_alert_rounded,
                    size: 30,
                  ),
                  onPressed: () async {
                    await service.showNotification(
                        id: 1, title: 'admin', body: 'Messgage');
                  },
                ))
          ],
          automaticallyImplyLeading: true),
      body: PageView(
        controller: _pageController,
        children: const [
          ActivityScreen(),
          ClientScreen(),
          ProjectScreen(),
          TeamUserScreen(),
          TeamScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => {
          setState(() {
            _currentIndex = index;
          }),
          _pageController.jumpToPage(index),
          onTabTapped(index)
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.computer),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hub),
            label: 'Client',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cases),
            label: 'Project',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Team',
          ),
        ],
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.black,
        selectedItemColor: const Color(0xff86b7e9),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          {
            _title = 'Activity';
          }
          break;
        case 1:
          {
            _title = 'Client';
          }
          break;
        case 2:
          {
            _title = 'Project';
          }
          break;
        case 3:
          {
            _title = 'Profil';
          }
          break;
        case 4:
          {
            _title = 'Team';
          }
          break;
      }
    });
  }
}

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> intialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/ic_stat_drafts');

    const InitializationSettings settings =
        InitializationSettings(android: androidInitializationSettings);

    await _localNotificationService.initialize(
      settings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("channelId", "channelName",
            channelDescription: 'description',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);

    return const NotificationDetails(android: androidNotificationDetails);
  }

  void onDidReceiveNotificationResponse(NotificationResponse payload) {
    if (payload != null && payload.id != null) {
      print('yoooooooooooooooo');
    }
  }

  Future<void> showNotification(
      {required int id, required String title, required String body}) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }

  Future<void> showNotificationWithPayload(
      {required int id,
      required String title,
      required String body,
      required String payload}) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details,
        payload: payload);
  }
}

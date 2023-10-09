import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tqrc_app/src/services/local_notification_services.dart';
import 'package:tqrc_app/src/views/base/helper_methods.dart';

class FirebasePushNotificationServices {

  /// initialize & handle firebase notification
  handleNotification() async {
    await _notificationInitialize();

    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    FirebaseMessaging.instance.getInitialMessage().then(_getInitialMessage);

    FirebaseMessaging.onMessage.listen(_onMessageListen);

    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
  }

  Future<void> _notificationInitialize() async {
    /// Foreground Notification Options Enabled
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _getInitialMessage(RemoteMessage? message) async {
    kPrint("FirebaseMessaging.instance.getInitialMessage");
    if (message != null) {
      kPrint("New Notification");
      // if (message.data['_id'] != null) {
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) => DemoScreen(
      //         id: message.data['_id'],
      //       ),
      //     ),
      //   );
      // }
    }
  }

  Future<void> _onMessageListen(RemoteMessage message) async {
    kPrint("FirebaseMessaging.onMessage.listen");
    if (message.notification != null) {
      kPrint(message.notification!.title);
      kPrint(message.notification!.body);
      kPrint("message.data11 ${message.data}");
      LocalNotificationService.createAndDisplayNotification(message);
    }
  }

  Future<void> _onMessageOpenedApp(RemoteMessage message) async {
    kPrint("FirebaseMessaging.onMessageOpenedApp.listen");
    if (message.notification != null) {
      kPrint(message.notification!.title);
      kPrint(message.notification!.body);
      kPrint("message.data22 ${message.data['_id']}");
    }
  }
}

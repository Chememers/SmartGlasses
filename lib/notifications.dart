import 'dart:async';
import 'dart:convert';
import 'package:android_notification_listener2/android_notification_listener2.dart';
import 'package:smart_glasses/main.dart';

AndroidNotificationListener _notifications;
StreamSubscription<NotificationEventV2> _subscription;

void onData(NotificationEventV2 event) {
  print(event);
  print('converting package extra to json');
  var jsonDatax = json.decode(event.packageExtra);
  sendString(event.packageMessage.toString());
  print(jsonDatax);
}

void startListening() {
  _notifications = new AndroidNotificationListener();
  try {
    _subscription = _notifications.notificationStream.listen(onData);
  } on NotificationExceptionV2 catch (exception) {
    print(exception);
  }
}

void stopListening() {
  _subscription.cancel();
}

Future<void> listenForNotifs() async {
  startListening();
}

import 'dart:async';
import 'dart:convert';
import 'package:android_notification_listener2/android_notification_listener2.dart';
import 'package:smart_glasses/main.dart';

AndroidNotificationListener _notifications;
StreamSubscription<NotificationEventV2> _subscription;
String old;
String msg;

var map = {
  "com.google.android.dialer": "Call from ",
  "com.motorola.camera2": "",
  "com.google.android.gm": "Email from "
};

void onData(NotificationEventV2 event) {
  print(event);
  var jsonDatax = json.decode(event.packageExtra);
  print(jsonDatax);

  msg = event.packageMessage;
  print(msg);

  try {
    msg = map[event.packageName] + jsonDatax['android.title'];
    print(msg);
  } catch (e) {}
  if (old != msg && msg != "Incoming call") {
    sendString("Call from Aditya"); //Memed for now,
  }
  old = msg;
}

void startListening() {
  _notifications = new AndroidNotificationListener();
  try {
    _subscription = _notifications.notificationStream.listen(onData);
  } catch (e) {
    print("");
  }
}

void stopListening() {
  _subscription.cancel();
}

Future<void> listenForNotifs() async {
  startListening();
}

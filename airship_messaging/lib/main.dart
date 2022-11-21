import 'dart:developer';
import 'dart:io';

import 'package:airship_flutter/airship_flutter.dart' as airship;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> _backgroundMessageHandler(Map<String, dynamic> payload, airship.Notification? notification) async {
  log("[airship] _backgroundMessageHandler: payload=$payload, notification=$notification");
}

void _channelRegistrationHandler(airship.ChannelEvent event) {
  log("[airship] _channelRegistrationHandler: channelid=${event.channelId}, registrationToken=${event.registrationToken}");
}

void _pushReceivedHandler(airship.PushReceivedEvent event) {
  log("[airship] _pushReceivedHandler: event=$event");
}

void _notificationResponseHandler(airship.NotificationResponseEvent event) {
  log("[airship] _notificationResponseHandler: event=$event");
}

void _deepLinkHandler(String? event) {
  log("[airship] _deepLinkHandler: event=$event");
}

Future<String> getChannelId() async {
  if (!await _canUseAirship) {
    return '';
  }

  final channelId = await airship.Airship.channelId;
  log('[airship] channelId=$channelId');
  return Future.value(channelId ?? '');
}

Future<bool> get _canUseAirship async {
  final canRunAirship = Platform.isIOS ? (await DeviceInfoPlugin().iosInfo).isPhysicalDevice : Platform.isAndroid;
  const permissionGranted = true; // await Permission.notification.request().isGranted;
  return canRunAirship && permissionGranted;
}

void main() async {
  // Required to make the main function async
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  String errMsg = '';

  if (await _canUseAirship) {
    try {
      // Enable notifications (prompts on iOS)
      airship.Airship.setUserNotificationsEnabled(true);

      await airship.Airship.setBackgroundMessageHandler(_backgroundMessageHandler);

      airship.Airship.onChannelRegistration.listen(_channelRegistrationHandler);

      // Triggered when push notification arrives
      airship.Airship.onPushReceived.listen(_pushReceivedHandler);

      // Triggered when app is resumed or started from notification tap
      airship.Airship.onNotificationResponse.listen(_notificationResponseHandler);

      // Triggered when a push notificatioflutterflutter n containing a deep link is tapped
      airship.Airship.onDeepLink.listen(_deepLinkHandler);
    } catch (e) {
      errMsg = e.toString();
    }
  }

  runApp(MyApp(errMsg: errMsg));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.errMsg}) : super(key: key);

  final String errMsg;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airhip Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(errMsg: errMsg),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.errMsg}) : super(key: key);

  final String errMsg;

  Future<String>? _getChannelId() => errMsg.isNotEmpty ? Future.value('') : getChannelId();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTextStyle(
        style: Theme.of(context).textTheme.headline5!,
        textAlign: TextAlign.center,
        child: FutureBuilder<String>(
          future: _getChannelId(), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              String message = errMsg != '' ? errMsg : 'Unable to get channel ID';
              if (snapshot.data != '') {
                message = 'Channel ID: ${snapshot.data}';
              }

              children = <Widget>[
                Icon(
                  Icons.check_circle_outline,
                  color: snapshot.data != '' ? Colors.green : Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(message),
                ),
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                ),
              ];
            } else {
              children = const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting Channel ID...'),
                ),
              ];
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            );
          },
        ),
      ),
    );
  }
}

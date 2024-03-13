import 'dart:io';

import 'package:all_flutter_gives/arm_test_code/extensions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  //Singleton pattern
  static final LocalNotificationService _localNotificationService =
  LocalNotificationService._internal();

  factory LocalNotificationService() {
    return _localNotificationService;
  }

  LocalNotificationService._internal();

  static AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    playSound: true,
    showBadge: true,
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,

  );

  //instance of FlutterLocalNotificationsPlugin
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static initializeLocalNotificationSetup() async {
    late final FirebaseMessaging _messaging;

    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    if (Platform.isIOS) {
      _messaging.requestPermission();
    }

    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    await requestPermissionsAndCreateNotification();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // TODO: handle the received notifications
      await getToken();

      // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
      AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/launcher_icon');

      final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();

      final InitializationSettings initializationSettings =
      InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
          macOS: null);

      flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
          // final String? payload = notificationResponse.payload;
          // if (notificationResponse.payload != null) {
          //   debugPrint('notification payload: $payload');
          // }
          // await Navigator.push(
          //   context,
          //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
          // );
        },
        // onSelectNotification: selectNotification
      );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null) {
          RemoteNotification notification = message.notification!;
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                  android: AndroidNotificationDetails(
                      channel.id,
                      channel.name,
                      // channel.description,
                      // color: Colors.blue,
                      // TODO add a proper drawable resource to android, for now using
                      //      one that already exists in example app.
                      icon: "@mipmap/launcher_icon",
                      channelShowBadge: true,
                      number: 1,
                      importance: Importance.high
                  ),
                  iOS: const DarwinNotificationDetails(
                      presentBadge: true,
                      presentSound: true,
                      // badgeNumber: 1,
                      presentAlert: true
                  )
              ));

        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        // final appcontext = RouteHelpers.appContext;
        // RouteHelpers.navigateRoute(
        //   context: appcontext!,
        //   routeType: 7,
        //   route: AppData.userSessionToken == null
        //       ? LoginScreen(shouldTakeMeToNotification: true)
        //       : NotificationsScreen(),
        // );
      });

    } else {
      print('User declined or has not accepted permission');
    }
  }

  static requestPermissionsAndCreateNotification() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static getToken() async {
    await Firebase.initializeApp();
    await Future.delayed(Duration(seconds: 1));
    String? token = await FirebaseMessaging.instance.getToken();

    "getToken $getToken".logger();
    // final intercomToken = Platform.isIOS
    //     ? await FirebaseMessaging.instance.getAPNSToken()
    //     : await FirebaseMessaging.instance.getToken();
    // Intercom.instance.sendTokenToIntercom(token!);
    return token;
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");

  }

}
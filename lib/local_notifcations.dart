import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tanod_tractor/presentation/pages/admin_modules/geofence/controller/geofence_controller.dart';
import 'package:tanod_tractor/presentation/pages/admin_modules/geofence/views/add_new_geofence_view.dart';
import 'package:tanod_tractor/presentation/pages/admin_modules/geofence/views/admin_geofence_detail_view.dart';
import 'package:tanod_tractor/presentation/pages/full_details/common_controller.dart';
import 'package:tanod_tractor/presentation/pages/full_details/tractor_full_details.dart';
import 'package:tanod_tractor/presentation/pages/profile/controller/profile_controller.dart';
import 'package:tanod_tractor/presentation/pages/profile/widgets/booking_detail_page.dart';

import 'app/util/export_file.dart';

class NotificationHandler {
  static RemoteMessage? bgRemoteMessage;
  final _firebaseMessaging = FirebaseMessaging.instance;

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
      var remoteMessage) async {
    print('message from background handler: ${remoteMessage}');
  }

  Future initNotifications() async {
    int id = Random().nextInt(1000);
    await _firebaseMessaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(
        NotificationHandler.firebaseMessagingBackgroundHandler);
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    forgroundFirebaseCall();
    terminatedFirebaseCall();
    terminatedOverrideFirebaseCall();
  }

  //when application is on forground
  forgroundFirebaseCall() {
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      handleMessage(remoteMessage);
    });
  }

  //when application is terminated
  terminatedFirebaseCall() {
    FirebaseMessaging.instance.getInitialMessage().then((remoteMessage) {
      print("check remote message ${remoteMessage?.data}");
      if (remoteMessage != null) {
        tabOnNotifications(remoteMessage, true);
      }
    });
  }

  //when application is not terminated but other application overrides
  terminatedOverrideFirebaseCall() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      bgRemoteMessage = remoteMessage;
      if (remoteMessage != null) {
        tabOnNotifications(remoteMessage, true);
      }
    });
  }

  void handleMessage(RemoteMessage? remoteMessage) {
    if (remoteMessage != null && remoteMessage?.data != null) {
      showLocalNotifications(remoteMessage);
    }
  }

  showLocalNotifications(RemoteMessage remoteMessage) async {
    print("broadcast received for message ${remoteMessage?.data}");
    int id = Random().nextInt(10000);
    FlutterLocalNotificationsPlugin localNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: DarwinInitializationSettings(),
            macOS: null);

    await localNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse:
            NotificationHandler.firebaseMessagingBackgroundHandler,
        onDidReceiveNotificationResponse: (NotificationResponse details) {
      //  localNotificationsPlugin.cancel(id);
      if (details != null) {
        tabOnNotifications(remoteMessage, false);
      }
    });

    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
          'default_channel', // id
          'High Importance Notifications', // title
          description: 'Tis channel is used for important notifications.',
          // description
          importance: Importance.max,
          playSound: true);
      await localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
          "default_channel", 'Tanod Tarctor',
          importance: Importance.max, priority: Priority.high);
      var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
      );
      await localNotificationsPlugin.show(0, remoteMessage.notification?.title,
          remoteMessage.notification?.body, platformChannelSpecifics,
          payload: jsonEncode(remoteMessage.data));
    }
  }

  tabOnNotifications(RemoteMessage? remoteMessage, bool? fromBg) {
    if (remoteMessage == null && remoteMessage?.data == null) {
      return;
    }

    if (remoteMessage?.data['notification_type']?.toString() == APIEndpoint.typeEnterGeoFence || remoteMessage?.data['notification_type'] == APIEndpoint.typeExitGeofence) {
      if (!Get.isRegistered<AdminGeoFenceController>()) {
        Get.lazyPut(() => AdminGeoFenceController());
      }
      if (            box.read(roleType) == APIEndpoint.aminRole|| box.read(roleType) == APIEndpoint.subAdminRole
      ) {
        Get.to(AdminGeoFenceDetailView(geoFenceId: remoteMessage?.data['imei']));
      } else {
        Get.to(() => AddNewGeoFenceView( isFromHome: true, deviceImei: remoteMessage?.data['imei'],));
      }
    }else{
      if(!Get.isRegistered<CommonController>()){
        Get.lazyPut(() =>CommonController());
      }
      Get.to(TractorFullDetails(tractorModel: TractorModel(id: remoteMessage?.data['tractor_id']),));
    }
  }
}

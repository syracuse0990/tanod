import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tanod_tractor/presentation/pages/home/controller/home_controller.dart';

import 'app/services/local_storage.dart';
import 'app/util/dependency.dart';
import 'data/repositories/login_provider/impl/remote_login_provider.dart';
import 'local_notifcations.dart';
import 'presentation/app.dart';
final box = GetStorage();
Timer? timer;
void main() async {
  DependencyCreator.init();

  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl: true // option: set to false to disable working with http links (default: false)
  );
  await Firebase.initializeApp(
      options: Platform.isAndroid
          ? const FirebaseOptions(
          apiKey: 'AIzaSyCa2hMnCHGnpJQf38iruuleLqrBDlbZUOI',
          appId: "1:743016317630:android:79f46944b1e5c79b7f54ef",
          messagingSenderId: "743016317630",
          projectId: "tanod-tractor")
          : null);

  NotificationHandler().initNotifications();
  await initServices();
  Get.lazyPut(() => RemoteILoginProvider());
  Get.lazyPut(() => HomeController());


  await GetStorage.init();
  runApp(const App());
}

initServices() async {
  print('starting services ...');

  await Get.putAsync(() => LocalStorageService().init());

  print('All services started...');
}

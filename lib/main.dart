import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import 'page/home_page.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  // 플러터 엔진과 상호작용하기 위해서 처음에 작성
  WidgetsFlutterBinding.ensureInitialized();
  _initNotiSetting();
  runApp(const MyApp());
}

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void _initNotiSetting() async {
  // 타임존 셋팅 필요
  tz.initializeTimeZones();
  // local timeZone을 받도록 설정
  final timeZoneName = await FlutterNativeTimezone.getLocalTimezone(); 
  tz.setLocalLocation(tz.getLocation(timeZoneName));


  //안드로이드 셋팅
  const initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  //ios 셋팅
  const initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  // 두 셋팅을 다시 담기
  const initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

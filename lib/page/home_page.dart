import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:study_package/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FToast fToast;

  // initState 화면이 처음 호출될때 한번만 호출된다.
  // 화면이 변경을 감지하면 build가 호출된다.
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {
            _showToast();
          },
          child: const Text('btn'),
        ),
        // 알람 추가 버튼
        ElevatedButton(onPressed: () async {
            final notification = flutterLocalNotificationsPlugin;

            const android =  AndroidNotificationDetails(
              '0',// id는 유니크해야 한다. Test용이기 때문에 0을 넣었다.
              '알림테스트',
              channelDescription: '알림 테스트 바디 부분',
              importance: Importance.max,
              priority: Priority.max,
            );
            const ios = IOSNotificationDetails();
            const detail = NotificationDetails(
              android: android,
              iOS: ios,
            );

          final permission = Platform.isAndroid
              ? true
              : ((await notification.resolvePlatformSpecificImplementation<
                          IOSFlutterLocalNotificationsPlugin>()
                      ?.requestPermissions(alert: true, badge: true, sound: true)) ??
                  false);
            if(!permission){// permission이 아닐때 나가는 코드로 임시 작성
              return;
            }
            //permission이 true인 사람만 show 실행
            await flutterLocalNotificationsPlugin.show(
            0,// 유니크해야 한다. Test 용으로 하드코딩했다.
            'plain title',
            'plain body',
            detail,
            );

          },
          child: const Text('add alarm'),
        ),
        const Center(child: Text('hi'),)
      ]
    ),
    );
  }

 void _showToast() {
    Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
        ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
            Icon(Icons.check),
            SizedBox(
            width: 12.0,
            ),
            Text("This is a Custom Toast"),
        ],
        ),
    );


    fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 2),
    );
    
    // Custom Toast Position
    fToast.showToast(
        child: toast,
        toastDuration: const Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            top: 16.0,
            left: 16.0,
            child: child,
          );  
        });
    }

}
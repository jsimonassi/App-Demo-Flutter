import 'package:app_demo_flutter/constants/Colors.dart';
import 'package:app_demo_flutter/screens/Home.dart';
import 'package:app_demo_flutter/screens/Login.dart';
import 'package:app_demo_flutter/screens/Search.dart';
import 'package:app_demo_flutter/services/Config.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  try{
    await Config.loadEnvs();
    runApp(MyApp());
  }catch(e){
    throw FlutterError(e.toString());
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    OneSignal.shared.init(Config.env['ONE_SIGNAL_KEY']);
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.black,
        accentColor: AppColors.RED_BUTTON_COLOR,
      ),
      home: Login(),
    );
  }
}


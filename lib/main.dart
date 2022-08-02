
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/screens/PublicScreens/home_screen.dart';


import 'package:todo_app/sqflite/data.dart';

import 'screens/MainScreen.dart';
import 'screens/PublicScreens/myfirstScreen.dart';
import 'sqflite/private_data.dart';
final CreateDataBaseControllerpublic d=Get.put(CreateDataBaseControllerpublic());
final CreateDataBaseControllerprivate p=Get.put(CreateDataBaseControllerprivate());

void main() async{
   d.createDatabase();
   p.createDatabase();

  AwesomeNotifications().initialize(
     'resource://drawable/logo',

    [
      NotificationChannel(
      icon:  'resource://drawable/logo',

        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelDescription: '',
        ledColor: Colors.white,
        defaultColor: Colors.teal,

      ),

      NotificationChannel(
        icon:  'resource://drawable/logo',

        channelKey: 'scheduled_channel',
        channelName: 'Basic Notifications',
        defaultColor: Colors.teal,
        ledColor: Colors.white,

        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelDescription: '',




      ),

    ],
  );

  WidgetsFlutterBinding.ensureInitialized();
   await GetStorage.init();
  runApp( MyApp());


}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: BoardingScreen(),
    );
  }
}

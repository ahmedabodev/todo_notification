import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:scheduled_timer/scheduled_timer.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/services/Notifcation.dart';
import 'package:todo_app/services/testing.dart';
import 'package:todo_app/sqflite/data.dart';

import 'const.dart';
final CreateDataBaseController d=Get.put(CreateDataBaseController());
 playaudio( ) async {

  await player.pause();

  await player.setAudioSource(
    ConcatenatingAudioSource(
      // Start loading next item just before reaching it.
      useLazyPreparation: true, // default
      // Customise the shuffle algorithm.
      shuffleOrder: DefaultShuffleOrder(), // default
      // Specify the items in the playlist.
      children: [
        AudioSource.uri(Uri.parse("https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")),
      ],
    ),
    // Playback will be prepared to start from track1.mp3
    initialIndex: 0, // default
    // Playback will be prepared to start from position zero.
    initialPosition: Duration.zero, // default
  );

  await player.seekToNext();
  await player.seekToPrevious();
// Jump to the beginning of track3.mp3.
  await player.seek(Duration(milliseconds: 0), index: 0);

  player.play();
}

 void printHello() {
final DateTime now = DateTime.now();
final int isolateId = Isolate.current.hashCode;
print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
playaudio();
}
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() async{
  d.createDatabase();
  AwesomeNotifications().initialize(
    'resource://drawable/res_notification_app_icon',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        channelShowBadge: true, channelDescription: 'bl7a for programing',
      ),
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        defaultColor: Colors.teal,
        locked: true,
        importance: NotificationImportance.High,
        soundSource: 'resource://raw/res_custom_notification', channelDescription: 'company mostafa for stolen',
      ),
    ],
  );
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();

  runApp( MyApp());


}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: HomeScreen(),
    );
  }
}

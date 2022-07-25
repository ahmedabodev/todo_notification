
import 'dart:async';
import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:scheduled_timer/scheduled_timer.dart';
import 'package:todo_app/Widget.dart';
import 'package:todo_app/screens/Controller/Color_Controller.dart';
import 'package:todo_app/screens/add_screen.dart';
import 'package:todo_app/services/Notifcation.dart';
import 'package:todo_app/services/Utlits.dart';
import 'package:todo_app/services/testing.dart';
import 'package:todo_app/sqflite/data.dart';
import 'package:timezone/timezone.dart' as tz;

import '../const.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Allow Notifications'),
            content: Text('Our app would like to send you notifications'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Don\'t Allow',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
        );
      }
    });




  }

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  DateTime _selectedDate = DateTime.now();

  final int helloAlarmID = 0;

  bool check=false;

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
  final CreateDataBaseController d = Get.put(CreateDataBaseController());
  final Color_Color_Controller col = Get.put(Color_Color_Controller());

getsnak(index,title,minute,hour)async{

  var hourscompare=TimeOfDay.now().hour;
  var minutecompare=TimeOfDay.now().minute;
  var timehournowm;
  var timehournowh;
  if(minute>=minutecompare){
    timehournowm=minute-minutecompare;
  }else{
    timehournowm=minutecompare-minute;
  }
  if(hour>=hourscompare){
    timehournowh=hour-hourscompare;
  }else{
    timehournowh=hourscompare-hour;
  }
  
  print(timehournowh);
  await   Future.delayed(Duration(minutes:timehournowm.toInt(),hours: timehournowh.toInt() ));
  AndroidAlarmManager.periodic(Duration(seconds: 1)  ,helloAlarmID, playaudio());

// 0 denotes being equal positive value greater and negative value being less
  Get.snackbar(title,'ahmed',snackPosition: SnackPosition.TOP,backgroundColor: Colors.teal);


  // if(d.list[index]['start']!=TimeOfDay.now().format(context).toString()){
  //   print('hiiiii');
  // }else{
  //
  //   Get.snackbar(title,'ahmed',snackPosition: SnackPosition.TOP,backgroundColor: Colors.teal);
  //
  //
  // }


}
notfiacationalert(int hour,int minuts,int day)async{

  // NotificationWeekAndTime? pickedSchedule =
  // await pickSchedule(context);
  //
  // if (pickedSchedule != null) {
  //   createWaterReminderNotification(
  //     pickedSchedule,
  //     hour,
  //     minuts,
  //     day,
  //
  //   );
  // }
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo'),
        leading: IconButton(onPressed: ()async{
          // Get.snackbar('ahmed','ahmed',snackPosition: SnackPosition.TOP,backgroundColor: Colors.teal);

          // d.deleteAllData();
          // if(d.list[1]['start']==TimeOfDay.now().format(context).toString()){
          //   print('hiiiii');
          // }else{
          //   DateTime _now = DateTime.now();
          //   DateTime.parse('1969-07-20 20:18:04Z');
          //
          //   AndroidAlarmManager.oneShotAt(DateTime(27-7-2022),wakeup: true,alarmClock:false   ,helloAlarmID, playaudio()
          //   );
          //
          // }
          AwesomeNotifications()
              .requestPermissionToSendNotifications()
              .then((_) => Navigator.pop(context));


        },icon: Icon(Icons.add),),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Get.to(()=>AddScreen());
      },child: const Icon(Icons.add)),
      body: Column(

        children: [
          HomePageButtons(
            onPressedOne: createPlantFoodNotification,
            onPressedTwo: () async {

            },
            onPressedThree: cancelScheduledNotifications,
          ),
          DatePicker(

            DateTime.now(),
            initialSelectedDate: DateTime.now(),
            selectionColor: Colors.black,
            selectedTextColor: Colors.white,
            onDateChange: (date) {
              // New date selected
              _selectedDate=date;
                d.changedatatime(DateFormat('yyyy-MM-dd ').format(date));
                print(d.datetime);

            },
          ),
          GetBuilder<CreateDataBaseController>(builder: ( controller) {
            print(controller.list.toString());
            bool ahmed=false;
            return (controller.list.isEmpty)? Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height/2,
              child:const Align(
                  alignment: Alignment.center,
                  child: Text('No Data Found Please add more')),): Expanded(
              child: ListView.builder(
                itemCount: controller.list.length,
                itemBuilder: (BuildContext context, int index) {

                  // int a =controller.list[index]['state'];
                  //   bool intToBool= a == 0 ? false : true;
                  if(controller.list[index]['repeat']=='Daily'||controller.list[index]['date']==controller.datetime){

                    // if(d.list[index]['start']==TimeOfDay.now().format(context).toString()){
                    //   playaudio();
                    //       }
                    var time = DateFormat.jm().parse(controller.list[index]['start']);
                    var myTime = DateFormat('HH:mm').format(time);
                    // notifyHelper.scheduledNotification(
                    //     int.parse(myTime.toString().split(':')[0]),
                    //     int.parse(myTime.toString().split(':')[1]),
                    //   controller.list[index]['id'],
                    //     controller.list[index]['title'] ,
                    //   controller.list[index]['title'],
                    //  5 ,
                    //   controller.list[index]['repeat'],
                    //   controller.list[index]['date'],
                    //   controller.list[index]['start'],
                    //     );


                 // getsnak(index,controller.list[index]['title'],int.parse(myTime.toString().split(':')[1]),int.parse(myTime.toString().split(':')[0]));

    int a =controller.list[index]['state'];
                    bool intToBool= a == 0 ? false : true;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        color: col.backColor[controller.list[index]['color']],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10,),
                                        Text(controller.list[index]['start'].toString()),
                                        Text(controller.list[index]['state'].toString()),
                                        const SizedBox(height: 5,),

                                        Text(controller.list[index]['title'].toString()),
                                        const SizedBox(height: 10,),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: intToBool == true
                                              ? Colors.black
                                              : Colors.transparent,
                                          width: 1.5),
                                    ),
                                    width: 24,
                                    height: 24,
                                    child: Checkbox(
                                        checkColor: Colors.black,
                                        activeColor: Colors.transparent,
                                        // activeColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        value: intToBool,
                                        hoverColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        onChanged: (bool? value) {
                                          controller.onChange(value);
                                          controller.updateDatabase(id: controller.list[index]['id'], state: controller.currentIndex!);

                                          print(check);
                                        }),
                                  ),


                                ],
                              ),




                            ],
                          ),
                        ),
                      ),
                    );
                  }else{
                    return const SizedBox(height: 0,width: 0,);
                  }

                    }

              ),
            );

          },),

        ],
      ),
    );
  }
}


import 'dart:async';
import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/Widget.dart';
import 'package:todo_app/screens/Controller/Color_Controller.dart';
import 'package:todo_app/screens/PublicScreens/add_screen.dart';
import 'package:todo_app/screens/private/add_screenprivate.dart';
import 'package:todo_app/services/testing.dart';
import 'package:todo_app/sqflite/data.dart';
import 'package:todo_app/sqflite/private_data.dart';


class favoritescreen extends StatefulWidget {

  @override
  State<favoritescreen> createState() => _favoritescreenState();
}

class _favoritescreenState extends State<favoritescreen> {





  bool check=false;

  final CreateDataBaseControllerprivate d = Get.put(CreateDataBaseControllerprivate());
  final Color_Color_Controller col = Get.put(Color_Color_Controller());


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text('Private Todo'),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          onPressed: () {
            Get.to(()=>AddScreenprivate());
          },child: const Icon(Icons.add)),
      body: Column(

        children: [
          GetBuilder<CreateDataBaseControllerprivate>(builder: ( controller) {
            print(controller.privatelistfav.toString());
            bool ahmed=false;
            return (controller.privatelistfav.isEmpty)? Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height/2,
              child:const Align(
                  alignment: Alignment.center,
                  child: Text('No Data Found Please add more')),): Expanded(
              child: ListView.builder(
                  itemCount: controller.privatelistfav.length,
                  itemBuilder: (BuildContext context, int index) {

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
                            return Container(
                              color: Colors.blueGrey,
                              height: MediaQuery.of(context).size.height/3,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(horizontal: 30.0),

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MaterialButton(
                                    minWidth:MediaQuery.of(context).size.width,
                                    onPressed: (){
                                      d.deleteFromDatabase(id: controller.privatelist[index]['id']);
                                      Get.back();


                                    },color: Colors.teal,
                                    child:const Text('Delete Task',style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    ),),
                                  ),
                                  MaterialButton(
                                    minWidth:MediaQuery.of(context).size.width,
                                    onPressed: (){
                                      Get.back();
                                    },color: Colors.teal,
                                    child:const Text('Close Tab',style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    ),),
                                  ),
                                ],

                              ),
                            );

                          }, );                          },
                        child: Card(

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          color: col.backColor[controller.privatelistfav[index]['color']],
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
                                          Center(child: Text(controller.privatelistfav[index]['title'].toString(),style:const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                          ),)),
                                          const SizedBox(height: 10,),
                                          Row(
                                            children: [
                                              Text('Name:'),
                                              const SizedBox(width: 10,),
                                              Text(controller.privatelistfav[index]['note'].toString()),

                                            ],
                                          ),
                                          const SizedBox(height: 10,),
                                          Row(
                                            children: [
                                              Text('Password:'),
                                              const SizedBox(width: 10,),
                                              Text(controller.privatelistfav[index]['password'].toString()),

                                            ],
                                          ),
                                          const SizedBox(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(controller.privatelistfav[index]['start'].toString()),
                                              const SizedBox(width: 10,),
                                              Text(controller.privatelistfav[index]['date'].toString()),

                                            ],
                                          ),


                                        ],
                                      ),
                                    ),
                                    IconButton(onPressed: (){
                                      controller.updateDatabasefavorite(id: controller.privatelist[index]['id'], favorite: controller.privatelist[index]['favorite'] == 0 ? 1 : 0);
                                    }, icon:(controller.privatelist[index]['favorite'].toString()=='0')?Icon(Icons.favorite_border):Icon(Icons.favorite,color: Colors.red,),
                                    ),


                                  ],
                                ),




                              ],
                            ),
                          ),
                        ),
                      ),
                    );


                  }

              ),
            );

          },),

        ],
      ),
    );
  }
}

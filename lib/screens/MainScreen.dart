import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/PublicScreens/home_screen.dart';
import 'package:todo_app/screens/PublicScreens/myfirstScreen.dart';
import 'package:todo_app/screens/private/home_screenprivate.dart';
import 'package:todo_app/services/testing.dart';

import 'private/choose password.dart';

class BoardingScreen extends StatefulWidget {
   BoardingScreen({Key? key}) : super(key: key);

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
List<String>Imges=[
  'assets/private-chat.png',
  'assets/planning.png',
];

   List<String>NAME=[
     'Private',
     'Public',
   ];

   List<Widget>Screens=[
     Choosepassword(),
     firstScreen(),
   ];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    AwesomeNotifications().actionStream.listen((action) {
      if(action.buttonKeyPressed == "open1"){
        Get.to(()=>HomeScreen());
        print("Open button is pressed");
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
        ],
backgroundColor: Colors.teal,
      ),
      body:         GridView.builder(
        itemCount: 2,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2
        ), itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
              Get.to(()=>Screens[index]);
            },
            child: Card(
              color: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Expanded(child: Image.asset(Imges[index],)),
                    SizedBox(height: 20,),
                    Text(NAME[index]),
                  ],
                ),
              ),
            ),
          ),
        );
      }, ),
    );
  }
}

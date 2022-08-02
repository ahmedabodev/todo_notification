import 'package:flutter/material.dart';
import 'package:flutter_point_tab_bar/pointTabIndicator.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/Controller/MainController.dart';
import 'package:todo_app/screens/PublicScreens/home_screen.dart';
import 'package:todo_app/screens/daitalis%20Screen/AllScreen.dart';
import 'package:todo_app/screens/daitalis%20Screen/CompleteScreen.dart';
import 'package:todo_app/screens/daitalis%20Screen/FavouriteScreen.dart';
import 'package:todo_app/screens/daitalis%20Screen/uncompleteScreen.dart';
import 'package:todo_app/services/testing.dart';

class firstScreen extends StatefulWidget {
   firstScreen({Key? key}) : super(key: key);

  @override
  State<firstScreen> createState() => _firstScreenState();
}

class _firstScreenState extends State<firstScreen> with SingleTickerProviderStateMixin {
List<String>tabList=[
  'all',
  'Complete',
  'UnComplete',
  'Favourite',
];
List<Widget>Screens=[
  AllScreen(),
  CompleteScreen(),
  unCompleteScreen(),
  FavouriteScreen(),
];
final maintabbarcontroller c=Get.put(maintabbarcontroller());

late TabController _tabController;

@override
void initState() {
  _tabController = TabController(vsync: this, length: tabList.length);
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  backgroundColor: Colors.teal,
  centerTitle: true,
  title: const Text('Public Todo'),
  actions: [
    IconButton(onPressed: (){
      Get.to(()=>HomeScreen());
    }, icon: Icon(Icons.today_outlined)),
  ],
  bottom: TabBar(
    labelPadding: EdgeInsets.symmetric(horizontal: 5),
onTap: (value){
  c.changetabbar(value);
},
    controller: _tabController,
    indicator: PointTabIndicator(
      position: PointTabIndicatorPosition.bottom,
      color: Colors.white,
      insets: EdgeInsets.only(bottom: 6),
    ),
    tabs: tabList.map((item) {
      return Tab(
        text: item,
      );
    }).toList(),

  ),
),
      body:Column(
        children: [
          GetBuilder<maintabbarcontroller>(builder: ( controller) {
            return Screens[controller.index];

          }, ),
        ],
      ),
    );
  }
}

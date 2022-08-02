import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/Controller/Color_Controller.dart';
import 'package:todo_app/screens/Controller/MainController.dart';
import 'package:todo_app/sqflite/data.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({Key? key}) : super(key: key);
  final CreateDataBaseControllerpublic d = Get.put(CreateDataBaseControllerpublic());
  final Color_Color_Controller col = Get.put(Color_Color_Controller());
  final maintabbarcontroller mainController = Get.put(maintabbarcontroller());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateDataBaseControllerpublic>(builder: ( controller) {
      print(controller.list.toString());
      bool ahmed=false;
      return (controller.listbyfav.isEmpty)? Container(
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
              if(controller.list[index]['favorite']==1){

                int a =controller.list[index]['state'];
                bool intToBool= a == 0 ? false : true;
                int b =controller.list[index]['favorite'];
                bool intToBoolfavorite= a == 0 ? false : true;
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
                                  d.deleteFromDatabase(id: controller.list[index]['id']);
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

                      }, );
                    },
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
                                      Center(child: Text(controller.list[index]['title'].toString())),
                                      const SizedBox(height: 10,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Text('Start Time:'),
                                              const SizedBox(width: 10,),
                                              Text(controller.list[index]['start'].toString()),
                                            ],
                                          ),
                                          const SizedBox(height: 10,),
                                          Row(
                                            children: [
                                              Text('End Time:'),
                                              const SizedBox(width: 10,),
                                              Text(controller.list[index]['end'].toString()),
                                            ],
                                          ),
                                          const SizedBox(height: 10,),
                                          Row(
                                            children: [
                                              Text('Date:'),
                                              const SizedBox(width: 10,),
                                              Text(controller.list[index]['date'].toString()),
                                            ],
                                          ),
                                          const SizedBox(height: 10,),



                                        ],
                                      ),
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

                                      }),
                                ),
                                IconButton(onPressed: (){
                                  controller.updateDatabasefavorite(id: controller.list[index]['id'], favorite: controller.list[index]['favorite'] == 0 ? 1 : 0);
                                }, icon:(controller.list[index]['favorite'].toString()=='0')?Icon(Icons.favorite_border):Icon(Icons.favorite,color: Colors.red,),
                                ),


                              ],
                            ),




                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }else{
                return SizedBox(height: 0,width: 0,);
              }

            }

        ),
      );

    },);
  }
}

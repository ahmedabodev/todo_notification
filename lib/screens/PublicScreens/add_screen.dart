import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/custom_text_form_field.dart';
import 'package:todo_app/screens/Controller/Color_Controller.dart';
import 'package:todo_app/services/testing.dart';
import 'package:todo_app/sqflite/data.dart';


class AddScreen extends StatelessWidget {
  AddScreen({Key? key}) : super(key: key);

  final CreateDataBaseControllerpublic d = Get.put(CreateDataBaseControllerpublic());
  final Color_Color_Controller col = Get.put(Color_Color_Controller());
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final startController = TextEditingController();
  final endController = TextEditingController();
  final remindController = TextEditingController();
  final repeatController = TextEditingController();
  List<String> repeatitem = [
    'Daily',
    'None',
  ];
  List<String> remindtems = [
    'none',
    '10 minute before',
    '30 minute before',
    '1 hour before',
    '1 day before',
  ];

  showdate(context) async {
    DateTime date = DateTime(1900);
    FocusScope.of(context).requestFocus(new FocusNode());

    date = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100)))!;
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    dateController.text = formattedDate;
    print('my date' + '${dateController.toString()}' );
  }

  showtimestart(context) async {
    TimeOfDay? date;
    FocusScope.of(context).requestFocus(new FocusNode());

    date = (await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    ));
    startController.text = date!.format(context);
    print(TimeOfDay.now().format(context).toString());
  }

  showtimeend(context) async {
    TimeOfDay? date;
    FocusScope.of(context).requestFocus(new FocusNode());

    date = (await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    ));
    endController.text = date!.format(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Title'),
                SizedBox(
                  child: custom_text_form_field(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'title mustn\'t be empty';
                      }
                    },
                    hint: 'Title',
                  ),
                ),
                const Text('date'),
                SizedBox(
                  child: InkWell(
                    onTap: () {
                      showdate(context);
                    },
                    child: custom_text_form_field(
                      suffixIcon: Icon(Icons.calendar_month),
                      enableed: false,
                      controller: dateController,
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'date mustn\'t be empty';
                        }
                      },
                      hint: 'date',
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('start time'),
                          SizedBox(
                            child: InkWell(
                              onTap: () {
                                showtimestart(context);
                              },
                              child: custom_text_form_field(
                                suffixIcon: Icon(Icons.watch_later_outlined),
                                enableed: false,
                                controller: startController,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'start time mustn\'t be empty';
                                  }
                                },
                                hint: 'start time',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('end time'),
                          SizedBox(
                            child: InkWell(
                              onTap: () {
                                showtimeend(context);
                              },
                              child: custom_text_form_field(
                                suffixIcon: Icon(Icons.watch_later_outlined),
                                enableed: false,
                                controller: endController,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'end time mustn\'t be empty';
                                  }
                                },
                                hint: 'end time',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Text('Remind'),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField2(
                  decoration: InputDecoration(
                    //Add isDense true and zero Padding.
                    //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    //Add more decoration as you want here
                    //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                  ),
                  isExpanded: true,
                  hint: const Text(
                    'Select Your Remind',
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 50,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: remindtems
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select Remind';
                    }
                  },
                  onChanged: (value) {
                    remindController.text = value.toString();

                    //Do something when changing the item if you want.
                  },
                  onSaved: (value) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Color'),
                GetBuilder<Color_Color_Controller>(
                  builder: (controller) {
                    return SizedBox(
                      height: 50,
                      child: ListView.builder(
                        itemCount: controller.backColor.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                controller.changevalue(index);
                                print(controller.mycolorindex);
                              },
                              child: CircleAvatar(
                                backgroundColor: controller.backColor[index],
                                child:(controller.mycolorindex==index)?Icon(Icons.done,color:Colors.black,):null,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: MaterialButton(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minWidth: MediaQuery.of(context).size.width,
                      color: Colors.teal,
                      child: const Text('Create Task'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          d.insertIntoDatabase(
                              title: titleController.text,
                              date: dateController.text,
                              start: startController.text,
                              end: endController.text,
                              remind: remindController.text,
                              repeat: repeatController.text,
                              color: col.mycolorindex,
                              state: 0,
                              favorite: 0,
                          );
                        //   '10 minute before',
                        // '30 minute before',
                        // '1 hour before',
                        // '1 day before',
                          bool repeats=false;
                          var myTime;
                          var time = DateFormat.jm().parse(startController.text);
                          var myTimeend;
                          var timeend = DateFormat.jm().parse(endController.text);

                          if(remindController.text=='10 minute before'){
                            myTime = DateFormat('HH:mm').format(time.subtract(Duration(minutes: 10)));

                          }else if(remindController.text=='30 minute before'){
                            myTime = DateFormat('HH:mm').format(time.subtract(Duration(minutes: 30)));

                          }else if(remindController.text=='1 hour before'){
                            myTime = DateFormat('HH:mm').format(time.subtract(Duration(hours: 1)));

                          }else if(remindController.text=='1 day before'){
                            myTime = DateFormat('HH:mm').format(time.subtract(Duration(days: 1)));

                          }else{
                            myTime = DateFormat('HH:mm').format(time);

                          }

                          if(remindController.text=='10 minute before'){
                            myTimeend = DateFormat('HH:mm').format(timeend.subtract(Duration(minutes: 10)));

                          }else if(remindController.text=='30 minute before'){
                            myTimeend = DateFormat('HH:mm').format(timeend.subtract(Duration(minutes: 30)));

                          }else if(remindController.text=='1 hour before'){
                            myTimeend = DateFormat('HH:mm').format(timeend.subtract(Duration(hours: 1)));

                          }else if(remindController.text=='1 day before'){
                            myTimeend = DateFormat('HH:mm').format(timeend.subtract(Duration(days: 1)));

                          }else{
                            myTimeend = DateFormat('HH:mm').format(timeend);

                          }



                          print(repeats);
                          int year=int.parse(dateController.text.split('-')[0]);
                          int month=int.parse(dateController.text.split('-')[1]);
                          int day=int.parse(dateController.text.split('-')[2]);

                            createWaterReminderNotification(
                              timeOfDayhour: int.parse(myTime.toString().split(':')[0]),
                              timeOfDayminute: int.parse(myTime.toString().split(':')[1]),
                              day: day,
                              month: month,
                              year: year,
                              title: titleController.text,
                              note: 'Start Task',
                              repeats: true,
                            );
                          createWaterReminderNotification(
                            timeOfDayhour: int.parse(myTimeend.toString().split(':')[0]),
                            timeOfDayminute: int.parse(myTimeend.toString().split(':')[1]),
                            day: day,
                            month: month,
                            year: year,
                            title: titleController.text,
                            note: 'End Task',
                            repeats: true,
                          );



                          Get.back();
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

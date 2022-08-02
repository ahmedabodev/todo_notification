import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/custom_text_form_field.dart';
import 'package:todo_app/screens/Controller/Color_Controller.dart';
import 'package:todo_app/services/testing.dart';
import 'package:todo_app/sqflite/data.dart';
import 'package:todo_app/sqflite/private_data.dart';


class AddScreenprivate extends StatelessWidget {
  AddScreenprivate({Key? key}) : super(key: key);

  final CreateDataBaseControllerprivate d = Get.put(CreateDataBaseControllerprivate());
  final Color_Color_Controller col = Get.put(Color_Color_Controller());
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final startController = TextEditingController();




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
    var x = Duration(days: 7);
    print('my date' + '${dateController.toString() + x.toString()}');
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
                const Text('Name'),
                SizedBox(
                  child: custom_text_form_field(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name mustn\'t be empty';
                      }
                    },
                    hint: 'Name',
                  ),
                ),
                const Text('Password'),
                SizedBox(
                  child: custom_text_form_field(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password mustn\'t be empty';
                      }
                    },
                    hint: 'Password',
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
                const SizedBox(
                  width: 20,
                ),
                const Text('Remind'),
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
                              color: col.mycolorindex,
                              note: nameController.text,
                              password: passwordController.text,
                              favorite: 0,
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

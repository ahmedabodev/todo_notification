import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({
    Key? key,
    required this.payLoad,
  }) : super(key: key);
  final String payLoad;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payLoad = '';
  @override
  void initState() {

    super.initState();
    _payLoad = widget.payLoad;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,

      appBar: AppBar(
        elevation: 0,
        title: Text(
          _payLoad.toString().split('|')[1],
          style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.grey),
        ),
        backgroundColor: context.theme.backgroundColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon:  Icon( Icons.arrow_back_outlined,color: Get.isDarkMode?Colors.white:Colors.grey,),
        ),
      ),
      body: SafeArea(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Text(
                'Hello ahmad',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Get.isDarkMode ? Colors.white : Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'You have new note',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Get.isDarkMode ?Colors.grey.shade300  : Colors.grey),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32), color: Colors.blue),
                child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start ,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.text_format,
                              size: 30,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Title',
                              style: TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          _payLoad.toString().split('|')[0],
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.description,
                              size: 30,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'description',
                              style: TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          _payLoad.toString().split('|')[1],
                          style: const TextStyle(color:  Colors.white,fontSize: 20,
                          ),

                          textAlign:TextAlign.justify ,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 30,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Date',
                              style: TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          _payLoad.toString().split('|')[2],
                          style: const TextStyle(color:  Colors.white,fontSize: 20,
                          ),
                        ),
                      ],
                    )),
              )),
          const SizedBox(
            height: 10,
          ),
        ]),
      ),
    );
  }
}
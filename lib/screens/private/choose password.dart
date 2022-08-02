import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/private/Changepassword.dart';
import 'package:todo_app/screens/private/Controller/password_controller.dart';
import 'package:todo_app/screens/private/EnterPassword.dart';
import 'package:todo_app/screens/private/Firstpassword.dart';
import 'package:todo_app/screens/private/home_screenprivate.dart';

class Choosepassword  extends StatelessWidget {
   Choosepassword ({Key? key}) : super(key: key);
   final Password_Controller c=Get.put(Password_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Private Todo'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (c.password.read('password')!=null)?MaterialButton(
                minWidth:MediaQuery.of(context).size.width,
            onPressed: (){
                  Get.to(()=>EnterPassword());
            },color: Colors.teal,
                child:  const Text(' have password ',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),),):const SizedBox(height: 0,width: 0,),
              (c.password.read('password')!=null)?const SizedBox(height: 0,width: 0,):MaterialButton(
                minWidth:MediaQuery.of(context).size.width,
                onPressed: (){
                  Get.to(()=>FirstPassword());
                },color: Colors.teal,
                child:  const Text(' I don\'t have password ',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),),
              ),
              (c.password.read('password')!=null)?MaterialButton(
            minWidth:MediaQuery.of(context).size.width,
            onPressed: (){
              Get.to(()=>ChangePassword());
            },color: Colors.teal,
                child:  const Text(' Change password ',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),),
              ):const SizedBox(height: 0,width: 0,),
            ],
          ),
        ),
      ),
    );
  }
}

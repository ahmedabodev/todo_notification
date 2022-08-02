import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/private/Controller/password_controller.dart';
import 'package:todo_app/screens/private/Firstpassword.dart';
import 'package:todo_app/screens/private/home_screenprivate.dart';
import 'package:todo_app/text%20form%20field%20passward.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);
  final Password_Controller c = Get.put(Password_Controller());
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Private Todo'),
        backgroundColor: Colors.teal,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Textformfieldpassward(
                  hintText: 'Password',
                  controller:passwordController ,
                  suffixIcon: IconButton(
                    onPressed: () {


                    },
                    icon: const Icon(
                      Icons.remove_red_eye_outlined,
                    ),
                  ),

                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter your password';
                    }
                    else {
                      return null;
                    }
                  }),
              const SizedBox(height: 20,),
              MaterialButton(
                minWidth:MediaQuery.of(context).size.width/2,
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    if(c.password.read('password')==passwordController.text){
                      Get.off(FirstPassword());
                    }else{
                      Get.defaultDialog(title: 'Error',middleText: 'Password is not match');

                    }


                  }
                },color: Colors.teal,
                child:  const Text(' Enter old password ',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

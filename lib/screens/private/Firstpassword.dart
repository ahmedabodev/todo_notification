import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/private/Controller/password_controller.dart';
import 'package:todo_app/screens/private/home_screenprivate.dart';
import 'package:todo_app/text%20form%20field%20passward.dart';

class FirstPassword extends StatelessWidget {
  FirstPassword({Key? key}) : super(key: key);
  final passwordController = TextEditingController();
  final Password_Controller c = Get.put(Password_Controller());
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
                    c.passpassword(passwordController.text);
                      Get.off(HomeScreenprivate());
                    Get.defaultDialog(title: 'Welcome',middleText: 'Private Todo');
                    print(c.password.read('password'));

                  }
                },color: Colors.teal,
                child:(c.password.read('password')==null)?const Text(' Register ',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),):const Text(' Change Password ',style: TextStyle(
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

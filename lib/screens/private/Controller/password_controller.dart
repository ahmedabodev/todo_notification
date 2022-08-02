import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Password_Controller extends GetxController{
  final password = GetStorage();
  passpassword(value){
    password.write('password', value);
    update();
  }
}
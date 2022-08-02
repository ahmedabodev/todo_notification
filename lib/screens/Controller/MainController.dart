import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/daitalis%20Screen/AllScreen.dart';
import 'package:todo_app/screens/daitalis%20Screen/CompleteScreen.dart';

class maintabbarcontroller extends GetxController{
  int index=0;

  changetabbar(value){
    index=value;
    update();
  }

}
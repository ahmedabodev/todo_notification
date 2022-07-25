import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Color_Color_Controller extends GetxController{
  var date;
  int mycolorindex=0;

  List<Color>backColor=[
    Colors.blue,
    Colors.redAccent,
    Colors.orangeAccent,
    Colors.yellowAccent,
  ];
  changedate(value){
    date=value;
    update();
  }

  changevalue(value){
    mycolorindex=value;
    update();
  }

}
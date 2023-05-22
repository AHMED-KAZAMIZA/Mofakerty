import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mofakerty/components.dart';

var appColorBox = Hive.box('AppColorBox');
var darkBox = Hive.box('DarkBox');

var black = Colors.black;

class SaveColor extends GetxController {
  var appColor = Colors.red.obs;
  var darkMode = false.obs;
  var isBlack = false.obs;

  enableDarkMode() {
    darkBox.put('darkMode', true);
    darkMode.value = darkBox.get('darkMode');
  }

  disableDarkMode() {
    darkBox.put('darkMode', false);
    darkMode.value = darkBox.get('darkMode');
  }

  redColor() {
    appColorBox.put('color', 'red');
    appColor.value = Colors.red;
    isBlack.value = false;
  }

  orangeColor() {
    appColorBox.put('color', 'orange');
    appColor.value = Colors.orange;
    isBlack.value = false;
  }

  yellowColor() {
    appColorBox.put('color', 'yellow');
    appColor.value = Colors.yellow;
    isBlack.value = false;
  }

  greenColor() {
    appColorBox.put('color', 'green');
    appColor.value = Colors.green;
    isBlack.value = false;
  }

  tealColor() {
    appColorBox.put('color', 'teal');
    appColor.value = Colors.teal;
    isBlack.value = false;
  }

  limeColor() {
    appColorBox.put('color', 'lime');
    appColor.value = Colors.lime;
    isBlack.value = false;
  }

  purpleColor() {
    appColorBox.put('color', 'purple');
    appColor.value = Colors.purple;
    isBlack.value = false;
  }

  pinkColor() {
    appColorBox.put('color', 'pink');
    appColor.value = Colors.pink;
    isBlack.value = false;
  }

  deepPurpleColor() {
    appColorBox.put('color', 'deepPurple');
    appColor.value = Colors.deepPurple;
    isBlack.value = false;
  }

  cyanColor() {
    appColorBox.put('color', 'cyan');
    appColor.value = Colors.cyan;
    isBlack.value = false;
  }

  deepOrangeColor() {
    appColorBox.put('color', 'deepOrange');
    appColor.value = Colors.deepOrange;
    isBlack.value = false;
  }

  blueColor() {
    appColorBox.put('color', 'blue');
    appColor.value = Colors.blue;
    isBlack.value = false;
  }

  blueGreyColor() {
    appColorBox.put('color', 'blueGrey');
    appColor.value = Colors.blueGrey;
    isBlack.value = false;
  }

  brownColor() {
    appColorBox.put('color', 'brown');
    appColor.value = Colors.brown;
    isBlack.value = false;
  }

  blackColor() {
    appColorBox.put('color', 'black');
    isBlack.value = true;
  }

  // amberColor() {
  //   appColorBox.put('color', 'amber');
  //   appColor.value = Colors.amber;
  // }

  saveColor() {
    switch (appColorBox.get('color')) {
      case 'red':
        myAppColor.appColor.value = Colors.red;
        break;

      case 'orange':
        myAppColor.appColor.value = Colors.orange;
        break;

      case 'yellow':
        myAppColor.appColor.value = Colors.yellow;
        break;

      case 'green':
        myAppColor.appColor.value = Colors.green;
        break;

      case 'teal':
        myAppColor.appColor.value = Colors.teal;
        break;

      case 'lime':
        myAppColor.appColor.value = Colors.lime;
        break;

      case 'purple':
        myAppColor.appColor.value = Colors.purple;
        break;

      case 'pink':
        myAppColor.appColor.value = Colors.pink;
        break;

      case 'deepPurple':
        myAppColor.appColor.value = Colors.deepPurple;
        break;

      case 'cyan':
        myAppColor.appColor.value = Colors.cyan;
        break;

      case 'deepOrange':
        myAppColor.appColor.value = Colors.deepOrange;
        break;

      case 'blue':
        myAppColor.appColor.value = Colors.blue;
        break;

      case 'blueGrey':
        myAppColor.appColor.value = Colors.blueGrey;
        break;

      case 'brown':
        myAppColor.appColor.value = Colors.brown;
        break;

      // case 'amber':
      //   myAppColor.appColor.value = Colors.amber;
      //   break;

      case 'black':
        myAppColor.blackColor();
        break;

      default:
        myAppColor.appColor.value = Colors.red;
    }
  }
}

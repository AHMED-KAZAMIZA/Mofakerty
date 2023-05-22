import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mofakerty/components.dart';
import 'package:mofakerty/save_color.dart';

class SettingScreen extends StatelessWidget {
  final SaveColor myAppColor = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            (myAppColor.darkMode.value) ? Colors.grey[900] : Colors.white,
        appBar: AppBar(
          foregroundColor: (appColorBox.get('color') == 'yellow' ||
                  appColorBox.get('color') == 'lime')
              ? Colors.black
              : Colors.white,
          backgroundColor: (myAppColor.isBlack.value)
              ? Colors.black
              : myAppColor.appColor.value,
          title: const Text('إعدادات التطبيق'),
          centerTitle: true,
        ),
        body: ListView(children: [
          SizedBox(height: 20),
          Center(
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'إختر لونك المفضل',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: (myAppColor.darkMode.value)
                        ? Colors.white
                        : Colors.grey[900],
                  ),
                )),
          ),
          Center(
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'بيت الألوان',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: (myAppColor.darkMode.value)
                        ? Colors.white
                        : Colors.grey[900],
                  ),
                )),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 430,
              decoration: BoxDecoration(
                  color: (myAppColor.darkMode.value)
                      ? Colors.black26
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ColorSquare(
                                color: Colors.red,
                                setColor: () {
                                  myAppColor.redColor();
                                   
                                  myAppColor.saveColor();
                                }),
                            ColorSquare(
                                color: Colors.orange,
                                setColor: () {
                                  myAppColor.orangeColor();
                                   
                                  myAppColor.saveColor();
                                }),
                            ColorSquare(
                                color: Colors.yellow,
                                setColor: () {
                                  myAppColor.yellowColor();
                                   
                                  myAppColor.saveColor();
                                }),
                          ])),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ColorSquare(
                                color: Colors.green,
                                setColor: () {
                                  myAppColor.greenColor();
                                   
                                  myAppColor.saveColor();
                                }),
                            ColorSquare(
                                color: Colors.teal,
                                setColor: () {
                                  myAppColor.tealColor();
                                   
                                  myAppColor.saveColor();
                                }),
                            ColorSquare(
                                color: Colors.lime,
                                setColor: () {
                                  myAppColor.limeColor();
                                   
                                  myAppColor.saveColor();
                                }),
                          ])),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ColorSquare(
                                color: Colors.purple,
                                setColor: () {
                                  myAppColor.purpleColor();
                                   
                                  myAppColor.saveColor();
                                }),
                            ColorSquare(
                                color: Colors.pink,
                                setColor: () {
                                  myAppColor.pinkColor();
                                   
                                  myAppColor.saveColor();
                                }),
                            ColorSquare(
                                color: Colors.deepPurple,
                                setColor: () {
                                  myAppColor.deepPurpleColor();
                                   
                                  myAppColor.saveColor();
                                }),
                          ])),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ColorSquare(
                                color: Colors.cyan,
                                setColor: () {
                                  myAppColor.cyanColor();
                                   
                                  myAppColor.saveColor();
                                }),
                            ColorSquare(
                                color: Colors.deepOrange,
                                setColor: () {
                                  myAppColor.deepOrangeColor();
                                   
                                  myAppColor.saveColor();
                                }),
                            ColorSquare(
                                color: Colors.blue,
                                setColor: () {
                                  myAppColor.blueColor();
                                   
                                  myAppColor.saveColor();
                                }),
                          ])),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ColorSquare(
                                color: Colors.blueGrey,
                                setColor: () {
                                  myAppColor.blueGreyColor();
                                   
                                  myAppColor.saveColor();
                                }),
                            ColorSquare(
                                color: Colors.brown,
                                setColor: () {
                                  myAppColor.brownColor();
                                   
                                  myAppColor.saveColor();
                                }),
                            ColorSquare(
                                color: Colors.black,
                                setColor: () {
                                  myAppColor.blackColor();
                                   
                                  myAppColor.saveColor();
                                }),
                          ])),
                ],
              )),
          Center(
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'تغيير وضع التطبيق',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: (myAppColor.darkMode.value)
                        ? Colors.white
                        : Colors.grey[900],
                  ),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Switch(
                  value: myAppColor.darkMode.value,
                  onChanged: (value) {
                    if (myAppColor.darkMode.value) {
                      myAppColor.disableDarkMode();
                    } else {
                      myAppColor.enableDarkMode();
                    }
                  }),
              Text(
                'تفعيل الوضع الليلي',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: (myAppColor.darkMode.value)
                      ? Colors.white
                      : Colors.grey[900],
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}

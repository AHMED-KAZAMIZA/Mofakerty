import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'save_color.dart';
final SaveColor myAppColor = Get.find();

Widget NoteBox(
        {
        Color? boxColor,
        required Color noteColor,
        required String date,
        required String title,
        required String content}) =>
    Column(children: [
      SizedBox(height: 20),
      Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
            color: noteColor,
            border:
                Border.all(color: Colors.blueGrey, width: 1),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),

        child: Text(
          date,
          textAlign: TextAlign.center,
          style: TextStyle(
               color: (appColorBox.get('color') == 'yellow' || appColorBox.get('color') == 'lime') ? Colors.black : Colors.white,
               fontSize: 16, 
               fontWeight: FontWeight.bold),
        ),
      ),
      Container(
          width: 250,
          height: 150,
          decoration: BoxDecoration(
              color: boxColor,
              border: Border.all(
                  color:  Colors.blueGrey, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Column(children: [
            Container(
              width: double.infinity,
              height: 46,
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.only(top: 15),
              color: noteColor,
              child: Text(
                title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: (appColorBox.get('color') == 'yellow' || appColorBox.get('color') == 'lime' ) ? Colors.black : Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(content,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: (myAppColor.darkMode.value) ? Colors.white : Colors.black
                      ))),
            )
          ]))
    ]);

Widget TextIcon({
  required String text,
  required IconData icon,
}) =>
    Stack(alignment: Alignment.bottomCenter, children: [
      Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Icon(
            icon,
            color: Colors.black,
            size: 32,
          )),
      Text(text,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
    ]);

Widget ColorSquare({
  required Color color,
  required Function() setColor
  }) => InkWell(
      onTap: setColor,
      child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10)
              ) ),
    );
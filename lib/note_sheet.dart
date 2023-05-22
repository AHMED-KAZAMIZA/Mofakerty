import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mofakerty/save_color.dart';

final SaveColor myAppColor = Get.find();
var dateController = TextEditingController();
var titleController = TextEditingController();
var contentController = TextEditingController();
String noteDate = '', noteTitle = '', noteContent = '';
Widget NoteSheet(
        context,
        {
        required String date,
        required String title,
        required String content,
        }) =>
    Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: double.infinity,
          height: 500,
          padding: const EdgeInsets.all(20),
          color: (myAppColor.darkMode.value) ? Colors.grey[800] : Colors.grey[300],
          child: Column(
            children: [
              SizedBox(height: 20),
              TextField(
                  textAlign: TextAlign.right,
                  controller: dateController,
                  style: TextStyle(
                    color: (myAppColor.darkMode.value) ? Colors.white : Colors.black,
                  ),
                  onTap: () {
                    
                    showDatePicker(
                      
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1100),
                            lastDate: DateTime(2100))
                        .then((value) {
                      var day = value!.day,
                          month = value.month,
                          year = value.year,
                          date = '$day/$month/$year';
                      dateController.text = date;
                      noteDate = date;
                    });
                  },
                  decoration: (myAppColor.darkMode.value) ? const InputDecoration(
                    
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2
                      )
                    ),
                    labelText: 'تاريخ الملاحظة',
                    labelStyle: TextStyle( color: Colors.white )
                  )
                  
                  : const InputDecoration(

                    border: OutlineInputBorder(),
                    labelText: 'تاريخ الملاحظة',
                  ) ),

              SizedBox(height: 20),

              TextField(
                  textAlign: TextAlign.right,
                  controller: titleController,

                  style: TextStyle(
                    color: (myAppColor.darkMode.value) ? Colors.white : Colors.black,
                  ),
                  onChanged: (data) {
                    noteTitle = data;
                  },
                  decoration: (myAppColor.darkMode.value) ? const InputDecoration(
                    
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2
                      )
                    ),
                    labelText: 'عنوان الملاحظة',
                    labelStyle: TextStyle( color: Colors.white )

                  ) :  InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'عنوان الملاحظة',
                  )  ),

              SizedBox(height: 20),

              TextField(
                  textAlign: TextAlign.right,
                  controller: contentController,
                  style: TextStyle(
                    color: (myAppColor.darkMode.value) ? Colors.white : Colors.black,
                  ),
                  onChanged: (data) {
                    noteContent = data;
                  },
                  maxLines: 7,

                  decoration: (myAppColor.darkMode.value) ? const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2
                      )
                    ),
                    labelText: 'محتوى الملاحظة',
                    labelStyle: TextStyle( color: Colors.white )
                  ) : const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'محتوى الملاحظة',
                  )),
            ],
          ),
        ));


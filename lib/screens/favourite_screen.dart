import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mofakerty/note_counter.dart';
import 'package:mofakerty/save_favourite_notes.dart';
import '../components.dart';
import '../save_color.dart';
import 'content_screen.dart';

class FavouriteScreen extends StatelessWidget {
  final NoteCounter counter = Get.find();
  final SaveColor myAppColor = Get.find();
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: (myAppColor.darkMode.value) ? Colors.grey[900] : Colors.white,
          appBar: AppBar(
              foregroundColor: (appColorBox.get('color') == 'yellow' || appColorBox.get('color') == 'lime') ? Colors.black : Colors.white,
              backgroundColor: (myAppColor.isBlack.value) ? Colors.black : myAppColor.appColor.value,
              title: const Text('ملاحظاتي المفضلة'),
              centerTitle: true),
          body: (counter.noteCount.value == 0)
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite,
                        size: 150, color: (myAppColor.isBlack.value) ? Colors.black : myAppColor.appColor.value),
                    const Text('لا يوجد ملاحظة مفضلة',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold))
                  ],
                ))
              : ListView.builder(
                  itemCount: counter.noteCount.value,
                  itemBuilder: (context, index) {
                    if (favList.isNotEmpty) {
                      favList.removeAt(index);
                      favList.insert(
                          index,
                          NoteBox(
                              boxColor: (myAppColor.darkMode.value)
                                            ? Colors.grey[800]
                                            : const Color.fromARGB(
                                                255, 222, 222, 222),
                              noteColor: (myAppColor.isBlack.value) ? Colors.black : myAppColor.appColor.value,
                              date: favDate[index],
                              title: favTitle[index],
                              content: favContent[index]));
                    }
                    return InkWell(
                        onTap: () {
                          Get.to(ContentScreen(
                                      id: contents.indexOf(favContent[index]),
                                      date: favDate[index],
                                      title: favTitle[index],
                                      content: favContent[index],
                                      letter: favContent[index][0],
                                      isFavourite: favNotes[contents.indexOf(favContent[index])]
                                      ));
                        },
                        child: favList[index]);
                  }),
        ));
  } }
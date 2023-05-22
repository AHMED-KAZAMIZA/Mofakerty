import 'package:flutter/material.dart';
import 'package:mofakerty/components.dart';
import 'package:mofakerty/note_counter.dart';
import 'package:mofakerty/save_favourite_notes.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import '../save_color.dart';

class ContentScreen extends StatefulWidget {
  final int id;
  final String date;
  final String title;
  final String content;
  final String letter;
  bool isFavourite;

  ContentScreen({
    required this.id,
    required this.date,
    required this.title,
    required this.content,
    required this.letter,
    required this.isFavourite,
  });

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  final NoteCounter counter = Get.find();
  final SaveColor myAppColor = Get.find();
  @override
  Widget build(BuildContext context) {
    final String noteData = '${widget.date} \n ${widget.title} \n\n ${widget.content} ';
    bool isArabic = true;
    int letterNumber = widget.letter.codeUnits.first;

    if (letterNumber < 123) {
      isArabic = false;
    }

    return Obx(() => Scaffold(
          backgroundColor: (myAppColor.darkMode.value)
              ? Colors.grey[900]
              : const Color.fromARGB(255, 222, 222, 222),
          appBar: AppBar(
              foregroundColor: (appColorBox.get('color') == 'yellow' ||
                      appColorBox.get('color') == 'lime')
                  ? Colors.black
                  : Colors.white,
              backgroundColor: (myAppColor.isBlack.value)
                  ? Colors.black
                  : myAppColor.appColor.value,
              title: Column(children: [
                Text(
                  widget.date,
                  style: const TextStyle(fontSize: 15),
                ),
                Text(widget.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ]),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      if (widget.isFavourite) {
                        counter.decreaseNote();
                        setState(() {
                          widget.isFavourite = false;
                          favNotes[widget.id] = widget.isFavourite;
                        });

                        favNoteBox.put('favourite', favNotes);
                        favList.removeAt(favContent.indexOf(widget.content));
                        favDate.remove(widget.date);
                        favTitle.remove(widget.title);
                        favContent.remove(widget.content);
                        favDateBox.put('favdate', favDate);
                        favTitleBox.put('favtitle', favTitle);
                        favContentBox.put('favcontent', favContent);
                      } else {
                        counter.increaseNote();
                        setState(() {
                          widget.isFavourite = true;
                          favNotes[widget.id] = widget.isFavourite;
                        });

                        favDate.add(widget.date);
                        favTitle.add(widget.title);
                        favContent.add(widget.content);
                        favList.add(NoteBox(
                            boxColor: (myAppColor.darkMode.value)
                                            ? Colors.grey[800]
                                            :   Color.fromARGB(
                                                255, 222, 222, 222),
                            noteColor: myAppColor.appColor.value,
                            date: widget.date,
                            title: widget.title,
                            content: widget.content));

                        favNoteBox.put('favourite', favNotes);
                        favDateBox.put('favdate', favDate);
                        favTitleBox.put('favtitle', favTitle);
                        favContentBox.put('favcontent', favContent);
                      }
                    },
                    icon: (widget.isFavourite)
                        ? const Icon(Icons.favorite)
                        : const Icon(Icons.favorite_border)),
                IconButton(
                    onPressed: () {
                      Share.share(noteData);
                    },
                    icon: const Icon(Icons.share)),
              ]),
          body: ListView(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text(widget.content,
                    textDirection:
                        (isArabic) ? TextDirection.rtl : TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 18,
                      color: (myAppColor.darkMode.value)
                          ? Colors.white
                          : Colors.grey[900],
                    )),
              )
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mofakerty/components.dart';
import 'package:mofakerty/note_counter.dart';
import 'package:mofakerty/note_sheet.dart';
import 'package:mofakerty/screens/appinfo_screen.dart';
import 'package:mofakerty/screens/content_screen.dart';
import 'package:hive/hive.dart';
import 'package:mofakerty/screens/favourite_screen.dart';
import 'package:mofakerty/screens/setting_screen.dart';
import '../save_color.dart';
import '../save_favourite_notes.dart';

class NotesScreen extends StatefulWidget {
  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final NoteCounter counter = Get.find();
  final SaveColor myAppColor = Get.find();
  var dateBox = Hive.box('DateBox');
  var titleBox = Hive.box('TitleBox');
  var contentBox = Hive.box('ContentBox');
  var selectedNoteBox = Hive.box('SelectedNoteBox');

  @override
  // Save all notes and display them when a user opens the app
  void initState() {
    super.initState();
    if(titleBox.isNotEmpty) {
    if (titleBox.values.first.isNotEmpty) {
      setState(() {
        isVisibleNote = true;
        dates.addAll(dateBox.get('date'));
        titles.addAll(titleBox.get('title'));
        contents.addAll(contentBox.get('content'));
        selectedNotes.addAll(selectedNoteBox.get('selected'));
        favNotes.addAll(favNoteBox.get('favourite'));
      });

      for (int i = 0; i < titles.length; i++) {
        setState(() {
          noteView.add(NoteBox(
              boxColor: (myAppColor.darkMode.value)
                  ? Colors.grey[800]
                  : const Color.fromARGB(255, 222, 222, 222),
              noteColor: (myAppColor.isBlack.value)
                  ? Colors.black
                  : myAppColor.appColor.value,
              date: dates[i],
              title: titles[i],
              content: contents[i]));
        });
      }

      if (favContentBox.isNotEmpty) {
        setState(() {
          favDate.addAll(favDateBox.get('favdate'));
          favTitle.addAll(favTitleBox.get('favtitle'));
          favContent.addAll(favContentBox.get('favcontent'));
        });

        for (int i = 0; i < favTitle.length; i++) {
          counter.increaseNote();
          setState(() {
            favList.add(NoteBox(
                boxColor: (myAppColor.darkMode.value)
                    ? Colors.grey[800]
                    : const Color.fromARGB(255, 222, 222, 222),
                noteColor: (myAppColor.isBlack.value)
                    ? Colors.black
                    : myAppColor.appColor.value,
                date: favDate[i],
                title: favTitle[i],
                content: favContent[i]));
          });
        }  }
    } } }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String note = '';
  List<Widget> noteView = [];
  List<String> searchList = [];
  List<String> spaceList = [];
  List<bool> selectedNotes = [];
  List<int> indexOfSelectedNotes = [];
  bool isVisibleBottomSheet = false,
      isVisibleNote = false,
      isSelectedAll = false,
      isEdit = false,
      showEditMsg = false,
      isSearch = false,
      isFound = false,
      isSnackbarOpen = false;

  deSelectAllAndClose() {
    setState(() {
      for (int i = 0; i < selectedNotes.length; i++) {
        selectedNotes[i] = false;
      }
      isSnackbarOpen = false;
    });
    indexOfSelectedNotes.clear();
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  showMessage(msg) {
    Get.snackbar('', '',
        backgroundColor: (myAppColor.isBlack.value)
            ? Colors.black
            : myAppColor.appColor.value,
        duration: const Duration(seconds: 2),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        messageText: Text(msg,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: (appColorBox.get('color') == 'yellow' ||
                        appColorBox.get('color') == 'lime')
                    ? Colors.black
                    : Colors.white)),
        margin: const EdgeInsets.all(12),
        borderRadius: 12);
  }

  deleteSavedNote() {
    dateBox.put('date', dates);
    titleBox.put('title', titles);
    contentBox.put('content', contents);
    selectedNoteBox.put('selected', selectedNotes);
    favNoteBox.put('favourite', favNotes);
    favDateBox.put('favdate', favDate);
    favTitleBox.put('favtitle', favTitle);
    favContentBox.put('favcontent', favContent);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (isSnackbarOpen) {
            deSelectAllAndClose();
            return false;
          }
          return true;
        },
        child: Obx(
          () => Scaffold(
              key: scaffoldKey,
              backgroundColor:
                  (myAppColor.darkMode.value) ? Colors.grey[900] : Colors.white,
              appBar: AppBar(
                  foregroundColor: (myAppColor.darkMode.value)
                      ? Colors.white
                      : Colors.grey[900],
                  backgroundColor: (myAppColor.darkMode.value)
                      ? Colors.grey[900]
                      : Colors.white,
                  elevation: 0,
                  title: Container(
                    child: Row(children: [
                      Container(
                          margin: const EdgeInsets.only(left: 5),
                          width: 33,
                          height: 33,
                          child: Image.asset(
                            'images/calender.png',
                            fit: BoxFit.cover,
                          )),
                      Expanded(
                          child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 40,
                        width: 220,
                        child: TextField(
                            style: TextStyle(
                              color: (myAppColor.darkMode.value)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            onChanged: (data) {
                              searchList.clear();
                              for (String element in titles) {
                                if (titles[titles.indexOf(element)]
                                    .contains(' ')) {
                                  searchList
                                      .add(titles[titles.indexOf(element)]);
                                }
                              }

                              setState(() {
                                note = data;
                              });

                              note = note.toLowerCase();
                              for (String element in titles) {
                                titles[titles.indexOf(element)] =
                                    element.toLowerCase();
                              }
                              if (note.isEmpty) {
                                setState(() {
                                  isSearch = false;
                                  noteIndex = 0;
                                });
                              }
                              if (titles.contains(note)) {
                                setState(() {
                                  isSearch = true;
                                  noteIndex = titles.indexOf(note);
                                });
                              } else {
                                String foundNote = '';
                                for (int i = 0; i <= searchList.length; i++) {
                                  if (isFound) {
                                    setState(() {
                                      isSearch = true;
                                      noteIndex = titles.indexOf(foundNote);
                                      isFound = false;
                                    });
                                    break;
                                  } else {
                                    setState(() {
                                      isFound = false;
                                      spaceList.clear();
                                    });

                                    if (i < searchList.length) {
                                      setState(() {
                                        foundNote = searchList[i];
                                        spaceList = foundNote.split(' ');
                                      });
                                    }
                                  }

                                  for (int j = 0; j < spaceList.length; j++) {
                                    if (spaceList.contains(note)) {
                                      setState(() {
                                        foundNote = searchList[i];
                                        isFound = true;
                                      });
                                      break;
                                    }
                                  }
                                }
                              }
                            },
                            decoration: InputDecoration(
                                hintText: 'Search note',
                                enabled: true,
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: (myAppColor.darkMode.value)
                                        ? Colors.white
                                        : Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: (myAppColor.darkMode.value)
                                          ? Colors.white
                                          : Colors.grey,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: (myAppColor.darkMode.value)
                                      ? Colors.white
                                      : Colors.grey,
                                ))),
                      )),
                    ]),
                  )),
              // Menu of the app
              endDrawer: Drawer(
                backgroundColor: (myAppColor.darkMode.value)
                    ? Colors.grey[900]
                    : Colors.white,
                child: ListView(children: [
                  Container(
                      margin: const EdgeInsets.only(top: 40, bottom: 20),
                      child: CircleAvatar(
                        backgroundColor: (myAppColor.darkMode.value)
                            ? Colors.black26
                            : Color.fromARGB(255, 236, 236, 236),
                        radius: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/calender.png',
                              height: 100,
                              width: 100,
                            ),
                            Text('مفكرتي',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: (myAppColor.darkMode.value)
                                        ? Colors.grey[200]
                                        : Colors.grey[800]))
                          ],
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      width: double.infinity,
                      height: 4,
                      color: Colors.blueGrey.shade300),
                  ListTile(
                      onTap: () {
                        Get.back();
                        Get.to(FavouriteScreen());
                      },
                      trailing: Icon(Icons.favorite,
                          color: (myAppColor.darkMode.value)
                              ? Colors.grey[200]
                              : Colors.grey[800]),
                      title: Text('ملاحظاتي المفضلة',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: (myAppColor.darkMode.value)
                                  ? Colors.grey[200]
                                  : Colors.grey[800]))),
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      width: double.infinity,
                      height: 2,
                      color: Color.fromARGB(255, 222, 222, 222)),
                  ListTile(
                      onTap: () {
                        Get.back();
                        Get.to(SettingScreen());
                      },
                      trailing: Icon(Icons.settings,
                          color: (myAppColor.darkMode.value)
                              ? Colors.grey[200]
                              : Colors.grey[800]),
                      title: Text('إعدادات التطبيق',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: (myAppColor.darkMode.value)
                                  ? Colors.grey[200]
                                  : Colors.grey[800]))),
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      width: double.infinity,
                      height: 2,
                      color: Color.fromARGB(255, 222, 222, 222)),
                  ListTile(
                      onTap: () {
                        Get.back();
                        Get.to(AppInfoScreen());
                      },
                      trailing: Icon(Icons.info,
                          color: (myAppColor.darkMode.value)
                              ? Colors.grey[200]
                              : Colors.grey[800]),
                      title: Text('معلومات التطبيق',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: (myAppColor.darkMode.value)
                                  ? Colors.grey[200]
                                  : Colors.grey[800]))),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      width: double.infinity,
                      height: 2,
                      color: Color.fromARGB(255, 222, 222, 222)),
                ]),
              ),
              // Note adding button

              floatingActionButton: FloatingActionButton.extended(
                  backgroundColor: (myAppColor.isBlack.value)
                      ? Colors.black
                      : myAppColor.appColor.value,
                  elevation: 0,
                  label: (isEdit)
                      ? Icon(Icons.edit,
                          color: (appColorBox.get('color') == 'yellow' ||
                                  appColorBox.get('color') == 'lime')
                              ? Colors.black
                              : Colors.white)
                      : Icon(Icons.add,
                          color: (appColorBox.get('color') == 'yellow' ||
                                  appColorBox.get('color') == 'lime')
                              ? Colors.black
                              : Colors.white),
                  icon: (isEdit)
                      ? Text('تعديل ملاحظة',
                          style: TextStyle(
                              fontSize: 18,
                              color: (appColorBox.get('color') == 'yellow' ||
                                      appColorBox.get('color') == 'lime')
                                  ? Colors.black
                                  : Colors.white))
                      : Text('إضافة ملاحظة',
                          style:
                              TextStyle(fontSize: 18, color: (appColorBox.get('color') == 'yellow' || appColorBox.get('color') == 'lime') ? Colors.black : Colors.white)),
                  onPressed: () {
                    // Check if the bottom sheet is visible or not
                    if (isVisibleBottomSheet) {
                      // Check if all input fields are empty or not

                      if (dateController.text.isNotEmpty &&
                          titleController.text.isNotEmpty &&
                          contentController.text.isNotEmpty) {
                        if (dateController.text.codeUnits.first == 32 ||
                            titleController.text.codeUnits.first == 32 ||
                            contentController.text.codeUnits.first == 32) {
                          showMessage('يوجد فراغ في بداية الحقول');
                        } else {
                          // Edit the note
                          if (isEdit) {
                            // Get.back();

                            print('Note Title is : $noteTitle');
                            print('Note Content is : $noteContent');

                            if (favNotes[noteIndex]) {
                              int favIndex =
                                  favTitle.indexOf(titles[noteIndex]);
                              List<Widget> updatedNote = [];
                              setState(() {
                                favList.removeAt(favIndex);
                                favDate.removeAt(favIndex);
                                favTitle.removeAt(favIndex);
                                favContent.removeAt(favIndex);
                                updatedNote.add(NoteBox(
                                    boxColor: (myAppColor.darkMode.value)
                                        ? Colors.grey[800]
                                        : const Color.fromARGB(
                                            255, 222, 222, 222),
                                    noteColor: (myAppColor.isBlack.value)
                                        ? Colors.black
                                        : myAppColor.appColor.value,
                                    date: noteDate,
                                    title: noteTitle,
                                    content: noteContent));

                                favList.insert(favIndex, updatedNote.first);

                                favDate.insert(favIndex, noteDate);

                                favTitle.insert(favIndex, noteTitle);

                                favContent.insert(favIndex, noteContent);
                              });

                              favDateBox.put('favdate', favDate);
                              favTitleBox.put('favtitle', favTitle);
                              favContentBox.put('favcontent', favContent);
                            }

                            setState(() {
                              isVisibleNote = true;
                              noteView.removeAt(noteIndex);
                              dates.removeAt(noteIndex);
                              titles.removeAt(noteIndex);
                              contents.removeAt(noteIndex);

                              noteView.insert(
                                  noteIndex,
                                  NoteBox(
                                      boxColor: (myAppColor.darkMode.value)
                                          ? Colors.grey[800]
                                          : const Color.fromARGB(
                                              255, 222, 222, 222),
                                      noteColor: (myAppColor.isBlack.value)
                                          ? Colors.black
                                          : myAppColor.appColor.value,
                                      date: noteDate,
                                      title: noteTitle,
                                      content: noteContent));

                              dates.insert(noteIndex, noteDate);
                              titles.insert(noteIndex, noteTitle);
                              contents.insert(noteIndex, noteContent);

                              isEdit = false;
                              isVisibleBottomSheet = false;

                              // Make all text fields empty
                              dateController.text = '';
                              titleController.text = '';
                              contentController.text = '';
                              noteDate = '';
                              noteTitle = '';
                              noteContent = '';
                            });

                            dateBox.put('date', dates);
                            titleBox.put('title', titles);
                            contentBox.put('content', contents);
                          } else {
                            // Add a new note with it's date and content
                            ScaffoldMessenger.of(context).clearSnackBars();
                            setState(() {
                              isVisibleNote = true;
                              isVisibleBottomSheet = false;
                              selectedNotes.add(false);
                              favNotes.add(false);

                              noteView.add(NoteBox(
                                  boxColor: (myAppColor.darkMode.value)
                                      ? Colors.grey[800]
                                      : const Color.fromARGB(
                                          255, 222, 222, 222),
                                  noteColor: (myAppColor.isBlack.value)
                                      ? Colors.black
                                      : myAppColor.appColor.value,
                                  date: noteDate,
                                  title: noteTitle,
                                  content: noteContent));

                              dates.add(noteDate);
                              titles.add(noteTitle);
                              contents.add(noteContent);
                              // Make all text fields empty
                              dateController.text = '';
                              titleController.text = '';
                              contentController.text = '';
                              noteDate = '';
                              noteTitle = '';
                              noteContent = '';
                            });

                            dateBox.put('date', dates);
                            titleBox.put('title', titles);
                            contentBox.put('content', contents);
                            selectedNoteBox.put('selected', selectedNotes);
                            favNoteBox.put('favourite', favNotes);
                          }
                          // Close the bottom sheet
                          Get.back();
                          if (showEditMsg) {
                            showMessage('تم تعديل الملاحظة');
                          } else {
                            showMessage('تم إضافة ملاحظة جديدة');
                          }
                        }
                      } else {
                        showMessage('يجب إدخال البيانات في جميع الحقول');
                      }
                    } else {
                      // Show bottom sheet
                      deSelectAllAndClose();
                      setState(() {
                        isVisibleBottomSheet = true;
                        showEditMsg = false;
                      });

                      scaffoldKey.currentState!
                          .showBottomSheet((context) => NoteSheet(
                                context,
                                date: noteDate,
                                title: noteTitle,
                                content: noteContent,
                              ))
                          .closed
                          .then((value) {
                        setState(() {
                          isVisibleBottomSheet = false;
                          showEditMsg = false;
                        });
                      });
                    }
                  }),
              body: (isVisibleNote)
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 70),
                      child: ListView.builder(
                          itemCount: (isSearch) ? 1 : noteView.length,
                          itemBuilder: (context, index) {
                            if (isSearch) {
                              index = noteIndex;
                            }

                            if (noteView.isNotEmpty) {
                              noteView.removeAt(index);
                              noteView.insert(
                                  index,
                                  NoteBox(
                                      boxColor: (myAppColor.darkMode.value)
                                          ? Colors.grey[800]
                                          : Color.fromARGB(255, 222, 222, 222),
                                      noteColor: (myAppColor.isBlack.value)
                                          ? Colors.black
                                          : myAppColor.appColor.value,
                                      date: dates[index],
                                      title: titles[index],
                                      content: contents[index]));
                            }

                            return GestureDetector(
                                onLongPress: () {
                                  setState(() {
                                    isSnackbarOpen = true;
                                    selectedNotes[index] =
                                        !selectedNotes[index];
                                    isSelectedAll = false;

                                    if (selectedNotes[index]) {
                                      indexOfSelectedNotes.add(index);
                                      indexOfSelectedNotes
                                          .sort(((a, b) => a.compareTo(b)));
                                    } else {
                                      indexOfSelectedNotes.remove(index);
                                    }
                                  });
                                  print(
                                      'Index of selected notes : $indexOfSelectedNotes');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          duration: const Duration(hours: 4),
                                          backgroundColor: const Color.fromARGB(
                                              255, 222, 222, 222),
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      for (int i = 0;
                                                          i <
                                                              selectedNotes
                                                                  .length;
                                                          i++) {
                                                        if (selectedNotes[i]) {
                                                          continue;
                                                        }
                                                        selectedNotes[i] = true;
                                                        indexOfSelectedNotes
                                                            .add(i);
                                                      }
                                                      isSelectedAll = true;
                                                    });
                                                  },
                                                  child: TextIcon(
                                                    text: 'تحديد الكل',
                                                    icon: Icons
                                                        .playlist_add_check,
                                                  )),
                                              GestureDetector(
                                                  onTap: () {
                                                    if (isSelectedAll) {
                                                      counter
                                                          .removeAllFavouriteNotes();
                                                      setState(() {
                                                        selectedNotes.clear();
                                                        favNotes.clear();
                                                        indexOfSelectedNotes
                                                            .clear();
                                                        noteView.clear();

                                                        dates.clear();
                                                        titles.clear();
                                                        contents.clear();
                                                        favDate.clear();
                                                        favTitle.clear();
                                                        favContent.clear();
                                                        favList.clear();
                                                        isSelectedAll = false;
                                                      });

                                                      dateBox.delete('date');
                                                      titleBox.delete('title');
                                                      contentBox.delete('content');

                                                      favDateBox
                                                          .delete('favdate');

                                                      favTitleBox
                                                          .delete('favtitle');

                                                      favContentBox
                                                          .delete('favcontent');

                                                      selectedNoteBox
                                                          .delete('selected');
                                                      favNoteBox
                                                          .delete('favourite');
                                                    } else {
                                                      int numberOfSelectedNotes =
                                                          indexOfSelectedNotes
                                                              .length;

                                                      while (
                                                          numberOfSelectedNotes >
                                                              0) {
                                                        if (favNotes[
                                                            indexOfSelectedNotes
                                                                .last]) {
                                                          counter
                                                              .decreaseNote();
                                                          setState(() {
                                                            favList.removeAt(favContent
                                                                .indexOf(contents[
                                                                    indexOfSelectedNotes
                                                                        .last]));
                                                            favDate.remove(dates[
                                                                indexOfSelectedNotes
                                                                    .last]);
                                                            favTitle.remove(titles[
                                                                indexOfSelectedNotes
                                                                    .last]);
                                                            favContent.remove(
                                                                contents[
                                                                    indexOfSelectedNotes
                                                                        .last]);
                                                          });
                                                        }

                                                        setState(() {
                                                          isSearch = false;

                                                          noteView.removeAt(
                                                              indexOfSelectedNotes
                                                                  .last);

                                                          dates.removeAt(
                                                              indexOfSelectedNotes
                                                                  .last);

                                                          titles.removeAt(
                                                              indexOfSelectedNotes
                                                                  .last);

                                                          contents.removeAt(
                                                              indexOfSelectedNotes
                                                                  .last);

                                                          selectedNotes.removeAt(
                                                              indexOfSelectedNotes
                                                                  .last);

                                                          favNotes.removeAt(
                                                              indexOfSelectedNotes
                                                                  .last);

                                                          indexOfSelectedNotes
                                                              .removeLast();
                                                          numberOfSelectedNotes -=
                                                              1;
                                                        });
                                                      }
                                                      deleteSavedNote();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .clearSnackBars();
                                                    }

                                                    if (noteView.isEmpty) {
                                                      setState(() {
                                                        isVisibleNote = false;
                                                      });
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .clearSnackBars();
                                                    }
                                                  },
                                                  child: TextIcon(
                                                    text: 'حذف',
                                                    icon: Icons.delete,
                                                  )),

                                              GestureDetector(
                                                  onTap: () {
                                                    if (noteView.isNotEmpty) {
                                                      deSelectAllAndClose();
                                                    }
                                                  },
                                                  child: TextIcon(
                                                    text: 'إغلاق',
                                                    icon: Icons.close,
                                                  )),
                                            ],
                                          )));
                                },
                                // when a user taps on the note it will open in a new screen
                                onTap: () {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  setState(() {
                                    for (var note in selectedNotes) {
                                      selectedNotes[
                                          selectedNotes.indexOf(note)] = false;
                                    }
                                    indexOfSelectedNotes.clear();
                                  });
                                  Get.to(ContentScreen(
                                      id: index,
                                      date: dates[index],
                                      title: titles[index],
                                      content: contents[index],
                                      letter: contents[index][0],
                                      isFavourite: favNotes[index]));
                                },
                                child: Dismissible(
                                    key: UniqueKey(),
                                    onDismissed: (direction) {
                                      deSelectAllAndClose();
                                      setState(() {
                                        noteIndex = index;
                                        isEdit = true;
                                        showEditMsg = true;
                                        isVisibleBottomSheet = true;
                                        dateController.text = dates[index];
                                        titleController.text = titles[index];
                                        contentController.text =
                                            contents[index];
                                        noteDate = dates[index];
                                        noteTitle = titles[index];
                                        noteContent = contents[index];
                                      });

                                      scaffoldKey.currentState!
                                          .showBottomSheet(
                                              (context) => NoteSheet(
                                                    context,
                                                    date: noteDate,
                                                    title: noteTitle,
                                                    content: noteContent,
                                                  ))
                                          .closed
                                          .then((value) {
                                        setState(() {
                                          isEdit = false;
                                          showEditMsg = false;
                                          isVisibleBottomSheet = false;
                                          dateController.text = '';
                                          titleController.text = '';
                                          contentController.text = '';
                                          noteDate = '';
                                          noteTitle = '';
                                          noteContent = '';
                                        });
                                      });
                                    },
                                    background: Container(
                                        color: (myAppColor.isBlack.value)
                                            ? Colors.black
                                            : myAppColor.appColor.value,
                                        alignment: Alignment.centerLeft,
                                        child: Icon(
                                          Icons.edit,
                                          size: 30,
                                          color: (appColorBox.get('color') ==
                                                      'yellow' ||
                                                  appColorBox.get('color') ==
                                                      'lime')
                                              ? Colors.black
                                              : Colors.white,
                                        )),
                                    secondaryBackground: Container(
                                        color: (myAppColor.isBlack.value)
                                            ? Colors.black
                                            : myAppColor.appColor.value,
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.edit,
                                          size: 30,
                                          color: (appColorBox.get('color') ==
                                                      'yellow' ||
                                                  appColorBox.get('color') ==
                                                      'lime')
                                              ? Colors.black
                                              : Colors.white,
                                        )),
                                    child: Center(
                                        child: (selectedNotes[index])
                                            ? Stack(
                                                alignment: Alignment.bottomLeft,
                                                children: [
                                                    noteView[index],
                                                    const CircleAvatar(
                                                      radius: 15,
                                                      child: Icon(Icons.check),
                                                    )
                                                  ])
                                            : noteView[index])));
                          }))
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 200,
                            width: 200,
                            child: Image.asset(
                              'images/calender.png',
                              fit: BoxFit.cover,
                            )  ),
                          const Text('لا يوجد ملاحظة',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    )),
        ));
  } }
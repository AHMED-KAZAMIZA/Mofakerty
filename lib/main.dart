import 'package:flutter/material.dart';
import 'package:mofakerty/save_color.dart';
import 'package:mofakerty/screens/notes_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'note_counter.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.initFlutter();
  await Hive.openBox('DateBox');
  await Hive.openBox('TitleBox');
  await Hive.openBox('ContentBox');
  await Hive.openBox('FavDateBox');
  await Hive.openBox('FavTitleBox');
  await Hive.openBox('FavContentBox');
  await Hive.openBox('SelectedNoteBox');
  await Hive.openBox('FavouriteNoteBox');
  await Hive.openBox('AppColorBox');
  await Hive.openBox('DarkBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NoteCounter counter = Get.put(NoteCounter());
  final SaveColor myAppColor = Get.put(SaveColor());
  Map<int, Color> color = {
    50: const Color.fromRGBO(0, 0, 0, .1),
    100: const Color.fromRGBO(0, 0, 0, .2),
    200: const Color.fromRGBO(0, 0, 0, .3),
    300: const Color.fromRGBO(0, 0, 0, .4),
    400: const Color.fromRGBO(0, 0, 0, .5),
    500: const Color.fromRGBO(0, 0, 0, .6),
    600: const Color.fromRGBO(0, 0, 0, .7),
    700: const Color.fromRGBO(0, 0, 0, .8),
    800: const Color.fromRGBO(0, 0, 0, .9),
    900: const Color.fromRGBO(0, 0, 0, 1),
  };

  @override
  Widget build(BuildContext context) {
    MaterialColor blackColor = MaterialColor(0xFF000000, color);

    if (darkBox.isNotEmpty) {
      if (darkBox.get('darkMode')) {
        myAppColor.enableDarkMode();
      } else {
        myAppColor.disableDarkMode();
      }  }

    if (appColorBox.isNotEmpty) {
      myAppColor.saveColor();
    } else {
      myAppColor.redColor();
    }
    return Obx(() => GetMaterialApp(
          title: 'مفكرتي',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: (myAppColor.isBlack.value)
                ? blackColor
                : myAppColor.appColor.value,
          ),
          home: NotesScreen(),
        ));
  } }
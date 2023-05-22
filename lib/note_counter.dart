import 'package:get/get.dart';

class NoteCounter extends GetxController {
  var noteCount = 0.obs;

  removeAllFavouriteNotes() {
    noteCount.value = 0;
  }

  increaseNote() {
    noteCount++;
  }

  decreaseNote() {
    noteCount--;
  }
}
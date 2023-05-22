import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:mofakerty/note_counter.dart';
import 'package:get/get.dart';

final NoteCounter counter = Get.find();
var favDateBox = Hive.box('FavDateBox');
var favTitleBox = Hive.box('FavTitleBox');
var favContentBox = Hive.box('FavContentBox');
var favNoteBox = Hive.box('FavouriteNoteBox');
int noteIndex = 0;

bool favourite = true;
bool sameNote = true;
List<String> dates = [];
List<String> titles = [];
List<String> contents = [];
List<Widget> favList = [];
List<bool> favNotes = [];
List<String> favDate = [];
List<String> favTitle = [];
List<String> favContent = [];


import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrf/controllers/home_controller.dart';
import 'package:qrf/model/quran/ayat_list.dart';
import 'package:qrf/model/user/user..dart';
import 'package:qrf/providers/bookmark_note/bookmark_note_provider.dart';
import 'package:qrf/providers/quran/ayat_provider.dart';
import 'package:qrf/utils/session.dart';

import '../model/quran/surah_list.dart';
class TestController extends GetxController
{
  var argdata=Get.arguments;


  var surahId;

  var ayatnum;

  @override
  void onInit() {
     surahId=argdata[0]['surah_id'];
     ayatnum = argdata[1]['selected_ayatnumber'];
  }

  
}
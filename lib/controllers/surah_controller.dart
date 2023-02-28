import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/controllers/database/quran_database.dart';
import 'package:qrf/model/quran/surah_list.dart';
import 'package:qrf/providers/quran/surah_provider.dart';
import 'package:sqflite/sqflite.dart';

class SurahController extends GetxController {
  var isLoading = true.obs;
  var surahList = List<Surah>.empty(growable: true).obs;


  TextEditingController suraNameController = TextEditingController();
  TextEditingController ayatNumberController = TextEditingController();
  
  @override
  void onInit() {
    getSurahList();
    super.onInit();
  }


  @override
  void onClose() {
    super.onClose();
  }

  void getSurahList() {
    //toast("before insering "+surahList.length.toString());

    SurahProvider().getAllSurah().then((value) {
      if (value != null) {
        Iterable? jsonListData = jsonDecode(value);

        jsonListData?.forEach((surah) {
          //DBHelper dbHelper;
          surahList.add(Surah.fromJson(surah));

        });
      }


      isLoading(false);
    });
  }


}

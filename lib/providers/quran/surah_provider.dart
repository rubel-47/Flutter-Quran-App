import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/model/quran/surah_list.dart';
import 'package:qrf/utils/constant.dart';

import '../../controllers/database/quran_database.dart';

class SurahProvider {
  Future<dynamic> getAllSurah() async {
    var client = http.Client();

    try {
      var response = await client.get(
        Uri.parse("${BASE_URL + endpoint_surah_list}"),
        headers: {"Accept": "application/json", "$API_KEY": "$API_SECRET"},
      );

    //print("${BASE_URL + endpoint_surah_list}");
      var jsonData=jsonDecode(response.body);
      //toast(jsonData);
      ///toast(jsonData.toString());


    if (response.statusCode == 200) {

      //DBHelper? dbHelper;
      //dbHelper?.createSurah(Surah.fromJson(jsonData));


       return response.body;

      }

      else {
        return Future.error("Something went wrong");
      }
    } catch (Exception) {
      return Exception.toString();
    }
  }




}


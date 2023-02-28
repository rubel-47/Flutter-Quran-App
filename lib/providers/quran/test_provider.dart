


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

import '../../controllers/database/quran_database.dart';
import '../../model/quran/surah_list.dart';
import '../../model/quran/test_model.dart';
import '../../utils/constant.dart';
class SurahApiProvider {
  Future<List<Surah>> getallSurah() async {
    //toast("I am from test_provider");
    var client = http.Client();
    Iterable surahList;
    var response = await client.get(
      Uri.parse("${BASE_URL + endpoint_surah_list}"),
      headers: {"Accept": "application/json", "$API_KEY": "$API_SECRET"},
    );
    var jsonString=(response.body);
    surahList=jsonDecode(jsonString);
    //print(response.body.toString());
    //print(response.body.toString()+"online");


    // toast(response.body.toString());
    return  surahList.map((surah) =>Surah.fromJson(surah) ).toList();
  }
}
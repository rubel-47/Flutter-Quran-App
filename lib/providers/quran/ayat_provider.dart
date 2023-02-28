import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qrf/model/quran/modified_ayat_list.dart';
import 'package:qrf/utils/constant.dart';

import '../../model/quran/ayat_list.dart';
const BASE_URL = 'http://139.180.156.187:92/api/quran/';
const API_KEY = 'x-api-key';
const API_SECRET = '3R5TWxA0GAn04EQ42haCnYtFxeRlV08yMi5o';
const endpoint_surah_list = 'sura';
const endpoint_ayat = 'sura/ayats?sura_id=';
const endpoint_allayat='ayats';
const audio_base_url='http://139.180.156.187:92/upload/ayataudio/';
class AyatProvider{

  Future<dynamic> getAyatBySurah(var surahId) async {
    var client = http.Client();


    try {
      var response = await client.get(
        Uri.parse(
            "${BASE_URL + endpoint_ayat}$surahId"),
        headers: {"Accept": "application/json", "$API_KEY": "$API_SECRET"},
      );

      if (response.statusCode == 200) {
        //print(response.body.toString());
        return response.body;
      } else {
        return Future.error("Something went wrong");
      }
    } catch (Exception) {
      return Exception.toString();
    }
  }
  Future<List<Ayat>> getAllAyat() async {
    var client = http.Client();
    Iterable ayatList;

    try {
      var response = await client.get(
        Uri.parse(
            "${BASE_URL + endpoint_allayat}"),
        headers: {"Accept": "application/json", "$API_KEY": "$API_SECRET"},
      );

      if (response.statusCode == 200) {
        //  debugPrint(response.body.toString(),wrapWidth: 1000);
        var jsonString=(response.body);
        ayatList=jsonDecode(jsonString);

        // toast(response.body.toString());
        return  ayatList.map((ayat) =>Ayat.fromJson(ayat) ).toList();

        // return response.body;
      } else {
        return Future.error("Something went wrong");
      }
    } catch (Exception) {
     return Future.error("Something went wrong");
    }
  }
  //********************************************



}
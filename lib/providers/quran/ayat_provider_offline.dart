import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/utils/constant.dart';

import '../../model/quran/ayat_list.dart';

class AyatProviderOffline{

  Future<dynamic> getAyatBySurahoffline(var surahId) async {
    var client = http.Client();
    Iterable ayatList;


    try {
      var response = await client.get(
        Uri.parse(
            "${BASE_URL + endpoint_ayat}$surahId"),
        headers: {"Accept": "application/json", "$API_KEY": "$API_SECRET"},
      );

      if (response.statusCode == 200) {
        //toast(response.statusCode.toString());
        var jsonString=(response.body);
        ayatList=jsonDecode(jsonString);
       // print(response.body.toString());
        //debugPrint(response.body.toString(),wrapWidth: 1000);

        // toast(response.body.toString());
        return  ayatList.map((ayat) =>Ayat.fromJson(ayat) ).toList();
      } else {
        return Future.error("Something went wrong");
      }
    } catch (Exception) {
      return Exception.toString();
    }
  }
}
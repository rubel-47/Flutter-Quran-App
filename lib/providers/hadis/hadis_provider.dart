import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:qrf/model/hadis/hadis_list.dart';
import 'package:qrf/model/hadis/modified_hadis_list.dart';
import 'package:qrf/utils/constant.dart';

class HadisProvider {
  Future<dynamic> getAllHadis() async {
    var client = http.Client();

    try {
      var response = await client.get(
        Uri.parse("${BASE_URL + endpoint_hadis}"),
        headers: {"Accept": "application/json", "$API_KEY": "$API_SECRET"},
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return Future.error("Something went wrong");
      }
    } catch (Exception) {
      return Exception.toString();
    }
  }
  Future<List<Hadis>> getallHadis() async {
    var client = http.Client();
    Iterable hadisList;

    try {
      var response = await client.get(
        Uri.parse(
            "${BASE_URL + endpoint_hadis}"),
        headers: {"Accept": "application/json", "$API_KEY": "$API_SECRET"},
      );

      if (response.statusCode == 200) {

        var jsonString=(response.body);
        //debugPrint(response.body,wrapWidth: 2000);
        hadisList=jsonDecode(jsonString);

        // toast(response.body.toString());
        return  hadisList.map((hadis) =>Hadis.fromJson(hadis) ).toList();

        // return response.body;
      } else {
        return Future.error("Something went wrong");
      }
    } catch (Exception) {
      return Future.error("Something went wrong");
    }
  }

}

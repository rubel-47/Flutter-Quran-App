import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrf/model/hadis/hadis_list.dart';
import 'package:qrf/providers/hadis/hadis_provider.dart';

class HadisController extends GetxController {
  var isLoading = true.obs;
  var hadisList = List<Hadis>.empty(growable: true).obs;

  TextEditingController hadisNameController = TextEditingController();
  TextEditingController hadisNumberController = TextEditingController();

  @override
  void onInit() {
    getHadisList();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getHadisList() {
    HadisProvider().getAllHadis().then((value) {
      if (value != null) {
        Iterable? jsonListData = jsonDecode(value);
        jsonListData?.forEach((hadis) {
          hadisList.add(Hadis.fromJson(hadis));
        });
      }
      isLoading(false);
    });
  }
}

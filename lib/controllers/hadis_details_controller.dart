import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrf/model/hadis/hadis_details.dart';
import 'package:qrf/providers/hadis/hadis_details_provider.dart';

class HadisDetailsController extends GetxController {
  var isLoading = true.obs;
  var hadisDetails = HadisDetails().obs;
  var argData = Get.arguments;

  TextEditingController hadisNameController = TextEditingController();
  TextEditingController hadisNumberController = TextEditingController();

  @override
  void onInit() {
    getHadisDetails(argData[0]['hadis_id']);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getHadisDetails(int hadisId) {
    HadisDetailsProvider().getHadisDetailsById(hadisId).then((value) {
      if (value != null) {
        var hadis = jsonDecode(value);

        hadisDetails.value = HadisDetails.fromJson(hadis);
      }
      isLoading(false);
    });
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrf/model/paper/research_paper_details.dart';
import 'package:qrf/providers/paper/paper_details_provider.dart';

class PaperDetailsController extends GetxController {
  var isLoading = true.obs;
  var paperDetails = PaperDetails().obs;
  var argData = Get.arguments;

  var isPressed = false.obs;
  

  TextEditingController suraNameController = TextEditingController();
  TextEditingController ayatNumberController = TextEditingController();

  @override
  void onInit() {
    
    getPaperDetails(argData[0]['paper_id']);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getPaperDetails(int paperId) {
    PaperDetailsProvider().getPaperDetailsById(paperId).then((value) {
      if (value != null) {
        var paper = jsonDecode(value);

        paperDetails.value = PaperDetails.fromJson(paper);
      }
      isLoading(false);
    });
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrf/model/paper/research_paper_list.dart';
import 'package:qrf/providers/paper/paper_provider.dart';

class PaperController extends GetxController {
  var isLoading = true.obs;
  var paperList = List<Paper>.empty(growable: true).obs;

  TextEditingController suraNameController = TextEditingController();
  TextEditingController ayatNumberController = TextEditingController();

  @override
  void onInit() {
    getPaperList();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getPaperList() {
    PaperProvider().getAllPaper().then((value) {
      /* print(value); */
      if (value != null) {
        Iterable? jsonListData = jsonDecode(value);
        jsonListData?.forEach((paper) {
          paperList.add(Paper.fromJson(paper));
        });
      }
      isLoading(false);
    });
  }
}

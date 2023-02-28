import 'dart:convert';

import 'package:get/get.dart';
import 'package:qrf/model/paper/research_paper_details.dart';
import 'package:qrf/providers/paper/paper_search_provider.dart';

class PaperSearchTagController extends GetxController {
  var isLoading = true.obs;
  var paperDetailsList = List<PaperDetails>.empty(growable: true).obs;
  var argData = Get.arguments;

  @override
  void onInit() {
    searchPaper(argData[0]['keyword']);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void searchPaper(String keyword) {
    PaperSearchProvider().getPaperByTag(keyword).then((value) {
      if (value != null) {
        Iterable? jsonListData = jsonDecode(value);
        jsonListData?.forEach((paper) {
          paperDetailsList.add(PaperDetails.fromJson(paper));
        });
      }
      isLoading(false);
    });
  }
}

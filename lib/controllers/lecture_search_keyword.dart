import 'dart:convert';

import 'package:get/get.dart';
import 'package:qrf/model/lecture/lecture_details.dart';
import 'package:qrf/providers/lecture/lecture_search_provider.dart';

class LectureSearchKeywordController extends GetxController {
  var isLoading = true.obs;
  var lectureDetailsList = List<LectureDetails>.empty(growable: true).obs;
  var argData = Get.arguments;

  @override
  void onInit() {
    searchLecture(argData[0]['keyword']);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void searchLecture(String keyword) {
    LectureSearchProvider().getLectureByKeyword(keyword).then((value) {
      if (value != null) {
        Iterable? jsonListData = jsonDecode(value);
        jsonListData?.forEach((paper) {
          lectureDetailsList.add(LectureDetails.fromJson(paper));
        });
      }
      isLoading(false);
    });
  }
}

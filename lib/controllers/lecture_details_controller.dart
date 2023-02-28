import 'dart:convert';

import 'package:get/get.dart';
import 'package:qrf/model/lecture/lecture_details.dart';
import 'package:qrf/providers/lecture/lecture_details_provider.dart';

class LectureDetailsController extends GetxController {
  var isLoading = true.obs;
  var lectureDetails = List<LectureDetails>.empty(growable: true).obs;
  var argData = Get.arguments;

  @override
  void onInit() {
    getLectureDetails(argData[0]['lecture_id']);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getLectureDetails(int lectureId) {
    LectureDetailsProvider().getLectureDetailsById(lectureId).then((value) {
      if (value != null) {
        Iterable? jsonListData = jsonDecode(value);
        jsonListData?.forEach((lecture) {
          lectureDetails.add(LectureDetails.fromJson(lecture));
        });
      }
      isLoading(false);
    });
  }
}

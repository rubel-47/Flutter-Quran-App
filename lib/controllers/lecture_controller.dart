import 'dart:convert';

import 'package:get/get.dart';
import 'package:qrf/model/lecture/lecture_list.dart';
import 'package:qrf/providers/lecture/lecture_provider.dart';

class LectureController extends GetxController {
  var isLoading = true.obs;
  var lectureList = List<Lecture>.empty(growable: true).obs;

  @override
  void onInit() {
    getLectureList();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getLectureList() {
    LectureProvider().getAllLecture().then((value) {
      if (value != null) {
        Iterable? jsonListData = jsonDecode(value);
        jsonListData?.forEach((lecture) {
          lectureList.add(Lecture.fromJson(lecture));
        });
      }
      isLoading(false);
    });
  }
}

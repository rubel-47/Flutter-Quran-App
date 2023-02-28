import 'dart:convert';

import 'package:get/get.dart';
import 'package:qrf/model/tv/qrf_tv.dart';
import 'package:qrf/providers/tv/qrf_tv_provider.dart';

class QrfTvCatController extends GetxController {
  var isLoading = true.obs;
  var tvList = List<QrfTv>.empty(growable: true).obs;
  var arg = Get.arguments;
  var title;

  @override
  void onInit() {
    title = arg[0]['title'];
    getCatTvList(arg[1]['cat_id']);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getCatTvList(String catId) {
    TvProvider().getQrvTvByCategory(catId).then((value) {
      /* print(value); */
      if (value != null) {
        Iterable? jsonListData = jsonDecode(value);
        jsonListData?.forEach((lecture) {
          tvList.add(QrfTv.fromJson(lecture));
        });
      }
      isLoading(false);
    });
  }
}

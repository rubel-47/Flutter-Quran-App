import 'dart:convert';

import 'package:get/get.dart';
import 'package:qrf/model/others/category.dart';
import 'package:qrf/model/tv/qrf_tv.dart';
import 'package:qrf/providers/other/category_provider.dart';
import 'package:qrf/providers/tv/qrf_tv_provider.dart';
//tempppp

class QrfTvController extends GetxController {
  var isLoading = true.obs;
  var isLoadingCat = true.obs;
  var tvList = List<QrfTv>.empty(growable: true).obs;
  var categoryList = List<Category>.empty(growable: true).obs;

  var isCategoryVisible = true.obs;

  @override
  void onInit() {
    getCategoryList();
    getTvList();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setCategoryShowHide() {
    if (isCategoryVisible.value) {
      isCategoryVisible(false);
    } else {
      isCategoryVisible(true);
    }
  }

  void getCategoryList() {
    CategoryProvider().getAllCategory().then((value) {
      /* print(value); */
      if (value != null) {
        Iterable? jsonListData = jsonDecode(value);
        jsonListData?.forEach((category) {
          categoryList.add(Category.fromJson(category));
        });
      }
      isLoadingCat(false);
    });
  }

  void getTvList() {
    TvProvider().getAllQrfTv().then((value) {
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

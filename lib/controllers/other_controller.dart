import 'dart:convert';

import 'package:get/get.dart';
import 'package:qrf/model/lecture/lecture_list.dart';
import 'package:qrf/model/others/category.dart';
import 'package:qrf/model/others/tag.dart';
import 'package:qrf/providers/lecture/lecture_provider.dart';
import 'package:qrf/providers/other/category_provider.dart';
import 'package:qrf/providers/other/tag_provider.dart';

class CategoryController extends GetxController {
  var isLoading = true.obs;
  var categoryList = List<Category>.empty(growable: true).obs;
  var tagList = List<Tag>.empty(growable: true).obs;

  @override
  void onInit() {
    getCategoryList();
    getTagList();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getCategoryList() async{
   await CategoryProvider().getAllCategory().then((value) {
      if (value != null) {
        Iterable? jsonListData = jsonDecode(value);
        jsonListData?.forEach((lecture) {
          categoryList.add(Category.fromJson(lecture));
        });
      }
      isLoading(false);
    });
  }

  void getTagList() async {
    await TagProvider().getAllTag().then((value) {
      if (value != null) {
        Iterable? jsonListData = jsonDecode(value);
        jsonListData?.forEach((lecture) {
          tagList.add(Tag.fromJson(lecture));
        });
      }
      isLoading(false);
    });
  }
}

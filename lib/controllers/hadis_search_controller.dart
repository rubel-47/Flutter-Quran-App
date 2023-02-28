import 'dart:convert';

import 'package:get/get.dart';
import 'package:qrf/model/hadis/hadis_details.dart';
import 'package:qrf/providers/hadis/hadis_search_provider.dart';

class HadisSearchController extends GetxController {
  var isLoading = true.obs;
  var hadisList = List<HadisDetails>.empty(growable: true).obs;
  var argData = Get.arguments;

  @override
  void onInit() {
    searchHadis(argData[0]['keyword']);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void searchHadis(String keyword) {
    HadisSearchProvider().getHadisByKeyword(keyword).then((value) {
      if (value != null) {
        Iterable? jsonListData = jsonDecode(value);
        jsonListData?.forEach((hadis) {
          hadisList.add(HadisDetails.fromJson(hadis));
        });
      }
      isLoading(false);
    });
  }
}

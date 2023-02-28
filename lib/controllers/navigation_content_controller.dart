import 'package:get/get.dart';
import 'package:qrf/model/navigation/navigation_pages.dart';

class NavigationContentController extends GetxController {
  var isLoading = true.obs;
  var navigationData = Pages();
  var argData = Get.arguments;

  @override
  void onInit() {
    print(argData[0]['data']);
    navigationData = Pages.fromJson(argData[0]['data']);
    print(navigationData.menuName);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

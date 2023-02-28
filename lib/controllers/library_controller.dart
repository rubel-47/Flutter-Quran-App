import 'package:get/get.dart';

class LibraryController extends GetxController {
  var argData = Get.arguments;
  var url = "";

  @override
  void onInit() {
    url = argData[0]['url'];
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

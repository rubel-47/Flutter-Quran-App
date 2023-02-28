import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class webviewController extends GetxController {
  var arguments = Get.arguments;

  var url = "".obs;

  @override
  void onInit() {
    url.value = arguments[0]['url'];
    
    super.onInit();
  }
}

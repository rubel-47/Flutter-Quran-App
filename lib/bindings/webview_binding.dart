import 'package:get/instance_manager.dart';
import 'package:qrf/controllers/webview_controller.dart';

class WebviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<webviewController>(() => webviewController());
  }
}

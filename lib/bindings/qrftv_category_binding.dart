import 'package:get/instance_manager.dart';
import 'package:qrf/controllers/qrftv_category_controller.dart';

class QrftvCatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrfTvCatController>(() => QrfTvCatController());
  }
}

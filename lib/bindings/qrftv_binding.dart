import 'package:get/instance_manager.dart';
import 'package:qrf/controllers/qrv_tv_controller.dart';

class QrftvBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrfTvController>(() => QrfTvController());
  }
}

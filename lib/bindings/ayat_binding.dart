import 'package:get/instance_manager.dart';
import 'package:qrf/controllers/ayat_controller.dart';

class AyatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AyatController>(() => AyatController());
  }
}

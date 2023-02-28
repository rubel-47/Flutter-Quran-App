import 'package:get/instance_manager.dart';
import 'package:qrf/controllers/hadis_controller.dart';

class HadisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HadisController>(() => HadisController());
  }
}

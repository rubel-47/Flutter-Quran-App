import 'package:get/instance_manager.dart';
import 'package:qrf/controllers/hadis_type_controller.dart';

class HadisTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HadisTypeController>(() => HadisTypeController());
  }
}

import 'package:get/instance_manager.dart';
import 'package:qrf/controllers/hadis_details_controller.dart';

class HadisDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HadisDetailsController>(() => HadisDetailsController());
  }
}

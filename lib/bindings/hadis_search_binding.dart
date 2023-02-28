import 'package:get/instance_manager.dart';
import 'package:qrf/controllers/hadis_search_controller.dart';

class HadisSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HadisSearchController>(() => HadisSearchController());
  }
}

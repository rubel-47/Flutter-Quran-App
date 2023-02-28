import 'package:get/instance_manager.dart';
import 'package:qrf/controllers/ayat_search_controller.dart';

class AyatSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AyatSearchController>(() => AyatSearchController());
  }
}

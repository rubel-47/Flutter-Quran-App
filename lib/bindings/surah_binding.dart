import 'package:get/instance_manager.dart';
import 'package:qrf/controllers/surah_controller.dart';

class SurahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurahController>(() => SurahController());
  }
}

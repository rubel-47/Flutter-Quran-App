import 'package:get/instance_manager.dart';
import 'package:qrf/controllers/ayat_controller.dart';
import 'package:qrf/controllers/test_controller.dart';

class TestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestController>(() => TestController());
  }
}
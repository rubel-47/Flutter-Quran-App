import 'package:get/instance_manager.dart';
import 'package:qrf/controllers/paper_controller.dart';

class PaperBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaperController>(() => PaperController());
  }
}

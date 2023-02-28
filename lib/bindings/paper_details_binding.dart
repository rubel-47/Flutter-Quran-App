import 'package:get/instance_manager.dart';
import 'package:qrf/controllers/paper_details_controller.dart';

class PaperDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaperDetailsController>(() => PaperDetailsController());
  }
}

import 'package:get/instance_manager.dart';
import 'package:qrf/controllers/lecture_details_controller.dart';

class LectureDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LectureDetailsController>(() => LectureDetailsController());
  }
}

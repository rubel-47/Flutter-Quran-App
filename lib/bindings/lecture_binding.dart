import 'package:get/instance_manager.dart';
import 'package:qrf/controllers/lecture_controller.dart';

class LectureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LectureController>(() => LectureController());
  }
}

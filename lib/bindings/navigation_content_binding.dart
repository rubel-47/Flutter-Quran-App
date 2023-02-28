import 'package:get/instance_manager.dart';
import 'package:qrf/controllers/navigation_content_controller.dart';

class NavigationContentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationContentController>(() => NavigationContentController());
  }
}

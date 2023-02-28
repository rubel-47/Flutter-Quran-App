import 'package:get/instance_manager.dart';
import 'package:qrf/controllers/user_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
  }
}

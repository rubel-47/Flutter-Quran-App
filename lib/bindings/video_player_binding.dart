import 'package:get/instance_manager.dart';
import 'package:qrf/controllers/video_player_controller.dart';

class VideoPlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoPlayerController>(() => VideoPlayerController());
  }
}

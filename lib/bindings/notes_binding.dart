import 'package:get/instance_manager.dart';
import 'package:qrf/controllers/bookmark_note_controller.dart';

class NotesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookmarkController>(() => BookmarkController());
  }
}

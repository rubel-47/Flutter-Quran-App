import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrf/model/user/user..dart';
import 'package:qrf/routes/app_pages.dart';
import 'package:qrf/utils/session.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerController extends GetxController {
  var isLoading = true.obs;

  SessionManager prefs = SessionManager();
  UserData userData = UserData();

  bool isLogin = false;

  var args = Get.arguments;
  var videoTitle = "";
  var videoId = "";

  late YoutubePlayerController controller;
  late TextEditingController seekToController;

  late PlayerState playerState;
  late YoutubeMetaData videoMetaData;
  double volume = 100;
  bool muted = false;
  bool isPlayerReady = false;

  /* Getting login user info */
  _getUserInfo() async {
    userData = await prefs.getUserInfo();
  }

  void checkLogin() async {
    isLogin = await prefs.getIsLogin();
    if (isLogin) {
      _getUserInfo();
    } else {
      Get.toNamed(AppPages.getLoginRoute());
    }
  }

  @override
  void onInit() {
    videoTitle = args[0]['video_title'];
    videoId = args[1]['video_id'];
    // videoId = 'nPt8bK2gbaU';

    controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);

    seekToController = TextEditingController();
    videoMetaData = const YoutubeMetaData();
    playerState = PlayerState.unknown;

    super.onInit();
  }

  void listener() {
    if (isPlayerReady && !controller.value.isFullScreen) {
      playerState = controller.value.playerState;
      videoMetaData = controller.metadata;
      update();
    }
  }

  void playPauseVideo() {
    if (isPlayerReady) {
      controller.value.isPlaying ? controller.pause() : controller.play();
      update();
    }
  }

  void muteUnmuteVideo() {
    if (isPlayerReady) {
      muted ? controller.unMute() : controller.mute();
      muted = !muted;
      update();
    }
  }

  @override
  void onClose() {
    controller.dispose();

    seekToController.dispose();
    super.onClose();
  }
}

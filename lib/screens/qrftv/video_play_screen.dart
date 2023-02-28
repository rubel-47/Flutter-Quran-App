import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/controllers/video_player_controller.dart';
import 'package:qrf/utils/color.dart';
import 'package:qrf/utils/widgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends GetView<VideoPlayerController> {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  /* Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey[700]!;
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return Colors.blueAccent;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.yellow;
      case PlayerState.cued:
        return Colors.blue[900]!;
      default:
        return Colors.blue;
    }
  } */

  /* Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  } */

  Widget get _space => const SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoPlayerController>(builder: (controller) {
      return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller.controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          topActions: <Widget>[
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                controller.controller.metadata.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 25.0,
              ),
              onPressed: () {
                log('Settings Tapped!');
              },
            ),
          ],
          onReady: () {
            controller.isPlayerReady = true;
          },
          onEnded: (data) {
            toast('video ended');
          },
        ),
        builder: (context, player) => Scaffold(
          backgroundColor: appBgColor,
          appBar: CustomAppBar(title: '${controller.videoTitle}', height: 80.0),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/app_bg.png'),
                      fit: BoxFit.cover),
                ),
              ),
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  /* Container(
                    height: 60.0,
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 40.0, right: 20.0),
                              child: Text(
                                '${controller.videoTitle}'.toUpperCase(),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  20.height, */
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: player,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        /* _space,
                        _text('Title', controller.videoMetaData.title),
                        _space,
                        _text('Channel', controller.videoMetaData.author),
                        _space,
                        _text('Video Id', controller.videoMetaData.videoId),
                        _space,
                        Row(
                          children: [
                            _text(
                              'Playback Quality',
                              controller.controller.value.playbackQuality ?? '',
                            ),
                            const Spacer(),
                            _text(
                              'Playback Rate',
                              '${controller.controller.value.playbackRate}x  ',
                            ),
                          ],
                        ), */
                        _space,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                icon: const Icon(Icons.skip_previous),
                                onPressed: () {}),
                            IconButton(
                                icon: Icon(
                                  controller.controller.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                ),
                                onPressed: () {
                                  controller.playPauseVideo();
                                }),
                            IconButton(
                                icon: Icon(controller.muted
                                    ? Icons.volume_off
                                    : Icons.volume_up),
                                onPressed: () {
                                  controller.muteUnmuteVideo();
                                }),
                            FullScreenButton(
                              controller: controller.controller,
                              color: Colors.blueAccent,
                            ),
                            IconButton(
                                icon: const Icon(Icons.skip_next),
                                onPressed: () {}),
                          ],
                        ),
                        _space,
                        Row(
                          children: <Widget>[
                            const Text(
                              "Volume",
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                            Expanded(
                              child: Slider(
                                inactiveColor: Colors.transparent,
                                value: controller.volume,
                                min: 0.0,
                                max: 100.0,
                                divisions: 10,
                                label: '${(controller.volume).round()}',
                                onChanged: controller.isPlayerReady
                                    ? (value) {
                                        controller.volume = value;

                                        controller.controller.setVolume(
                                            controller.volume.round());
                                      }
                                    : null,
                              ),
                            ),
                          ],
                        ),
                        _space,
                        /* AnimatedContainer(
                          duration: const Duration(milliseconds: 800),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: _getStateColor(controller.playerState),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            controller.playerState.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ), */
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

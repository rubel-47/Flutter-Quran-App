import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrf/model/quran/ayat_list.dart';
import 'package:qrf/model/user/user..dart';
import 'package:qrf/providers/bookmark_note/bookmark_note_provider.dart';
import 'package:qrf/providers/quran/ayat_search_provider.dart';
import 'package:qrf/utils/session.dart';

class AyatSearchController extends GetxController {
  var isLoading = true.obs;
  var ayatList = List<Ayat>.empty(growable: true).obs;
  var argData = Get.arguments;

  TextEditingController noteController = TextEditingController();

  var ayatPos = 0.obs;
  var isVisiblePlayBg = false;

  var isPlayingAudio = false;
  var playPauseIcon = 'assets/images/player_play_icon.png';
  var playIcon = 'assets/images/player_play_icon.png';
  var pauseIcon = 'assets/images/player_pause_icon.png';

  late Duration totalDuration;
  late Duration position;
  late String audioState;

  AudioPlayer audioPlayer = AudioPlayer();

  AudioCache audioCache = AudioCache();

  var isPlayerReadyToPlay = false;
  var isDownloadingstart = false;
  String? localFilePath;

  SessionManager prefs = SessionManager();
  UserData userData = UserData();

  bool isLogin = false;

  void checkLogin() async {
    isLogin = await prefs.getIsLogin();
    if (isLogin) {
      _getUserInfo();
    }
  }

  /* Getting login user info */
  _getUserInfo() async {
    userData = await prefs.getUserInfo();
  }

  @override
  void onInit() {
    searchAyat(argData[0]['keyword']);
    initAudio();
    checkLogin();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void searchAyat(String keyword) {
    AyatSearchProvider().getAyatByKeyword(keyword).then((value) {
      if (value != null) {
        Iterable? jsonListData = jsonDecode(value);
        jsonListData?.forEach((ayat) {
          ayatList.add(Ayat.fromJson(ayat));
        });
      }
      isLoading(false);
    });
  }

  void showMoreButton(int? ayatId) {
    ayatList.forEach((element) {
      element.moreButton = false;
    });
    int position = ayatList.indexWhere((element) => element.id == ayatId);
    ayatList[position].moreButton = true;
    update();
  }

  void hideMoreButton(int? ayatId) {
    int position = ayatList.indexWhere((element) => element.id == ayatId);
    ayatList[position].moreButton = false;
    update();
  }

  void setSelectedTafsirIndex(int index) {
    ayatPos.value = index;
    update();
  }

  void setPlayBgshowHide(bool type) {
    this.isVisiblePlayBg = type;

    isDownloadingstart = false;
    audioPlayer.release();
    this.isPlayingAudio = false;
    this.playPauseIcon = playIcon;
    this.isPlayerReadyToPlay = false;
    
    update();
  }

  void setDownloadLoading() {
    this.isDownloadingstart = true;
    update();
  }

  initAudio() {
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      totalDuration = updatedDuration;
      update();
    });

    audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
      position = updatedPosition;
      update();
    });

    audioPlayer.onPlayerCompletion.listen((event) {
      position = Duration(seconds: 0);
      this.isPlayingAudio = false;
      this.playPauseIcon = playIcon;
    });

    audioPlayer.onPlayerStateChanged.listen((playerState) {
      if (playerState == PlayerState.STOPPED) {
        audioState = "Stopped";
        this.isPlayingAudio = false;
        this.playPauseIcon = playIcon;
      }
      ;

      if (playerState == PlayerState.PLAYING) {
        audioState = "Playing";
        this.isPlayingAudio = true;
        this.playPauseIcon = pauseIcon;
      }
      ;
      if (playerState == PlayerState.PAUSED) {
        audioState = "Paused";
        this.isPlayingAudio = false;
        this.playPauseIcon = playIcon;
      }
      ;

      audioPlayer.setReleaseMode(ReleaseMode.STOP);

      update();
    });
  }

  playAudio() async {
    var result = await audioPlayer.play(localFilePath!);
    if (result == 1) {
      // success
      isDownloadingstart = false;
      isPlayerReadyToPlay = true;
      update();
    }
  }

  pauseAudio() {
    audioPlayer.pause();
  }

  stopAudio() {
    audioPlayer.stop();
  }

  loadAudio(String url, String audioName) async {
    final bytes = await readBytes(Uri.parse(url));
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$audioName.mp3');

    await file.writeAsBytes(bytes);
    if (file.existsSync()) {
      localFilePath = file.path;
      playAudio();
    }
  }

  loopAudio() async {
    final file = await audioCache.loadAsFile(localFilePath!);
    final bytes = await file.readAsBytes();
    audioCache.playBytes(bytes, loop: true);
  }

  seekAudio(Duration durationToSeek) {
    audioPlayer.seek(durationToSeek);
  }

  void showPopupMenu() async {
    await showMenu(
      context: Get.context!,
      position: RelativeRect.fromLTRB(50, 120, 100, 100),
      items: [
        PopupMenuItem(
          value: 1,
          child: CheckboxListTile(
            activeColor: Colors.orange,
            value: true,
            onChanged: (value) {},
            title: Text('En'),
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: CheckboxListTile(
            activeColor: Colors.orange,
            value: false,
            onChanged: (value) {},
            title: Text('Bn'),
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: CheckboxListTile(
            activeColor: Colors.orange,
            value: true,
            onChanged: (value) {},
            title: Text('Ar'),
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value != null) print(value);
    });
  }

  void addBookmarkNote(
      String userId, String surahId, String ayatId, String type) {
    EasyLoading.show(status: "Please wait");
    BookmarkNoteProvider()
        .addBookmarkNote(userId, surahId, ayatId, type)
        .then((value) {
      if (value != null) {
        var data = jsonDecode(value);
        toast(data['message']);
      }
      isLoading(false);
      EasyLoading.dismiss(animation: true);
    });
  }

  void addNote(String userId, String surahId, String ayatId, String type,
      String message) {
    EasyLoading.show(status: "Please wait");
    BookmarkNoteProvider()
        .addNote(userId, surahId, ayatId, type, message)
        .then((value) {
      if (value != null) {
        var data = jsonDecode(value);
        toast(data['message']);
      }
      isLoading(false);
      EasyLoading.dismiss(animation: true);
    });
  }
}

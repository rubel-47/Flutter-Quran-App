import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrf/controllers/home_controller.dart';
import 'package:qrf/model/quran/ayat_list.dart';
import 'package:qrf/model/user/user..dart';
import 'package:qrf/providers/bookmark_note/bookmark_note_provider.dart';
import 'package:qrf/providers/quran/ayat_provider.dart';
import 'package:qrf/utils/session.dart';

import '../model/quran/surah_list.dart';

class AyatController extends GetxController {
  var isLoading = true.obs;
  var ayatList = List<Ayat>.empty(growable: true).obs;
  var surahList = List<Surah>.empty(growable: true).obs;
  var ayatNumbers = List<int>.empty(growable: true).obs;
  var ayatPos = 0.obs;
  var audioPos = 0.obs;
  var isVisiblePlayBg = false;
  var isVisible = false.obs;
  List <String> AyatItems = [] ;

  TextEditingController suraNameController = TextEditingController();
  TextEditingController ayatNumberController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  var argData = Get.arguments;
  var argDetails = Get.arguments;
  var argdata=Get.arguments;


  var surahId;

  var ayatnum;

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
  var localFilePath;

  SessionManager prefs = SessionManager();
  UserData userData = UserData();

  bool isLogin = false;

  var surahNumber;
  var totalAyatEn;
  var totalAyatBn;
  var totalAyatAr;
  var surahTypeEn;
  var surahTypeBn;
  var surahTypeAr;

  var iconContainerHeight = 100.0.obs;
  var scrollController;

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

  var homeController = Get.find<HomeController>();

  var selectedSurahType = "ar".obs;

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  @override
  void onInit() {
    surahNumber = argData[0]['surah_id'];
    totalAyatEn = argData[1]['total_ayat_en'];
    totalAyatBn = argData[2]['total_ayat_bn'];
    totalAyatAr = argData[3]['total_ayat_ar'];
    surahTypeEn = argData[4]['surah_type_en'];
    surahTypeBn = argData[5]['surah_type_bn'];
    surahTypeAr = argData[6]['surah_type_ar'];
    surahList   = argData[7]["surah_list"];

    scrollController = ScrollController()..addListener(scrollListener);
    getAyatList(argData[0]['surah_id']);
    initAudio();
    checkLogin();
    super.onInit();
  }




  @override
  void onClose() {
    scrollController.removeListener(scrollListener);
    audioPlayer.release();
    super.onClose();
  }

  void scrollListener() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (iconContainerHeight.value != 0) {
        iconContainerHeight.value = 0;
        // update();
      }
    }
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (iconContainerHeight.value == 0) {
        iconContainerHeight.value = 100.0;
        // update();
      }
    }
  }

  void getAyatList(var surahId) {
    ayatList.clear();
    int cnt=1;
    AyatProvider().getAyatBySurah(surahId).then((value) {
      if (value != null) {
        Iterable jsonListData = jsonDecode(value);
        jsonListData.forEach((ayat) {
          ayatList.add(Ayat.fromJson(ayat));
          AyatItems.add(cnt.toString());
          //toast(cnt.toString());
          cnt++;
        });
      }

      isLoading(false);
    });
  }
  // getting all the ayat
  void getAyatNumbers(var totalAyat){
    ayatNumbers.clear();

    for(int i=1;i<=totalAyat;i++)
    {
      ayatNumbers.add(i);
    }

  }

  void showMoreButton(var ayatId) {
    ayatList.forEach((element) {
      element.moreButton = false;
    });
    int position = ayatList.indexWhere((element) => element.id == ayatId);
    ayatList[position].moreButton = true;
    update();
  }

  void hideMoreButton(var ayatId) {
    int position = ayatList.indexWhere((element) => element.id == ayatId);
    ayatList[position].moreButton = false;
    update();
  }

  void setSelectedTafsirIndex(int index) {
    ayatPos.value = index;
    update();
  }

  void setAudioPosition(int index) {
    audioPos.value = index;
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
      this.isPlayerReadyToPlay = false;
    });

    audioPlayer.onPlayerStateChanged.listen((playerState) {
      if (playerState == PlayerState.STOPPED) {
        audioState = "Stopped";
        this.isPlayingAudio = false;
        this.playPauseIcon = playIcon;
        this.isPlayerReadyToPlay = false;
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

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

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

  void setSelectedSurahType(String type) {
    this.selectedSurahType.value = type;
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
      // homeController.checkLogin();
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
      homeController.checkLogin();
    });
  }
  void refressh(){
    update();
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/model/bookmark/bookmark.dart';
import 'package:qrf/model/home/features.dart';
import 'package:qrf/model/navigation/navigation_pages.dart';
import 'package:qrf/model/user/user..dart';
import 'package:qrf/providers/bookmark_note/bookmark_note_provider.dart';
import 'package:qrf/providers/navigation/pages_provider.dart';
import 'package:qrf/screens/home/browse_screen.dart';
import 'package:qrf/screens/home/cart_screen.dart';
import 'package:qrf/screens/home/center_screen.dart';
import 'package:qrf/screens/home/notes_screen.dart';
import 'package:qrf/screens/home/profile_screen.dart';
import 'package:qrf/utils/session.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> drawerkey = GlobalKey();// Create a drawer key
  /* HomeScreen */
  var pages = <Widget>[
    CenterScreen(),
    CartScreen(),
    BrowseScreen(),
    NoteScreen(),
    ProfileScreen()
  ];

  var featureList = List<Feature>.empty(growable: false).obs;
  var selectedIndex = 0;
  var tf=false.obs;
  var isLoading = true.obs;

  int get curBottomNav => selectedIndex;
  void setCurrentIndex(int index) {
    selectedIndex = index;
    update();
  }

  var pagesList = List<Pages>.empty(growable: true).obs;

  SessionManager prefs = SessionManager();
  UserData userData = UserData();

  var isLogin = false.obs;

  var bookmarkData = BookmarkData().obs;

  /* Getting login user info */
  _getUserInfo() async {
    userData = await prefs.getUserInfo();
    getBookmarkList(userData.id.toString(), "Note");
  }

  @override
  onInit() {
    getAllFeatures();
    getNavigationList();
    checkLogin();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getAllFeatures() {
    featureList.add(Feature('assets/images/feature_quran_home.png'));
    featureList.add(Feature('assets/images/feature_hadis_home.png'));
    featureList.add(Feature('assets/images/feature_research_icon.png'));
    featureList.add(Feature('assets/images/feature_qrftv_home.png'));
    // featureList.add(Feature('assets/images/feature_course_home.png'));
    featureList.add(Feature('assets/images/feature_library_icon.png'));
  }

  void getNavigationList() {
    PagesProvider().getAllNavigationPages().then((value) {
      if (value != null) {
        Iterable? jsonListData = jsonDecode(value);
        jsonListData?.forEach((lecture) {
          pagesList.add(Pages.fromJson(lecture));
        });
      }
      isLoading(false);
    });
  }

  void checkLogin() async {
    isLogin.value = await prefs.getIsLogin();
    if (isLogin.value) {
      _getUserInfo();
    }
  }

  void getBookmarkList(String userId, String type) {
    bookmarkData.value.bookMark?.clear();
    BookmarkNoteProvider().getBookmarkNote(userId, type).then((value) {
      if (value != null) {
        var jsonListData = jsonDecode(value);
        bookmarkData.value = BookmarkData.fromJson(jsonListData);
      }
      isLoading(false);
    });
  }

  void deleteBookmarkNote(String noteId) {
    EasyLoading.show(status: "Please wait");
    BookmarkNoteProvider().deleteBookmarkNote(noteId).then((value) {
      if (value != null) {
        var data = jsonDecode(value);
        var status = data['status'];
        if (status == 200) {
          toast(data['message']);
        }
      }
      EasyLoading.dismiss(animation: true);
      isLoading(true);
      checkLogin();
    });
  }
}

import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/model/bookmark/bookmark.dart';
import 'package:qrf/model/user/user..dart';
import 'package:qrf/providers/bookmark_note/bookmark_note_provider.dart';
import 'package:qrf/routes/app_pages.dart';
import 'package:qrf/utils/session.dart';

class BookmarkController extends GetxController {
  var isLoading = true.obs;
  var bookmarkData = BookmarkData().obs;

  SessionManager prefs = SessionManager();
  UserData userData = UserData();

  bool isLogin = false;

  /* Getting login user info */
  _getUserInfo() async {
    userData = await prefs.getUserInfo();
    getBookmarkList(userData.id.toString(), "Bookmark");
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
    checkLogin();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getBookmarkList(String userId, String type) {
    BookmarkNoteProvider().getBookmarkNote(userId, type).then((value) {
      /* print(value); */
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

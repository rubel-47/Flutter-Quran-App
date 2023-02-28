import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/model/user/user..dart';
import 'package:qrf/providers/user/user_provider.dart';
import 'package:qrf/routes/app_pages.dart';
import 'package:qrf/utils/session.dart';

class UserController extends GetxController {
  final GlobalKey<ScaffoldState> drawerkey = GlobalKey(); // Create a drawer key

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  var isLoading = true.obs;

  SessionManager prefs = SessionManager();

  @override
  onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void signUp(String name, String email, String mobile, String password,
      String confirmPassword, String address) {
    EasyLoading.show(status: "Please wait");
    UserProvider()
        .signup(name, email, mobile, password, confirmPassword, address)
        .then((value) {
      if (value != null) {
        var data = jsonDecode(value);
        User user = User.fromJson(data);
        prefs.setIsLogin(true);
        prefs.saveUserInfo(user.userData![0]);
        toast(data['message']);
        Get.offAllNamed(AppPages.getHomeRoute());
      }
      isLoading(false);
      EasyLoading.dismiss(animation: true);
    });
  }

  void signIn(String mobile, String password) {
    EasyLoading.show(status: "Please wait");
    UserProvider().signin(mobile, password).then((value) {
      
      if (value != null) {
        var data = jsonDecode(value);
        User user = User.fromJson(data);
        prefs.setIsLogin(true);
        prefs.saveUserInfo(user.userData![0]);
        toast(data['message']);
        Get.offAllNamed(AppPages.getHomeRoute());
      }
      isLoading(false);
      EasyLoading.dismiss(animation: true);
    });
  }
}

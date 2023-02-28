import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/controllers/home_controller.dart';
import 'package:qrf/routes/app_pages.dart';
import 'package:qrf/utils/color.dart';
import 'package:qrf/utils/widgets.dart';

class ProfileScreen extends GetView<HomeController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            title: Text('Profile'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                )),
            centerTitle: true,
            shape: AppbarShapeBorder(),
            automaticallyImplyLeading: false,
            actions: [
              Obx(
                () => controller.isLogin == true
                    ? InkWell(
                        onTap: () {
                          showConfirmDialogCustom(
                            context,
                            title: "Do you want to sign out?",
                            dialogType: DialogType.CONFIRMATION,
                            onAccept: (context) {
                              if (controller.isLogin == true) {
                                controller.prefs.setIsLogin(false);
                                Get.offAllNamed(AppPages.getLoginRoute());
                              } else {
                                Get.toNamed(AppPages.getLoginRoute());
                              }
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.exit_to_app,
                                color: Colors.white,
                              )),
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
        body: Obx(
          () => Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/app_bg.png'),
                      fit: BoxFit.cover),
                ),
              ),
              Column(
                children: [
                  /* Container(
                    height: 60.0,
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.0),
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Text(
                              'Profile'.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                  15.height, */
                  controller.isLogin == true
                      ? Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 230.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: accentColor),
                                child: Column(
                                  children: [
                                    20.height,
                                    Image.asset(
                                      'assets/images/profile_icon.png',
                                      height: 120.0,
                                      width: 120.0,
                                    ),
                                    10.height,
                                    Text(
                                      'Name: ${controller.userData.name}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    10.height,
                                    Image.asset(
                                      'assets/images/edit_icon.png',
                                      height: 30.0,
                                      width: 30.0,
                                    ),
                                  ],
                                ),
                              ),
                              30.height,
                              InkWell(
                                onTap: () {
                                  controller.setCurrentIndex(3);
                                },
                                child: Card(
                                  margin:
                                      EdgeInsets.only(left: 20.0, right: 20.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0,
                                        top: 10.0,
                                        right: 10.0,
                                        bottom: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/nav_notes_icon.png',
                                          height: 30.0,
                                          width: 30.0,
                                          color: Colors.black,
                                        ),
                                        20.width,
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Note',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 19.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Image.asset(
                                                'assets/images/forward_arrow.png',
                                                height: 30.0,
                                                width: 30.0,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              10.height,
                              InkWell(
                                onTap: () {
                                  Get.toNamed(AppPages.getBookmarkRoute());
                                },
                                child: Card(
                                  margin:
                                      EdgeInsets.only(left: 20.0, right: 20.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0,
                                        top: 10.0,
                                        right: 10.0,
                                        bottom: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/bookmark_icon.png',
                                          height: 30.0,
                                          width: 30.0,
                                          color: Colors.black,
                                        ),
                                        20.width,
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Bookmark',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 19.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Image.asset(
                                                'assets/images/forward_arrow.png',
                                                height: 30.0,
                                                width: 30.0,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              10.height,
                              Card(
                                margin:
                                    EdgeInsets.only(left: 20.0, right: 20.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0,
                                      top: 10.0,
                                      right: 10.0,
                                      bottom: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/images/download_icon.png',
                                        height: 30.0,
                                        width: 30.0,
                                        color: Colors.black,
                                      ),
                                      20.width,
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Download file',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 19.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Image.asset(
                                              'assets/images/forward_arrow.png',
                                              height: 30.0,
                                              width: 30.0,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/profile_icon.png',
                                  height: 120.0,
                                  width: 120.0,
                                ),
                                10.height,
                                InkWell(
                                  onTap: () {
                                    Get.offAllNamed(AppPages.getLoginRoute());
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: primaryColor),
                                    child: Text(
                                      'Login or Signup'.toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15.0),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ));
  }
}

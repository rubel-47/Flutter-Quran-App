import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/controllers/qrv_tv_controller.dart';
import 'package:qrf/routes/app_pages.dart';
import 'package:qrf/utils/color.dart';
import 'package:qrf/utils/widgets.dart';

class QrftvScreen extends GetView<QrfTvController> {
  const QrftvScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBgColor,
        appBar: CustomAppBar(title: 'Qrf tv'.toUpperCase(), height: 80.0),
        body: Obx(() => Stack(
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
                              child: Text(
                                'Qrf tv'.toUpperCase(),
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
                    ), */
                    Image.asset('assets/images/qrftv_top_player_icon.png'),
                    10.height,
                    InkWell(
                      onTap: () {
                        controller.setCategoryShowHide();
                      },
                      child: Container(
                        width: Get.width * .5,
                        height: 50.0,
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                'Category',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'cursive'),
                              ),
                              5.width,
                              Image.asset(
                                controller.isCategoryVisible.value
                                    ? 'assets/images/qrftv_cat_up_arrow_icon.png'
                                    : 'assets/images/qrftv_cat_down_arrow_icon.png',
                                height: 30.0,
                                width: 30.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    10.height,
                    controller.isLoadingCat.value
                        ? Center(child: CircularProgressIndicator())
                        : Visibility(
                            visible: controller.isCategoryVisible.value,
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/left_arrow_icon.png',
                                  height: 30.0,
                                  width: 30.0,
                                ),
                                Flexible(
                                  child: Container(
                                      height: 180.0,
                                      child: ListView.builder(
                                          itemCount:
                                              controller.categoryList.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            var cat = controller
                                                .categoryList.value[index];
                                            return InkWell(
                                              onTap: () {
                                                Get.toNamed(
                                                    AppPages.getQrftvCatRoute(),
                                                    arguments: [
                                                      {"title": cat.name},
                                                      {
                                                        "cat_id":
                                                            cat.id.toString()
                                                      }
                                                    ]);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(10.0),
                                                padding: EdgeInsets.all(10.0),
                                                color: Colors.white,
                                                width: Get.width * .2 + 20.0,
                                                height: Get.width * .2 + 40.0,
                                                child: Container(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Image.asset(
                                                        'assets/images/qrftv_placeholder_empty.png',
                                                        height: 80.0,
                                                        width: 80.0,
                                                      ),
                                                      10.height,
                                                      Text(
                                                        '${cat.name}',
                                                        maxLines: 1,
                                                      ),
                                                      10.height,
                                                      Text(
                                                        '5 videos',
                                                        style: TextStyle(
                                                            fontSize: 17.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.blue),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          })),
                                ),
                                Image.asset(
                                  'assets/images/right_arrow_icon.png',
                                  height: 30.0,
                                  width: 30.0,
                                ),
                              ],
                            ),
                          ),
                    Expanded(
                      child: controller.isLoading.value
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: controller.tvList.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                var videos = controller.tvList[index];
                                return InkWell(
                                  onTap: () {
                                    Get.toNamed(AppPages.getVideoPlayerRoute(),
                                        arguments: [
                                          {"video_title": videos.videoTitle},
                                          {"video_id": videos.videoId}
                                        ]);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(8.0),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 120.0,
                                          width: 120.0,
                                          child: Stack(
                                            children: [
                                              Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0)),
                                                child: Image.asset(
                                                  'assets/images/qrftv_placeholder_empty.png',
                                                ),
                                              ),
                                              Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    height: 70.0,
                                                    width: 70.0,
                                                    child: Image.asset(
                                                      'assets/images/round_shadow_play_icon_white.png',
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                        10.width,
                                        Flexible(
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 120.0,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${videos.videoTitle}',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 17.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                5.height,
                                                Text(
                                                  'Description',
                                                  maxLines: 2,
                                                ),
                                                10.height,
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${videos.videoDuration}',
                                                      style: TextStyle(
                                                          fontSize: 17.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue),
                                                    ),
                                                    5.width,
                                                    Text(
                                                      'Minutes',
                                                      style: TextStyle(
                                                          fontSize: 17.0,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.blue),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 60.0,
                                          width: 60.0,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Center(
                                              child: Image.asset(
                                            'assets/images/play_icon_white.png',
                                            height: 40.0,
                                            width: 40.0,
                                          )),
                                        ),
                                        10.width,
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    )
                  ],
                ),
              ],
            )));
  }
}

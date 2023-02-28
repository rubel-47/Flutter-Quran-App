import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/controllers/home_controller.dart';
import 'package:qrf/routes/app_pages.dart';
import 'package:qrf/screens/quran/ayat_screen.dart';
import 'package:qrf/utils/widgets.dart';

import '../quran/sura_list_screen_offline.dart';

class CenterScreen extends GetView<HomeController> {
  const CenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: controller.drawerkey,
        endDrawer: Drawer(
          // backgroundColor: Colors.amber[12],
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0, bottom: 10.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/home_navigation.png',
                        height: 25,
                        width: 25,
                      ),
                      20.width,
                      Text(
                        'Home',
                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  10.height,
                  Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/last_read_navigation.png',
                        height: 25,
                        width: 25,
                      ),
                      20.width,
                      Text(
                        'Last Read',
                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  10.height,
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppPages.getSurahRoute());
                    },
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/quran_navigation.png',
                          height: 25,
                          width: 25,
                        ),
                        20.width,
                        Text(
                          'AlQuran',
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  10.height,
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppPages.getHadisTypeRoute());
                    },
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/hadith_navigation.png',
                          height: 25,
                          width: 25,
                        ),
                        20.width,
                        Text(
                          'Hadith',
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  10.height,
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppPages.getPaperRoute());
                    },
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/research_paper_navigation.png',
                          height: 25,
                          width: 25,
                        ),
                        20.width,
                        Text(
                          'Research paper',
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  10.height,
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppPages.getQrftvRoute());
                    },
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/qrf_tv_navigation.png',
                          height: 25,
                          width: 25,
                        ),
                        20.width,
                        Text(
                          'QRF TV',
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  10.height,
                  Obx(
                    () => ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.pagesList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed(AppPages.getNavigationContentRoute(), arguments: [
                              {"data": controller.pagesList[index].toJson()}
                            ]);
                          },
                          child: Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  controller.pagesList[index].menuIcon.isEmptyOrNull
                                      ? Image.asset(
                                          'assets/images/exit_navigation.png',
                                          height: 25,
                                          width: 25,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: "http://139.180.156.187:92/${controller.pagesList[index].menuIcon}",
                                          height: 25,
                                          width: 25,
                                        ),
                                  20.width,
                                  Text(
                                    '${controller.pagesList[index].menuName}',
                                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              10.height,
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/rating_navigation.png',
                        height: 25,
                        width: 25,
                      ),
                      20.width,
                      Text(
                        'Rating',
                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  10.height,
                  controller.isLogin == true
                      ? Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/exit_navigation.png',
                              height: 25,
                              width: 25,
                            ),
                            20.width,
                            Text(
                              'Exit',
                              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                            )
                          ],
                        )
                      : Container(),
                  10.height,
                ],
              ),
            ),
          ),
        ),
        body: Container(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/home_bg.png'), fit: BoxFit.cover),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/home_shadow_bg.png'), fit: BoxFit.cover),
                ),
              ),
              Container(
                height: 75.0,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/home_top_shape.png'), fit: BoxFit.fill),
                ),
              ),
              Column(
                children: [
                  40.height,
                  Container(
                    height: 60.0,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.0,left: 10),

                            child: Column(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'আল কোরআন: যুগের জ্ঞানের আলোকে',
                                    style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Flexible(
                                    child: Text(
                                  'অনুবাদ ও মৌলিক তাফসীর',
                                  style: TextStyle(color: Colors.green, fontSize: 13.0, fontWeight: FontWeight.bold),
                                ))
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.drawerkey.currentState!.openEndDrawer();
                          //  toast("hellllo");
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child:
                            Image.asset('assets/images/home_menu_icon.png'),
                          ),
                        ),
                        /* Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Image.asset('assets/images/search_icon.png'),
                        ), */
                      ],
                    ),
                  ),
               10.height,
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: controller.featureList.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                var feature = controller.featureList[index];
                                return InkWell(
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  HomePage()),
                                        );
                                        //Get.toNamed(AppPages.getSurahRoute());
                                        break;
                                      case 1:
                                        Get.toNamed(AppPages.getHadisTypeRoute());
                                        break;
                                      case 2:
                                        Get.toNamed(AppPages.getPaperRoute());
                                        break;
                                      case 3:
                                        Get.toNamed(AppPages.getQrftvRoute());
                                        break;
                                      /* case 4:
                                        Get.toNamed(AppPages.getLectureRoute());
                                        break; */
                                      case 4:
                                        Get.toNamed(AppPages.getLibraryRoute());
                                        break;
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
                                    child: SizedBox(
                                        height: 200.0,
                                        child: Image.asset(
                                          feature.bg_name,
                                        )),
                                  ),
                                );
                              }),
                          10.height,
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/controllers/hadis_type_controller.dart';
import 'package:qrf/routes/app_pages.dart';
import 'package:qrf/utils/color.dart';
import 'package:qrf/utils/widgets.dart';

import 'hadis_offline.dart';

class HadisTypeScreen extends GetView<HadisTypeController> {
  HadisTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appBgColor,
      appBar: CustomAppBar(title: 'AL HADITH'.toUpperCase(), height: 80.0),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/app_bg.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  30.height,
                  Text(
                    'AL HADITH',
                    style: TextStyle(
                        fontSize: 17.0, fontWeight: FontWeight.bold),
                  ),
                  Text('আল হাদিস',
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.w500)),
                  20.height,
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppPages.getHadisRoute());
                    },
                    child: Container(
                      height: Get.width * 0.5,
                      width: Get.width * 0.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/lenear_gradient_background.png'),
                            fit: BoxFit.fitWidth),
                      ),
                      child: InkWell(
                        onTap: ()
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const HadisScreenOffile()),
                                  );
                                },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/hadith_navigation.png',
                              height: 80.0,
                              width: 80.0,
                            ),

                            Container(
                              margin: EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Text('সনদ ও মতন সহী হাদিস',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  20.height,
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppPages.getHadisRoute());
                    },
                    child: Container(
                      height: Get.width * 0.5,
                      width: Get.width * 0.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/lenear_gradient_background.png'),
                            fit: BoxFit.fitWidth),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/white_book_icon.png',
                            height: 80.0,
                            width: 80.0,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 20.0, right: 20.0),
                            child: Text('অন্যান্য হাদিস',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

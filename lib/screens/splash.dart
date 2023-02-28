import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/controllers/splash_controller.dart';
import 'package:qrf/utils/color.dart';

import '../controllers/database/quran_database.dart';
import '../providers/quran/ayat_provider.dart';
import '../providers/quran/test_provider.dart';

class SplashScreen extends GetView<SplashController> {
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/splash_shadow_icon.png'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
                decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/splash_bg.png'),
                  fit: BoxFit.cover),
            )),
            Container(
                height: 150.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/splash_top_shape.png'),
                      fit: BoxFit.cover),
                )),
            Positioned(
                top: 30.0,
                left: 0,
                right: 0,
                child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        10.height,
                        Text(
                          'আল কোরআন',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0),
                        ),
                        5.height,
                        SizedBox(
                          width: Get.width*0.7,
                          child: Text(
                            'যুগের জ্ঞানের আলোকে অনুবাদ ও মৌলিক তাফসীর',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 19.0),
                          ),
                        ),
                      ],
                    ))),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "পড় তোমার প্রভুর নামে যিনি তোমায় সৃষ্টি করেছেন",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0),
                        ),
                      ),
                      10.height,
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 50.0),
                        child: Text(
                          "সূরা আলাক - ১",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: (MediaQuery.of(context).size.height / 4),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: StreamBuilder<double>(
                    initialData: controller.progress,
                    stream: controller.stream,
                    builder: (context, snapshot) {
                      var value = snapshot.data;
                      // print(value);
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            width: double.infinity,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryColor, width: 3),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Stack(
                              children: [
                                // LayoutBuilder provide us the available space for the conatiner
                                // constraints.maxWidth needed for our animation
                                LayoutBuilder(
                                  builder: (context, constraints) => Container(
                                    // from 0 to 1 it takes 60s
                                    width: constraints.maxWidth * value!,
                                    decoration: BoxDecoration(
                                      color: brownColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      );
                    }),
              ),
            ),
            Positioned(
                bottom: 50.0,
                left: 0,
                right: 0,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Powerd By',
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0),
                    ),
                    Text(
                      'Quran Research Foundation',
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

}

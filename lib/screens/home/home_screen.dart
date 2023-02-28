import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/controllers/home_controller.dart';
import 'package:qrf/utils/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        body: Stack(
          children: [
            controller.pages.elementAt(controller.curBottomNav),
          ],
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          renderOverlay: false,
          direction: SpeedDialDirection.left,
          spaceBetweenChildren: 0,
          closeManually: true,
          childrenButtonSize: Size(Get.width / 6, Get.width / 6),
          activeBackgroundColor: Colors.red,
          activeForegroundColor: Colors.red,
          //activeChild: getCenteredImage(context, dialogType, primaryColor),

          children: [
            SpeedDialChild(
              child: Image.asset('assets/images/nav_profile_icon.png'),
              onTap: (){
                controller.setCurrentIndex(4);
              },
            ),
            SpeedDialChild(
              child: Image.asset('assets/images/nav_cart_icon.png'),
             // backgroundColor: Colors.white,
              onTap: (){
                controller.setCurrentIndex(1);
              },
            ),
            SpeedDialChild(
              child: Image.asset('assets/images/nav_browser_icon.png'),
            //  backgroundColor: Colors.white,
              onTap: (){
                controller.setCurrentIndex(2);
              },
            ),
            SpeedDialChild(
              child: Image.asset('assets/images/nav_center_icon.png'),
             // backgroundColor: Colors.white,
              onTap: (){
                controller.setCurrentIndex(0);
              },
            ),
          ],
        ),
      );
    });
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/controllers/navigation_content_controller.dart';
import 'package:qrf/utils/color.dart';
import 'package:qrf/utils/load_web_view.dart';
import 'package:qrf/utils/widgets.dart';

class NavigationContentScreen extends GetView<NavigationContentController> {
  const NavigationContentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBgColor,
        appBar: CustomAppBar(
            title: '${controller.navigationData.menuName}'.toUpperCase(),
            height: 80.0),
        body: controller.navigationData.link != null
            ? Stack(
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
                              InkWell(
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
                              Center(
                                child: Text(
                                  '${controller.navigationData.menuName}'
                                      .toUpperCase(),
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
                      35.height, */
                      Expanded(
                          child: LoadWebView(
                              controller.navigationData.link ?? "", true)),
                    ],
                  ),
                ],
              )
            : Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/app_bg.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        /* Container(
                          height: 60.0,
                          child: Padding(
                            padding: EdgeInsets.only(top: 40.0),
                            child: Stack(
                              children: <Widget>[
                                InkWell(
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
                                Center(
                                  child: Text(
                                    '${controller.navigationData.menuName}'
                                        .toUpperCase(),
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
                        20.height, */
                        CachedNetworkImage(
                          imageUrl:
                              "http://139.180.156.187:92/${controller.navigationData.featureImage}",
                          height: 150.0,
                        ),
                        10.height,
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: 3.0),
                          child: Html(
                            data: controller.navigationData.description != null
                                ? controller.navigationData.description
                                : "<p></p>",
                            shrinkWrap: true,
                            style: {
                              "p": Style(
                                  fontSize: FontSize.rem(1.3),
                                  textAlign: TextAlign.start,
                                  whiteSpace: WhiteSpace.NORMAL,
                                  display: Display.BLOCK)
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
  }
}

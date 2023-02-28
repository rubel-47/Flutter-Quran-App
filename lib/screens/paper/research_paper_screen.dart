import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/controllers/paper_controller.dart';
import 'package:qrf/routes/app_pages.dart';
import 'package:qrf/utils/color.dart';
import 'package:qrf/utils/constant.dart';
import 'package:qrf/utils/widgets.dart';

class PaperScreen extends GetView<PaperController> {
  const PaperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appBgColor,
      appBar: CustomAppBar(title: 'RESEARCH PAPER'.toUpperCase(), height: 80.0),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/app_bg.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Column(
            children: <Widget>[
              
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            'গবেষণা পত্র',
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                        10.height,
                        Obx(
                          () => controller.isLoading.value
                              ? Center(child: CircularProgressIndicator())
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: controller.paperList.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  top: 15.0,
                                                  left: 10.0,
                                                  right: 10.0,
                                                  bottom: 15.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  CachedNetworkImage(
                                                      height: 150.0,
                                                      width: 80.0,
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                      imageUrl:
                                                          "http://139.180.156.187:92${controller.paperList[index].coverImage}"),
                                                  10.width,
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${controller.paperList[index].researchPaperName}',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 19.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        10.height,
                                                        Text(
                                                          'গবেষনা সিরিজ ${controller.paperList[index].publicationId}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: Colors.grey
                                                                  .shade600,
                                                              fontSize: 17.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        10.height,
                                                        Text(
                                                          '${controller.paperList[index].paperNumber} পাতা',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: Colors.grey
                                                                  .shade600,
                                                              fontSize: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        5.height,
                                                        Row(
                                                          children: <Widget>[
                                                            Container(
                                                              width: 75.0,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    '${controller.paperList[index].regularPrice}৳',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        decoration:
                                                                            TextDecoration
                                                                                .lineThrough,
                                                                        decorationStyle:
                                                                            TextDecorationStyle
                                                                                .solid,
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            15.0,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  Text(
                                                                    '${controller.paperList[index].discountPrice}৳',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            15.0,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),

                                                            Padding(
                                                              padding: const EdgeInsets.only(right: 8.0),
                                                              child: ElevatedButton(
                                                                child: Container(
                                                                    height: 40.0,
                                                                    width: 40.0,
                                                                    child: Center(
                                                                        child: Text(
                                                                            'পড়ুন'))),
                                                                onPressed: () {
                                                                  Get.toNamed(
                                                                      AppPages
                                                                          .getPaperDetailsRoute(),
                                                                      arguments: [
                                                                        {
                                                                          "paper_id": controller
                                                                              .paperList[index]
                                                                              .id
                                                                        }
                                                                      ]);
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10.0)),
                                                                    primary:
                                                                        primaryColor,
                                                                    textStyle: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400)),
                                                              ),
                                                            ),
                                                            ElevatedButton(
                                                              child: Container(
                                                                height: 40.0,
                                                                width: 45.0,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            5.0,
                                                                        bottom:
                                                                            2.0),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Center(
                                                                  child: Text(
                                                                    'অর্ডার করুন',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        height:
                                                                            .9,
                                                                        color:
                                                                            primaryColor),
                                                                  ),
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                BUY_NOW_URL = controller
                                                                        .paperList[
                                                                            index]
                                                                        .purchaseLink ??
                                                                    "";
                                                                Get.toNamed(AppPages
                                                                    .getBuyNowRoute());
                                                              },
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              10.0)),
                                                                      side:
                                                                          BorderSide(
                                                                        width:
                                                                            2.0,
                                                                        color:
                                                                            primaryColor,
                                                                      ),
                                                                      elevation:
                                                                          5.0,
                                                                      primary:
                                                                          Colors
                                                                              .white,
                                                                      textStyle: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              primaryColor,
                                                                          fontWeight:
                                                                              FontWeight.w400)),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

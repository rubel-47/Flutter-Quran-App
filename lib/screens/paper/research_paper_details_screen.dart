import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/controllers/paper_details_controller.dart';
import 'package:qrf/utils/color.dart';
import 'package:qrf/utils/widgets.dart';

class PaperDetailsScreen extends GetView<PaperDetailsController> {
  const PaperDetailsScreen({Key? key}) : super(key: key);

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
                    Obx(
                      () => controller.isLoading.value
                          ? Center(child: CircularProgressIndicator())
                          : Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'গবেষণা পত্র',
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                10.height,
                                Text(
                                  'গবেষনা সিরিজ - ${controller.paperDetails.value.paperNumber}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                10.height,
                                Text(
                                  '${controller.paperDetails.value.researchPaperName}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                InkWell(
                                  onTap: (() {
                                    controller.isPressed(
                                        controller.isPressed.value
                                            ? false
                                            : true);
                                  }),
                                  child: Container(
                                      margin: EdgeInsets.all(10.0),
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2.0, color: Colors.black)),
                                      child: Stack(
                                        children: [
                                          Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'সূচিপত্র',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 17.0),
                                              )),
                                          Align(
                                              alignment: Alignment.centerRight,
                                              child: Icon(
                                                controller.isPressed.value
                                                    ? Icons.keyboard_arrow_down
                                                    : Icons.keyboard_arrow_up,
                                                color: Colors.black,
                                              )),
                                        ],
                                      )),
                                ),
                                controller.isPressed.value
                                    ? Expanded(
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: controller.paperDetails
                                              .value.researchIndex?.length,
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            var data = controller.paperDetails
                                                .value.researchIndex?[index];
                                            return Row(
                                              children: <Widget>[
                                                Container(
                                                  height: 40.0,
                                                  width: 80.0,
                                                  margin: EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 5.0),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 2.0,
                                                          color: Colors.black)),
                                                  child: Center(
                                                      child: Text(
                                                          '${data?.indexPosition}')),
                                                ),
                                                10.width,
                                                Flexible(
                                                  child: Container(
                                                    height: 40.0,
                                                    width: Get.width - 100.0,
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    margin: EdgeInsets.only(
                                                        left: 10.0,
                                                        right: 10.0,
                                                        top: 5.0),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 2.0,
                                                            color:
                                                                Colors.black)),
                                                    child: Text(
                                                        '${data?.indexName}'),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
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

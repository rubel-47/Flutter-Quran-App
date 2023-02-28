import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrf/controllers/hadis_search_controller.dart';
import 'package:qrf/routes/app_pages.dart';
import 'package:qrf/utils/color.dart';
import 'package:qrf/utils/widgets.dart';

class HadisSearchScreen extends GetView<HadisSearchController> {
  const HadisSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HadisSearchController>(builder: (controller) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: appBgColor,
          appBar: CustomAppBar(
              title: controller.argData[0]['keyword'], height: 80.0),
          body: Obx(() => controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/app_bg.png'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: controller.hadisList.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(AppPages.getHadisDetailsRoute(),
                                      arguments: [
                                        {
                                          'hadis_id':
                                              controller.hadisList[index].id
                                        }
                                      ]);
                                },
                                child: Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 2.0),
                                  ),
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(5.0),
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    '${controller.hadisList[index].hadisAr}',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                )));
    });
  }
}

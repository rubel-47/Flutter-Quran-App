import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/controllers/hadis_controller.dart';
import 'package:qrf/routes/app_pages.dart';
import 'package:qrf/screens/hadis/hadis_offline.dart';
import 'package:qrf/utils/color.dart';
import 'package:qrf/utils/widgets.dart';

class HadisScreen extends GetView<HadisController> {
  const HadisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appBgColor,
      appBar: AppBar(title: Row(
        children: [
          Text('AL HADITH'.toUpperCase()),
          SizedBox(width: 40,),

        ],
      )),
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

                        ),
                        10.height,
                        Obx(
                          () => controller.isLoading.value
                              ? Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: controller.hadisList.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                            AppPages.getHadisDetailsRoute(),
                                            arguments: [
                                              {
                                                'hadis_id': controller
                                                    .hadisList[index].id
                                              }
                                            ]);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          height: 65.0,
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
                                      ),
                                    );
                                  },
                                ),
                        )
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

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/controllers/bookmark_note_controller.dart';
import 'package:qrf/controllers/home_controller.dart';
import 'package:qrf/routes/app_pages.dart';
import 'package:qrf/utils/color.dart';
import 'package:qrf/utils/widgets.dart';

class NoteScreen extends GetView<HomeController> {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBgColor,
        appBar: CustomAppBarWithoutLeading(title: 'Notes',height: 80.0,),
        body: Stack(
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
                        /* InkWell(
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
                    ), */
                        Center(
                          child: Text(
                            'Notes'.toUpperCase(),
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
                15.height, */
                Obx(() => controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : controller.isLogin.value == true
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount:
                                controller.bookmarkData.value.bookMark?.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              String lang = Get.locale.toString();
                              var ayat = controller.bookmarkData.value
                                  .bookMark![index].bookmarkAyat;
                              return Column(
                                children: [
                                  Container(
                                    width: Get.width,
                                    margin: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: surahBgColor,
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.all(10.0),
                                                color: Colors.yellow,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Note:',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontSize: 17.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red),
                                                    ),
                                                    5.width,
                                                    Text(
                                                      '${controller.bookmarkData.value.bookMark![index].message}',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontSize: 17.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                showConfirmDialogCustom(
                                                  context,
                                                  title:
                                                      "Do you want to delete this note?",
                                                  dialogType: DialogType.DELETE,
                                                  onAccept: (context) {
                                                    if (controller.isLogin ==
                                                        true) {
                                                      controller
                                                          .deleteBookmarkNote(
                                                              controller
                                                                  .bookmarkData
                                                                  .value
                                                                  .bookMark![
                                                                      index]
                                                                  .id
                                                                  .toString());
                                                    } else {
                                                      toast(
                                                          'Please login to add bookmark');
                                                      Get.back();
                                                      Get.toNamed(AppPages
                                                          .getLoginRoute());
                                                    }
                                                  },
                                                );
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 5.0, right: 5.0),
                                                child: Container(
                                                  padding: EdgeInsets.all(5.0),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.red),
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        5.height,
                                        Container(
                                          alignment: Alignment.centerRight,
                                          margin: EdgeInsets.only(right: 3.0),
                                          child: Html(
                                            data: ayat?.nameAr,
                                            shrinkWrap: true,
                                            style: {
                                              "p": Style(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: FontSize.rem(1.6),
                                                  textAlign: TextAlign.right,
                                                  whiteSpace: WhiteSpace.NORMAL,
                                                  display: Display.BLOCK)
                                            },
                                          ),
                                        ),
                                        10.height,
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 5.0, bottom: 10.0),
                                            child: Text(
                                              '${ayat?.nameEn}',
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.w400),
                                            )),
                                        5.height,
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 5.0, bottom: 10.0),
                                            child: Text(
                                              '${lang == 'en' ? ayat?.nameEn : lang == 'bn' ? ayat?.nameBn : ayat?.nameAr}',
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.w400),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          )
                        : Container(
                            height: Get.height - 150.0,
                            child: Center(
                              child: Text('Please login to see your notes'),
                            ),
                          )),
              ],
            ),
          ],
        ));
  }
}

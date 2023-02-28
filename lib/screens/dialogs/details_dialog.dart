import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/controllers/ayat_controller.dart';
import 'package:qrf/model/quran/ayat_list.dart';
import 'package:qrf/utils/widgets.dart';

class AyatDetailsDialog extends GetView<AyatController> {
  AyatDetailsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AyatController>(builder: (controller) {
      var ayat = controller.ayatList[controller.ayatPos.value];
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  height: 35.0,
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            5.height,
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                      image: AssetImage('assets/images/dialog_bg.png'),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  children: <Widget>[
                    10.height,
                    Text(
                      "[Details]",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    10.height,
                    VerticalLine(),
                    10.height,
                    Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.grey[100]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Html(
                            data: ayat.nameAr,
                            shrinkWrap: true,
                            style: {
                              "p": Style(
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.center,
                                  fontSize: FontSize.xLarge)
                            },
                          ),
                          10.height,
                          Container(
                              padding: EdgeInsets.only(left: 5.0, bottom: 10.0),
                              child: Text(
                                '${ayat.nameBn}',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 17.0),
                              )),
                          10.height,
                        ],
                      ),
                    ),
                    10.height,
                    VerticalLine(),
                    10.height,
                    Container(
                      height: 40.0,
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/option_play_icon.png',
                            height: 30.0,
                            width: 30.0,
                          ),
                          Image.asset(
                            'assets/images/option_read_icon.png',
                            height: 30.0,
                            width: 30.0,
                          ),
                          Image.asset(
                            'assets/images/option_share_icon.png',
                            height: 30.0,
                            width: 30.0,
                          ),
                          Image.asset(
                            'assets/images/option_flag_icon.png',
                            height: 30.0,
                            width: 30.0,
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                              ayat.ayatWordBank?.length ?? 0, (index) {
                            var wordList = ayat.ayatWordBank;
                            AyatWordBank word = wordList![index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: Get.width * 0.7,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.grey[100]),
                                  margin: EdgeInsets.all(3.0),
                                  child: Html(
                                    data: word.nameAr,
                                    shrinkWrap: true,
                                    style: {
                                      "p": Style(
                                          fontWeight: FontWeight.bold,
                                          fontSize: FontSize.rem(1.6),
                                          textAlign: TextAlign.center,
                                          whiteSpace: WhiteSpace.NORMAL,
                                          color: Colors.red,
                                          display: Display.BLOCK)
                                    },
                                  ),
                                ),
                                Text(
                                  '${word.nameEn}',
                                  style: TextStyle(
                                      color: Colors.redAccent, fontSize: 15.0),
                                ),
                                Text(
                                  '${word.nameBn}',
                                  style: TextStyle(
                                      color: Colors.redAccent, fontSize: 15.0),
                                ),
                                10.height,
                                Text(
                                  '${word.translateEn}',
                                  style: TextStyle(
                                      color: Colors.redAccent, fontSize: 15.0),
                                ),
                                10.height,
                                Text(
                                  '${word.translateBn}',
                                  style: TextStyle(
                                      color: Colors.redAccent, fontSize: 15.0),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

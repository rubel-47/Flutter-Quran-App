import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/controllers/ayat_controller.dart';
import 'package:qrf/utils/widgets.dart';

class AyatTafsirDialog extends GetView<AyatController> {
  AyatTafsirDialog({Key? key}) : super(key: key);

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
                      'যুগের জ্ঞানের আলোকে মৌলিক তাফসীর',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    10.height,
                    VerticalLine(),
                    10.height,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        InkWell(
                          onTap: (() {
                            controller.setSelectedTafsirIndex(
                                controller.ayatPos > 0
                                    ? controller.ayatPos.value - 1
                                    : 0);
                          }),
                          child: Container(
                              color: Colors.grey[300],
                              padding: EdgeInsets.all(5.0),
                              child: Icon(Icons.keyboard_double_arrow_left)),
                        ),
                        Container(
                          child: Text('${ayat.suraNameBn} : ${ayat.ayaNumber}'),
                        ),
                        InkWell(
                          onTap: (() {
                            controller.setSelectedTafsirIndex(
                                controller.ayatPos < controller.ayatList.length
                                    ? controller.ayatPos.value + 1
                                    : 0);
                          }),
                          child: Container(
                              color: Colors.grey[300],
                              padding: EdgeInsets.all(5.0),
                              child: Icon(Icons.keyboard_double_arrow_right)),
                        ),
                      ],
                    ),
                    Container(
                      height: 5.0,
                      color: Colors.blue,
                    ),
                    10.height,
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            '${ayat.tafsir}',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
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

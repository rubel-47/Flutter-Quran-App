import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrf/utils/color.dart';
import 'package:qrf/utils/constant.dart';
import 'package:qrf/utils/load_web_view.dart';
import 'package:qrf/utils/widgets.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: appBgColor,
        appBar: CustomAppBar(title: 'Library'.toUpperCase(), height: 80.0),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/app_bg.png'),
                    fit: BoxFit.fill),
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
                            'Library'.toUpperCase(),
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
                ), */
                Expanded(
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0)),
                        child: LoadWebView(LIBRARY_URL, true))),
              ],
            ),
          ],
        ));
  }
}

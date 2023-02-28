import 'package:flutter/material.dart';
import 'package:qrf/utils/color.dart';
import 'package:qrf/utils/constant.dart';
import 'package:qrf/utils/load_web_view.dart';
import 'package:qrf/utils/widgets.dart';

class BuyNowScreen extends StatelessWidget {
  const BuyNowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor: appBgColor,
      appBar: CustomAppBar(title: 'BUY NOW'.toUpperCase(), height: 80.0),
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
                    padding: EdgeInsets.only(top: 30.0),
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
                            'BUY NOW'.toUpperCase(),
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
                    child: LoadWebView(BUY_NOW_URL, true)),
              ],
            ),
          ],
        ));
  }
}

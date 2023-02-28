import 'package:flutter/material.dart';
import 'package:qrf/utils/color.dart';
import 'package:qrf/utils/constant.dart';
import 'package:qrf/utils/load_web_view.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: Stack(
        children: [
          Container(
            height: 60.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/home_top_shape.png'),
                  fit: BoxFit.fill),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 100.0, top: 30.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0)),
                  child: LoadWebView(SHOP_URL, true))),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/controllers/user_controller.dart';
import 'package:qrf/routes/app_pages.dart';
import 'package:qrf/utils/color.dart';
import 'package:qrf/utils/widgets.dart';

class LoginScreen extends GetView<UserController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: appBgColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            title: Text('Login'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                )),
            centerTitle: true,
            shape: AppbarShapeBorder(),
            leading: InkWell(
              onTap: () {
                Get.offAndToNamed(AppPages.getHomeRoute());
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
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
                    padding: EdgeInsets.only(top: Get.height * .03),
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
                            'Login'.toUpperCase(),
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
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/ic_launcher.png',
                      height: 120.0,
                      width: 120.0,
                    ),
                    20.height,
                    Text(
                      'Login'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                    ),
                    30.height,
                    Container(
                      height: 50.0,
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: TextFormField(
                          controller: controller.mobileNumberController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          autofocus: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "Mobile number",
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                            labelStyle: TextStyle(
                                color: black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal),
                            hintStyle: TextStyle(
                                color: black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal),
                            filled: true,
                            fillColor: Colors.grey[400],
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide:
                                  BorderSide(color: surahBgColor, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide:
                                  BorderSide(color: surahBgColor, width: 0.0),
                            ),
                          )),
                    ),
                    10.height,
                    Container(
                      height: 50.0,
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: TextFormField(
                          controller: controller.loginPasswordController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          autofocus: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password",
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                            labelStyle: TextStyle(
                                color: black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal),
                            hintStyle: TextStyle(
                                color: black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal),
                            filled: true,
                            fillColor: Colors.grey[400],
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide:
                                  BorderSide(color: surahBgColor, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide:
                                  BorderSide(color: surahBgColor, width: 0.0),
                            ),
                          )),
                    ),
                    20.height,
                    InkWell(
                      onTap: () {
                        var mobile = controller.mobileNumberController.text;
                        var password = controller.loginPasswordController.text;

                        if (mobile.isEmptyOrNull) {
                          toast("Please enter mobile number");
                          return;
                        }
                        if (password.isEmptyOrNull) {
                          toast("Please enter login password");
                          return;
                        }

                        controller.signIn(mobile, password);
                      },
                      child: Container(
                        width: 150.0,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: primaryColor),
                        child: Center(
                          child: Text(
                            'Submit'.toUpperCase(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                      ),
                    ),
                    30.height,
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppPages.getSignupRoute());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?".toUpperCase(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500),
                          ),
                          5.width,
                          Text(
                            "Click here".toUpperCase(),
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ],
        ));
  }
}

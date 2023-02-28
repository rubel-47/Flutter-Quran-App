import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/controllers/user_controller.dart';
import 'package:qrf/routes/app_pages.dart';
import 'package:qrf/utils/color.dart';
import 'package:qrf/utils/widgets.dart';

class SignupScreen extends GetView<UserController> {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBgColor,
        appBar: CustomAppBar(title: 'Sign up'.toUpperCase(), height: 80.0),
        body: Stack(
          fit: StackFit.expand,
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
                            'Sign up'.toUpperCase(),
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
                    child: SingleChildScrollView(
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
                        'Sign up'.toUpperCase(),
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
                            controller: controller.nameController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                            decoration: InputDecoration(
                              hintText: "Name",
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
                            controller: controller.mobileController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            autofocus: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                            decoration: InputDecoration(
                              hintText: "Mobile",
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
                            controller: controller.emailController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                            decoration: InputDecoration(
                              hintText: "Email",
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
                            controller: controller.addressController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                            decoration: InputDecoration(
                              hintText: "Address",
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
                            controller: controller.passwordController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            autofocus: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
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
                      10.height,
                      Container(
                        height: 50.0,
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: TextFormField(
                            controller: controller.confirmPasswordController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            autofocus: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Confirm password",
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
                          var name = controller.nameController.text;
                          var mobile = controller.mobileController.text;
                          var email = controller.emailController.text;
                          var address = controller.addressController.text;
                          var password = controller.passwordController.text;
                          var confirmPassword =
                              controller.confirmPasswordController.text;

                          if (name.isEmptyOrNull) {
                            toast("Please enter name");
                            return;
                          }
                          if (mobile.isEmptyOrNull) {
                            toast("Please enter mobile number");
                            return;
                          }
                          if (email.isEmptyOrNull) {
                            toast("Please enter email address");
                            return;
                          }
                          if (address.isEmptyOrNull) {
                            toast("Please enter your address");
                            return;
                          }
                          if (password.isEmptyOrNull) {
                            toast("Please enter login password");
                            return;
                          }

                          if (confirmPassword.isEmptyOrNull) {
                            toast("Please enter password again");
                            return;
                          }

                          if (password != confirmPassword) {
                            toast("Password doesn't match");
                            return;
                          }

                          controller.signUp(name, email, mobile, password,
                              confirmPassword, address);
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
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.0),
                            ),
                          ),
                        ),
                      ),
                      20.height,
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppPages.getLoginRoute());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?'.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            5.width,
                            Text(
                              'Click here'.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ],
        ));
  }
}

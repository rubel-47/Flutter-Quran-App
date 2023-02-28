import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/routes/app_pages.dart';
import 'package:qrf/translations/string_list.dart';
import 'package:qrf/utils/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var lang = prefs.getString("Lang") ?? "bn";
  runApp(MyApp(lang));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.offset
    ..maskType = EasyLoadingMaskType.black;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final String lang;
  MyApp(this.lang);

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Islamic Knowldge',
      builder: EasyLoading.init(),
      theme: ThemeData(
        primarySwatch: materialPrimaryColors,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
            linearTrackColor: Color(0xFFFD41B4),
            color: Color(0xFF6A05FE),
            refreshBackgroundColor: Color(0xFFF37B46)),
      ),
      translations: StringList(),
      locale: lang == "bn"
          ? Locale('bn')
          : lang == "ar"
              ? Locale('ar')
              : Locale('en'),
      fallbackLocale: Locale('bn'),
      initialRoute: AppPages.INITIAL,
      //getPages: AppPages.routes,
      getPages: AppPages.routes,
    );
  }
}

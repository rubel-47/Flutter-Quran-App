import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/providers/hadis/hadis_provider.dart';
import 'package:qrf/routes/app_pages.dart';

import '../providers/quran/ayat_provider.dart';
import '../providers/quran/test_provider.dart';
import 'database/quran_database.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  /* HomeScreen */
  double progress = 0.0;

  late AnimationController animationController;
  late Animation animation;
  late StreamController<double> streamController;
  late Stream<double> stream;
  @override
  onInit() {
    animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this);

    animation = Tween<double>(begin: 0, end: 1).animate(animationController)
      ..addListener(() {
        // update like setState
        streamController.sink.add(animation.value);
      });

    animationController.forward().whenComplete(() {
      _redirectToPage();
    });

    streamController = StreamController();
    stream = streamController.stream;
    post_to_db();
    post_to_db_allayat();
    post_to_db_allHadis();
    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  _redirectToPage() async {
    animationController.stop();
    Get.offAllNamed(AppPages.getHomeRoute());
  }
  void post_to_db() async {

    final cnt=await DBProvider.db.getCount('Surah');
    if(cnt==0)
      {
        final suraList = await SurahApiProvider().getallSurah();
        await DBProvider.db.createSurah(suraList.toList());

      }
    print(cnt.toString()+"Surah_Table");

  }
  void post_to_db_allayat() async
  {
    final cnt=await DBProvider.db.getCount('Ayat');
    if(cnt==0)
      {
        final _ayats= await AyatProvider().getAllAyat();
        await DBProvider.db.createAyat(_ayats.toList());
      }
    print(cnt.toString()+"Ayat-table");




  }
  void post_to_db_allHadis() async
   {
     final cnt=await DBProvider.db.getCount('Hadis');
     if(cnt==0)
       {
         final _hadis = await HadisProvider().getallHadis();
         await DBProvider.db.createHadis(_hadis.toList());
       }
     print(cnt.toString()+"Hadis-Table");

  }

}

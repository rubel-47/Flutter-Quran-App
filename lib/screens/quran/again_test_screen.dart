import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/controllers/surah_controller.dart';
import 'package:qrf/model/quran/ayat_list.dart';
import 'package:qrf/providers/quran/ayat_provider.dart';
import 'package:qrf/providers/quran/ayat_provider_offline.dart';

import '../../controllers/database/quran_database.dart';
import '../../model/quran/surah_list.dart';
import '../../providers/quran/test_provider.dart';
import '../../routes/app_pages.dart';
import '../../utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/controllers/surah_controller.dart';
import 'package:qrf/routes/app_pages.dart';
import 'package:qrf/screens/quran/again_test_screen.dart';
import 'package:qrf/utils/color.dart';
import 'package:qrf/utils/widgets.dart';
import 'package:qrf/model/quran/surah_list.dart';
import 'package:qrf/controllers/ayat_controller.dart';

var isLoading=true;
class HomePage1 extends StatefulWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage1> {
  @override
  List<Surah> _surah=[];
  List<Ayat> ayatList=[];


  void initState() {
    // TODO: implement initState

    post_ayat_to_db();
    _refreshSurah();

    super.initState();
  }

  //**********************Insert ayat to database***********************************
  void post_ayat_to_db() async
  {

    var apiProvider=AyatProviderOffline();

    for(int i=1;i<=114;i++)
      {
        //toast(i.toString());

          final temp=await apiProvider.getAyatBySurahoffline(i);
         // toast(temp.toString());

          ayatList.add(Ayat.fromJson(temp));
      }
    //toast("TestTest");
    ayatList.forEach((element) {
      //toast("ami ayat");
     // toast(element.toString());
     // DBProvider.db.createAyat(element);

    });



  }
  //***************Get Surah From Database**********************************
  void _refreshSurah() async
  {
    DBProvider.db.getSurah().then((value){
      value.forEach((element) {
        setState(() {
          _surah.add(Surah.fromJson(element));
         // print(_surah.length.toString());
        });
      });
      // print(_surah.length.toString());

    });
    //  toast(_surah.length.toString());

  }
  //*************************************************************************


  @override

  //return suraList;


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("offline database"),
        ),
        body:Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/app_bg.png'), fit: BoxFit.cover),
              ),
            ),
            Column(
              children: [

                /* Container(
                  height: 40.0,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
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
                        ),
                        Center(
                          child: Text(
                            'Al Quran'.toUpperCase(),
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
                Container(
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                      Container(
                        height: 40.0,
                        width: 160.0,
                        child: TextFormField(
                           // controller: controller.suraNameController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            style: TextStyle(fontSize: 12.0, color: Colors.black),
                            decoration: InputDecoration(
                              hintText: "Surah Name",
                              contentPadding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                              labelStyle: TextStyle(color: black, fontSize: 15.0, fontWeight: FontWeight.normal),
                              hintStyle: TextStyle(color: black, fontSize: 15.0, fontWeight: FontWeight.normal),
                              filled: true,
                              fillColor: Colors.grey[400],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(color: surahBgColor, width: 0.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(color: surahBgColor, width: 0.0),
                              ),
                            )),
                      ),
                      Container(
                        height: 40.0,
                        width: 160.0,
                        child: TextFormField(
                           // controller: controller.ayatNumberController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            autofocus: false,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            style: TextStyle(fontSize: 12.0, color: Colors.black),
                            decoration: InputDecoration(
                              hintText: "Ayat Number",
                              contentPadding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                              labelStyle: TextStyle(color: black, fontSize: 15.0, fontWeight: FontWeight.normal),
                              hintStyle: TextStyle(color: black, fontSize: 15.0, fontWeight: FontWeight.normal),
                              filled: true,
                              fillColor: Colors.grey[400],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(color: surahBgColor, width: 0.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(color: surahBgColor, width: 0.0),
                              ),
                            )),
                      ),
                      InkWell(
                         /* onTap: () {
                            var keyword = controller.suraNameController.text;
                            if (keyword.isEmptyOrNull) {
                              toast('Please enter a keyword');
                              return;
                            }
                            //controller.suraNameController.clear();
                            //controller.ayatNumberController.clear();
                            *//*Get.toNamed(AppPages.getAyatSearchRoute(), arguments: [
                              {"keyword": keyword}
                            ]);*//*
                          },*/
                          child: Image.asset('assets/images/search_icon.png')),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                      child: ListView.builder(
                          itemCount: _surah.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            String lang = Get.locale.toString();
                            var surah=_surah[index];
                          // var surah = controller.surahList[index];
                            return InkWell(
                              onTap: () {
                                Get.toNamed(
                                  AppPages.getAyatRoute(),
                                  arguments: [
                                    {"surah_id": "${surah.id}"},
                                    {"total_ayat_en": surah.totalAyatEn},
                                    {"total_ayat_bn": surah.totalAyatBn},
                                    {"total_ayat_ar": surah.totalAyatAr},
                                    {"surah_type_en": surah.suraTypeEn},
                                    {"surah_type_bn": surah.suraTypeBn},
                                    {"surah_type_ar": surah.suraTypeAr},
                                     {"surah_list": _surah},

                                  ],
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  color: surahBgColor,
                                  height: 50.0,
                                  child: Row(
                                    children: <Widget>[
                                      15.width,
                                      Container(
                                          width: 40.0,
                                          child: Text(
                                            '${index + 1}',
                                            style: TextStyle(fontSize: 17.0),
                                          )),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${lang == 'en' ? surah.nameEn : lang == 'bn' ? surah.nameBn : surah.nameAr}',
                                              style: TextStyle(fontSize: 17.0),
                                            ),
                                            Html(
                                              data: '${surah.nameAr}',
                                              shrinkWrap: true,
                                              style: {
                                                "p": Style(
                                                    padding: EdgeInsets.only(right: 10.0),
                                                    fontFamily: 'Quran Font',
                                                    wordSpacing: 10,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: FontSize.rem(1.8),
                                                    textAlign: TextAlign.right,
                                                    whiteSpace: WhiteSpace.NORMAL,
                                                    display: Display.BLOCK)
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      15.width,
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),

              ],
            ),
          ],
        ),);







      /*Center(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _surah.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  margin: EdgeInsets.all(4),
                  //  color: Colors.amber[colorCodes[index]],
                  child: Center(child: Text('${_surah[index].id.toString()}'+".     "+'${_surah[index].nameEn.toString()}'))
                );
              }
          ),
        )*/


  }
}

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrf/controllers/ayat_controller.dart';
import 'package:qrf/controllers/test_controller.dart';
import 'package:qrf/model/quran/surah_list.dart';
import 'package:qrf/routes/app_pages.dart';
import 'package:qrf/screens/dialogs/details_dialog.dart';
import 'package:qrf/screens/dialogs/tafsir_dialog.dart';
import 'package:qrf/screens/quran/all_ayats_single_surah_offline.dart';
import 'package:qrf/utils/color.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qrf/utils/widgets.dart';
import 'package:html/parser.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qrf/controllers/surah_controller.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/rendering.dart';

import 'package:qrf/screens/quran/ayat_screen.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';

import '../../controllers/database/quran_database.dart';
import '../../model/quran/ayat_list.dart';
import '../../model/quran/modified_ayat_list.dart';
import '../../providers/quran/ayat_provider.dart';
class TestScreen extends StatefulWidget {

  final  surahId;
  final  ayatNumber;
  Surah surahDetails;

  TestScreen({Key? key,this.surahId,this.ayatNumber, required this.surahDetails}) : super(key: key);


  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final TextEditingController _Notecontroller = TextEditingController();

  notesDialog(var context, String surahId, String ayatId, String type) {

    String country_id;
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0.0,
              backgroundColor: Colors.white,
              clipBehavior: Clip.antiAlias,
              child: Container(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  10.height,
                  Text('Save with a note', style: TextStyle(
                      fontSize: 17.0, fontWeight: FontWeight.bold)),
                  10.height,
                  Container(
                    margin: EdgeInsets.all(5.0),
                    height: 40.0,
                    child: TextFormField(
                        controller:_Notecontroller ,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: TextStyle(fontSize: 12.0, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Write a note..",
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                          labelStyle: TextStyle(color: black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal),
                          hintStyle: TextStyle(color: black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal),
                          filled: true,
                          fillColor: Colors.grey[400],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                                color: surahBgColor, width: 0.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                                color: surahBgColor, width: 0.0),
                          ),
                        )),
                  ),
                  20.height,
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              color: Colors.red,
                              height: 40.0,
                              child: Center(
                                child: Text('Cancel', style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              var notes = _Notecontroller.text;
                              if (notes.isEmptyOrNull) {
                                toast('Please enter a note');
                                return;
                              }

                              _Notecontroller.clear();

                              // var userId = controller.userData.id;
                              /*  controller.addNote(
                                    userId.toString(), surahId, ayatId, type,
                                    notes);*/
                              Get.back();

                              toast('Please login to save note');
                              Get.back();
                              Get.toNamed(AppPages.getLoginRoute());

                            },
                            child: Container(
                              color: Colors.green,
                              height: 40.0,
                              child: Center(
                                child: Text('Save', style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ]),
              )),
    );
  }
   modifiedAyat ayat=new modifiedAyat();
  AudioPlayer audioPlayer = AudioPlayer();
  var isPlayerReadyToPlay = false;
  var isDownloadingstart = false;
  var localFilePath;

  var isPlayingAudio = false;
  var playPauseIcon = 'assets/images/player_play_icon.png';
  var playIcon = 'assets/images/player_play_icon.png';
  var pauseIcon = 'assets/images/player_pause_icon.png';
  var isVisiblePlayBg = false;
   List<Surah> _surah=[];
   var ayatNumbers = List<int>.empty(growable: true).obs;
   bool _isVisible = false;
   bool _isPlayerVisible=false;
   List<AyatWordBank> _wordBank=[];
   List<AyatTafsir> _tafsirBank=[];
  bool _ischoseAudioVisible=false;



  @override
  Widget build(BuildContext context) {
    dynamic _selectedsurah=0;
    dynamic _selectedayat=0;
    return  Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
          title:  Row(
            children: [
              Text("Al Quran"),
              SizedBox(width: 100,),


            ],
          )
      ),
      body:  Scaffold(
        body:   Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/app_bg.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  height: 80,
                  width: double.infinity,
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(0),
                    // Image radius
                    child: Image.asset(
                      'assets/images/surah_bar.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(20, 05, 10, 10),
                  child: Text(
                    _parseHtmlString(
                        widget.surahDetails.nameAr.toString().trim()),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(200, 12, 10, 10),
                  child: Text(
                    widget.surahDetails.nameEn.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(10, 50, 10, 10),
                  child: Text(
                    "Ayat : " + widget.surahDetails.totalAyatEn.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(100, 50, 10, 10),
                  child: Text(
                    widget.surahDetails.suraTypeEn.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(185, 50, 0, 10),
                  child: Text(
                    "Ruku : "+widget.surahDetails.totalAyatEn.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(280, 50, 0, 10),
                  child: Text(
                    "Para : "+widget.surahDetails.id.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
              ],

            ),
            Visibility(
              visible: _isPlayerVisible,
              child: Stack(
                children: [
                  Container(
                    height: 100.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/player_bg.png'),
                          fit: BoxFit.cover),
                    ),
                    child: Stack(
                      children: [
                      InkWell(
                        child:
                        Padding(
                          padding: const EdgeInsets.only(left: 315,top: 2),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.red),
                            height: 35.0,
                            padding: EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onTap: ()
                          {
                            setState(() {
                              _isPlayerVisible=false;
                            });
                          }

                      ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {

                                      toast("No previous ayat");
                                       return;

                                  });

                                },
                                child: Image.asset(
                                    'assets/images/player_back_forward_icon.png'),
                              ),

                              isPlayingAudio?Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, top: 10, right: 25,bottom: 10),
                                child: InkWell(
                                  onTap: () {

                                    setState(() {
                                      audioPlayer.release();
                                      isPlayingAudio=false;
                                      _ischoseAudioVisible=false;

                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Image.asset(
                                        'assets/images/player_pause_icon.png'),
                                  ),
                                ),
                              ):Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, top: 10, right: 25,bottom: 10),
                                child: InkWell(
                                  onTap: () {
                                    //toast(isPlayingAudio.toString());
                                    if(isPlayingAudio)
                                    {
                                      //toast("hello");

                                      setState(() {
                                        _ischoseAudioVisible=false;

                                      });

                                    }
                                    else{
                                     // toast("else");
                                      setState(() {
                                        _ischoseAudioVisible=true;
                                      });
                                    }

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Image.asset(
                                        'assets/images/player_play_icon.png'),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {

                                      toast("No next ayat");
                                        return;
                                  }
                                  );


                                },
                                child: Image.asset(
                                    'assets/images/player_fast_forward_icon.png'),
                              ),
                            ]
                        ),
                        Visibility(
                          visible: _ischoseAudioVisible,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) =>
                                    Dialog(
                                        shape:
                                        RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius
                                              .circular(16),
                                        ),
                                        elevation: 0.0,
                                        backgroundColor:
                                        Colors.white,
                                        clipBehavior: Clip
                                            .antiAlias,
                                        child: Container(
                                          child: Column(
                                              mainAxisSize:
                                              MainAxisSize
                                                  .min,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .center,
                                              children: [
                                                Container(
                                                  height:
                                                  60.0,
                                                  child:
                                                  Stack(
                                                    children: [
                                                      Center(
                                                        child: Text('Choose audio type', style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 5.0),
                                                        child: Align(
                                                            alignment: Alignment.centerRight,
                                                            child: InkWell(
                                                              onTap: () {

                                                                Get.back();
                                                              },
                                                              child: Container(
                                                                height: 40.0,
                                                                width: 40.0,
                                                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                                                child: Center(
                                                                  child: Icon(Icons.close, color: Colors.white),
                                                                ),
                                                              ),
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                10.height,
                                                InkWell(
                                                  onTap:
                                                      () {
                                                    if(isPlayingAudio==false)
                                                      {
                                                        setState(() {
                                                          isPlayingAudio=true;
                                                        });
                                                      }else{
                                                      isPlayingAudio=false;

                                                    }
                                                    Get.back();
                                                    getAllAudio(ayat.audio_bn.toString());


                                                  },
                                                  child:
                                                  Container(
                                                    alignment:
                                                    Alignment.center,
                                                    height:
                                                    40.0,
                                                    width:
                                                    150.0,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5.0),
                                                        color: Colors.grey[300]),
                                                    child: Text(
                                                        'Bangla',
                                                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                                  ),
                                                ),
                                                10.height,
                                                InkWell(
                                                  onTap:
                                                      () {
                                                    setState(() {
                                                      isPlayingAudio=!isPlayingAudio;
                                                    });
                                                    Get.back();
                                                    getAllAudio(ayat.audio_en.toString());

                                                  },
                                                  child:
                                                  Container(
                                                    alignment:
                                                    Alignment.center,
                                                    height:
                                                    40.0,
                                                    width:
                                                    150.0,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5.0),
                                                        color: Colors.grey[300]),
                                                    child: Text(
                                                        'English',
                                                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                                  ),
                                                ),
                                                10.height,
                                                InkWell(
                                                  onTap:
                                                      () {
                                                    setState(() {
                                                      isPlayingAudio=!isPlayingAudio;
                                                    });
                                                    Get.back();
                                                    getAllAudio(ayat.audio_ar.toString());

                                                  },
                                                  child:
                                                  Container(
                                                    alignment:
                                                    Alignment.center,
                                                    height:
                                                    40.0,
                                                    width:
                                                    150.0,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5.0),
                                                        color: Colors.grey[300]),
                                                    child: Text(
                                                        'Arabic',
                                                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                                  ),
                                                ),
                                                10.height,
                                              ]),
                                        )),
                              );

                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 8.0,
                                  right: 8.0,
                                  top: 8.0,
                                  bottom: 8.0),
                              child: Container(),
                            ),
                          ),
                        ),

                      ],

                    ),
                  ),



                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: double.infinity,
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(0),
                        // Image radius
                        child: Image.asset('assets/images/quran_bismillah_bg.png',
                            fit: BoxFit.fill),
                      ),
                    ),
                    10.height,
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 1,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: _getSingleAyat),

                  ],
                ),
              ),
            ),
          ],
        ),


        ),





    );
  }

  @override
  void initState() {

    _getAyat();
    _refreshSurah();
    super.initState();

  }
   void _refreshSurah() async
   {
     await DBProvider.db.getSurah().then((value){
       value.forEach((element) {
         setState(() {
           _surah.add(Surah.fromJson(element));
         });
       });


     });



   }



  Future<void> _getAyat() async {

    final result=await DBProvider.db.getselectedAyats(widget.surahId,widget.ayatNumber);
       setState(() {
         ayat=result;
         //******************for word bank************
         Iterable temp=jsonDecode(ayat.ayat_word_bank.toString());
         _wordBank=temp.map((e) => AyatWordBank.fromJson(e)).toList();
         //*****************for tafsir***************
         Iterable temp1=jsonDecode(ayat.ayat_tafsir.toString());
         _tafsirBank=temp1.map((e) => AyatTafsir.fromJson(e)).toList();

       });

  }
//******************************Convert html to String**************************
   String _parseHtmlString(String htmlString) {
     final document = parse(htmlString);
     final String parsedString = parse(document.body?.text).documentElement!
         .text;

     return parsedString;
   }
   Widget _getSingleAyat(BuildContext context, int position) {


     return GestureDetector(
       onLongPress: () {

       },
       child: Column(
         children: [
      /*   Visibility(
         visible: _isPlayerVisible,
         child: Padding(
           padding: EdgeInsets.all(8.0),
           child: Container(
             decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/surah_frame.png'), fit: BoxFit.cover)),
             height: 80.0,
             child: Center(
               child: Stack(
                 children: <Widget>[
                   Align(
                     alignment: Alignment.center,
                     child: Image.asset('assets/images/surah_frame_center.png'),
                   ),
                   Align(
                     alignment: Alignment.center,
                     child: Padding(
                       padding: const EdgeInsets.only(bottom: 15.0),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: <Widget>[
                           Container(
                             height: 40.0,
                             child: Html(
                               data: widget.surahDetails.nameEn.toString(),
                               shrinkWrap: true,
                               style: {
                                 "p": Style(
                                     padding: EdgeInsets.only(right: 10.0),
                                     fontFamily: 'Quran Font',
                                     fontWeight: FontWeight.bold,
                                     fontSize: FontSize.rem(1.5),
                                     textAlign: TextAlign.right,
                                     whiteSpace: WhiteSpace.NORMAL,
                                     display: Display.BLOCK)
                               },
                             ),
                           ),
                           Text(widget.surahDetails.nameBn.toString(),
                               style: TextStyle(fontSize: 12.0, fontFamily: 'Bangla Font', fontWeight: FontWeight.bold)),
                         ],
                       ),
                     ),
                   ),
                   Positioned(
                       top: 17,
                       left: 25,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           Row(
                             children: [
                               Text('সুরাঃ',
                                   style: TextStyle(
                                       color: Colors.grey.shade200, fontFamily: 'Bangla Font', fontSize: 15.0, fontWeight: FontWeight.bold)),
                               5.width,
                               Text(widget.surahDetails.id.toString(),
                                   style: TextStyle(color: Colors.grey.shade200, fontSize: 15.0, fontWeight: FontWeight.bold)),
                             ],
                           ),
                           5.height,
                           Row(
                             children: [
                               Text('আয়াতঃ',
                                   style: TextStyle(
                                       color: Colors.grey.shade200, fontFamily: 'Bangla Font', fontSize: 15.0, fontWeight: FontWeight.bold)),
                               5.width,
                               Text(widget.surahDetails.totalAyatBn.toString(),
                                   style: TextStyle(
                                       color: Colors.grey.shade200, fontFamily: 'Bangla Font', fontSize: 15.0, fontWeight: FontWeight.bold)),
                             ],
                           ),
                         ],
                       )),
                   Positioned(
                       top: 17,
                       right: 25,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           Row(
                             children: [
                               Text(widget.surahDetails.suraTypeBn.toString(),
                                   style: TextStyle(
                                       color: Colors.grey.shade200, fontFamily: 'Bangla Font', fontSize: 15.0, fontWeight: FontWeight.bold)),
                             ],
                           ),
                           5.height,
                           Row(
                             children: [
                               Text('রুকুঃ',
                                   style: TextStyle(
                                       color: Colors.grey.shade200, fontFamily: 'Bangla Font', fontSize: 15.0, fontWeight: FontWeight.bold)),
                               5.width,
                               Text(ayat.rukuNumber.toString(),
                                   style: TextStyle(color: Colors.grey.shade200, fontSize: 15.0, fontWeight: FontWeight.bold)),
                             ],
                           ),
                         ],
                       )),
                 ],
               ),
             ),
           ),
         ),
       ),*/

            Visibility(
              visible: _isVisible,
              child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [

                 Container(
                   height: 40.0,
                   width: Get.width * 0.8,
                   padding: EdgeInsets.all(5.0),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(20.0),
                     color: Colors.white,
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       InkWell(
                         onTap: () {

                           showDialog(
                               context: context,
                               builder: (context) {
                                 return Padding(
                                   padding: const EdgeInsets.all(10.0),
                                   child:Dialog(
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
                                                 Padding(
                                                   padding: const EdgeInsets.all(8.0),
                                                   child: Text(
                                                     'যুগের জ্ঞানের আলোকে মৌলিক তাফসীর',
                                                     style: TextStyle(
                                                         fontSize: 15.0, fontWeight: FontWeight.bold),
                                                   ),
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
                                                         if(ayat.ayaNumber==1)
                                                           {
                                                             toast("No previous ayat");
                                                             return;
                                                           }
                                                         setState(() {
                                                           var next=ayat.ayaNumber;
                                                           next=next!+1;
                                                           ayat.ayaNumber=next;
                                                           toast(ayat.ayaNumber.toString());
                                                         }
                                                         );



                                                       }
                                                       ),
                                                       child: Container(
                                                           color: Colors.grey[300],
                                                           padding: EdgeInsets.all(5.0),
                                                           child: Icon(Icons.keyboard_double_arrow_left)
                                                       ),
                                                     ),
                                                     Container(
                                                       child: Text('${ayat.suraNameBn} : ${ayat.ayaNumber}'),
                                                     ),
                                                     InkWell(
                                                       onTap: (() async {




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
                                                   child:  SingleChildScrollView(
                                                     child: Column(
                                                       children: List.generate(
                                                           _tafsirBank.length ?? 0, (index) {
                                                         //var tafsirList = _tafsirBank;
                                                         AyatTafsir word = new AyatTafsir();
                                                         return Padding(
                                                           padding: const EdgeInsets.all(8.0),
                                                           child: Column(
                                                             crossAxisAlignment: CrossAxisAlignment.center,
                                                             children: [
                                                               Container(
                                                                 child:  Text(_parseHtmlString(_tafsirBank[index].tafsirBn.toString()))
                                                               ),

                                                             ],
                                                           ),
                                                         );
                                                       }),
                                                     ),
                                                   ),
                                                 )
                                               ],
                                             ),
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),

                                 );
                               });

                         },
                         child: Image.asset(
                           'assets/images/option_bookmark_icon.png',
                           height: 30.0,
                           width: 30.0,
                         ),
                       ),
                       InkWell(
                         onTap: () {
                            showDialog(
                            context:context,
                             builder:(context) {
                              return Padding(padding: EdgeInsets.all(10.0),
                               child:Dialog(
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
                                           BoxDecoration(shape: BoxShape.circle,
                                               color: Colors.red),
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
                                           borderRadius: BorderRadius.circular(
                                               20.0),
                                           image: DecorationImage(
                                               image: AssetImage(
                                                   'assets/images/dialog_bg.png'),
                                               fit: BoxFit.cover),
                                         ),
                                         child: Column(
                                           children: <Widget>[
                                             10.height,
                                             Text(
                                               "[Details]",
                                               style: TextStyle(
                                                   fontSize: 15.0,
                                                   fontWeight: FontWeight.bold),
                                             ),
                                             10.height,
                                             VerticalLine(),
                                             10.height,
                                             Container(
                                               margin: EdgeInsets.all(10.0),
                                               decoration: BoxDecoration(
                                                   borderRadius: BorderRadius
                                                       .circular(20.0),
                                                   color: Colors.grey[100]),
                                               child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment
                                                     .center,
                                                 children: [
                                                   Html(
                                                     data: ayat.nameAr,
                                                     shrinkWrap: true,
                                                     style: {
                                                       "p": Style(
                                                           fontWeight: FontWeight
                                                               .bold,
                                                           textAlign: TextAlign
                                                               .center,
                                                           fontSize: FontSize
                                                               .xLarge)
                                                     },
                                                   ),
                                                   10.height,
                                                   Container(
                                                       padding: EdgeInsets.only(
                                                           left: 5.0,
                                                           bottom: 10.0),
                                                       child: Text(
                                                         '${ayat.nameBn}',
                                                         textAlign: TextAlign
                                                             .center,
                                                         style: TextStyle(
                                                             fontSize: 17.0),
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
                                               margin: EdgeInsets.only(
                                                   left: 10.0, right: 10.0),
                                               padding: EdgeInsets.all(5.0),
                                               decoration: BoxDecoration(
                                                 borderRadius: BorderRadius
                                                     .circular(20.0),
                                                 color: Colors.white,
                                               ),
                                               child: Row(
                                                 mainAxisAlignment: MainAxisAlignment
                                                     .spaceEvenly,
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
                                                       _wordBank.length ?? 0, (index) {
                                                     var wordList = _wordBank;
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
                                                         Text('${word.translateEn}',
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
                               ),
                              );
                             });

                         },
                         child: Image.asset(
                           'assets/images/option_bracket_icon.png',
                           height: 30.0,
                           width: 30.0,
                         ),
                       ),
                       InkWell(
                         onTap: () {
                           showConfirmDialogCustom(
                               context,
                               title: "Do you want to bookmark this ayat?",
                               dialogType: DialogType.CONFIRMATION,
                               onAccept: (context) {

                                 toast('Please login to add bookmark');
                                 Get.back();
                                 Get.toNamed(AppPages.getLoginRoute());

                               }

                           );

                         },
                         child: Image.asset(
                           'assets/images/option_flag_icon.png',
                           height: 30.0,
                           width: 30.0,
                         ),
                       ),
                       InkWell(
                         onTap: () {
                           notesDialog(context, widget.surahDetails.id.toString(), ayat.id.toString(), "Note");

                         },
                         child: Image.asset(
                           'assets/images/option_ok_icon.png',
                           height: 30.0,
                           width: 30.0,
                         ),
                       ),
                       InkWell(
                         onTap: () {
                          setState(() {
                            _isPlayerVisible=!_isPlayerVisible;
                          });




                         },
                         child: Image.asset(
                           'assets/images/option_play_icon.png',
                           height: 30.0,
                           width: 30.0,
                         ),
                       ),
                       InkWell(
                         onTap: () {
                           Clipboard.setData(new ClipboardData(text: ayat.nameEn)).then((_){
                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ayat.nameEn.toString())));
                           });

                         },
                         child: Image.asset(
                           'assets/images/option_read_icon.png',
                           height: 30.0,
                           width: 30.0,
                         ),
                       ),
                       InkWell(
                         onTap: () async {
                           final RenderObject? box = context.findRenderObject();
                           {
                             await Share.share(ayat.nameEn,
                             );
                           }

                         },
                         child: Image.asset(
                           'assets/images/option_share_icon.png',
                           height: 30.0,
                           width: 30.0,
                         ),
                       ),
                     ],
                   ),
                 ),
                 5.width,
                 InkWell(
                   onTap: () {

                     setState(() {
                       _isPlayerVisible=false;
                       _isVisible=false;
                     });


                   },
                   child: Container(
                     decoration: BoxDecoration(
                         shape: BoxShape.circle, color: Colors.red),
                     height: 35.0,
                     padding: EdgeInsets.all(5.0),
                     child: Icon(
                       Icons.close,
                       color: Colors.white,
                     ),
                   ),
                 ),
               ],
           ),
            ),
               //: Container(),
           Container(
             width: Get.width,
             margin: EdgeInsets.all(10.0),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20.0),
               color: surahBgColor,
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 10.height,
                 Row(
                   children: [

                     10.width,
                     InkWell(

                       onTap:  () {
                         setState(() {
                           _isVisible=!_isVisible;

                         });

                       },
                       child: Container(
                         decoration: BoxDecoration(
                             shape: BoxShape.circle, color: brownColor),
                         height: 35.0,
                         padding: EdgeInsets.all(5.0),
                         child: Icon(
                           Icons.more_horiz_rounded,
                           color: Colors.black,
                         ),
                       ),
                     ),
                   ],
                 ),

                 Container(
                   alignment: Alignment.centerRight,
                   margin: EdgeInsets.only(right: 3.0),
                   child: Html(
                     data: ayat.nameAr.toString(),
                     shrinkWrap: true,
                     style: {
                       "p": Style(
                           fontWeight: FontWeight.bold,
                           fontSize: FontSize.rem(1.6),
                           textAlign: TextAlign.right,
                           direction: TextDirection.rtl,
                           whiteSpace: WhiteSpace.NORMAL,
                           display: Display.BLOCK)
                     },
                   ),
                 ),
                 10.height,
                 Container(
                     padding: EdgeInsets.only(left: 5.0, bottom: 10.0),
                     child: Text(
                       ayat.nameEn.toString(),
                       style: TextStyle(
                           fontSize: 17.0, fontWeight: FontWeight.w400),
                     )),
                 5.height,
                 Container(
                     padding: EdgeInsets.only(left: 5.0, bottom: 10.0),
                     child: Text(
                       ayat.nameBn.toString(),
                       style: TextStyle(
                           fontSize: 17.0, fontWeight: FontWeight.w400),
                     )),
               ],
             ),
           ),
         ],
       ),
     );
   }
   void getAyatNumbers(int totalAyat){

     ayatNumbers.clear();

     for(int i=1;i<=totalAyat;i++)
     {
       ayatNumbers.add(i);
     }

   }

  Future<dynamic> getAllAudio(String audiourl) async {
    var client = http.Client();

    try {

      var final_url=url+audiourl;
      //print(final_url);
      var response = await client.get(
        Uri.parse(final_url),
        headers: {"Accept": "application/json", "$API_KEY": "$API_SECRET"},
      );

      if (response.statusCode == 200) {

        loadAudio(final_url, "rubel");
        // return response.body;
      } else {
        return Future.error("Something went wrong");
      }
    } catch (Exception) {
      return Future.error("Something went wrong");
    }


  }
  playAudio() async {
    var result = await audioPlayer.play(localFilePath!);
    if (result == 1) {


    }



  }
  loadAudio(String url, String audioName) async {
    final bytes = await readBytes(Uri.parse(url));
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$audioName.mp3');

    await file.writeAsBytes(bytes);
    if (file.existsSync()) {
      localFilePath = file.path;
      var connectivityResult = await (Connectivity().checkConnectivity());
      print(connectivityResult);
      playAudio();
    }
  }
}


/*
class TestScreen extends GetView<TestController> {
  late modifiedAyat ayat;
  Future<void> onInit()
  async {
    _getAyat();

  }
  var result;
  @override
  Widget build(BuildContext context) {


    bool IsLoading=false;



    return Scaffold(

        appBar: AppBar(
          title: Text("Searched Ayats"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),

        body: Stack(
          children: <Widget>[
            new Container(
              height: 800,
              decoration: new BoxDecoration(
                image: new DecorationImage(image: new AssetImage("assets/images/home_bg.png"), fit: BoxFit.cover,),
              ),
            ),
            Center(
              child: Container(
                child:  IsLoading ? Center(
                  child: CircularProgressIndicator(),
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Text(list.toString()),
                    Text("SuraId : "+controller.surahId),
                    Text("Ayatnum : "+controller.ayatnum),
                    Text(ayat.nameBn.toString()),
                    Text(ayat.nameBn.toString()),
                    Text(ayat.nameBn.toString())

                    ]



                ),


    ),
            )
              ]
              )
    );




  }
  Future<List<String>?> getallAyat() async {
    List<String> list=[];


    //toast("First "+list.length.toString() );
    var endpointUrl = 'http://139.180.156.187:92/api/quran/sura/ayat';
    var client = http.Client();
    Iterable surahList;

    Map<String, String> header = {
      'x-api-key': "3R5TWxA0GAn04EQ42haCnYtFxeRlV08yMi5o",
    };
    Map<String, dynamic> queryParams = {
      'sura_id': controller.surahId,
      'ayat_no': controller.ayatnum
    };
    Uri uri = Uri.parse(endpointUrl);
    final finalUri = uri.replace(queryParameters: queryParams);
   // print(finalUri);
    final response = await client.get((finalUri), headers: header);
    // print(response.body);
    // toast(response.statusCode.toString());
    var JsonData=jsonDecode(response.body);
    */
/* print(JsonData['name_bn']);
    print(JsonData['name_ar']);
    print(JsonData['name_en']);*//*


    list.add(JsonData['name_bn']);
    list.add(JsonData['name_ar']);
    list.add(JsonData['name_en']);
    // toast("This fun is called");
    //toast(list.length.toString());
    //toast("List value : "+list.toString());
    //toast("List Length: "+list.length.toString());


     print(list[0].toString());
    print(list[1].toString());
    print(list[2].toString());

  }

  Future<void> _getAyat() async {
    final result=await DBProvider.db.getselectedAyats(controller.surahId,controller.ayatnum);
    setState
    ayat=result;

  }
*/
/*
  Future<List<Surah>> rubel() async
  {
    Map<String, dynamic> queryParams = {
      'sura_id': controller.surahId,
      'ayat_no': controller.ayatnum
    };

    Map<String, String> header = {
      'x-api-key': "3R5TWxA0GAn04EQ42haCnYtFxeRlV08yMi5o",
    };

    Uri uri = Uri.parse(endpointUrl);
    final finalUri = uri.replace(queryParameters: queryParams);
    print(finalUri);

    final response = await http.get(finalUri, headers: header);
    final JsonData = jsonDecode(response.body);
    print(JsonData);


    List<Surah> list = [];
    for (var data in JsonData) {
      toast("Hello");

      Surah surah = Surah(
          nameEn: data["nameEn"],
          nameBn: data["nameBn"],
          nameAr: data["nameAr"]
      );
      list.add(surah);
    }
    return list;
  }*/









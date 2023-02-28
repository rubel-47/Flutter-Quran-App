import 'package:audioplayers/audioplayers.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';

import '../../controllers/database/quran_database.dart';
import '../../model/quran/modified_ayat_list.dart';
import '../../model/quran/surah_list.dart';
import '../../utils/color.dart';
import 'package:html/parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';

import 'package:qrf/routes/app_pages.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qrf/utils/widgets.dart';
import 'package:flutter/services.dart';

import '../../model/quran/ayat_list.dart';

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as http;
import 'package:qrf/controllers/test_controller.dart';

import '../../utils/constant.dart';
import 'single_ayat_screen_offline.dart';

List<String> list = [];
var endpointUrl = 'http://139.180.156.187:92/api/quran/sura/ayat';
var selectedAudio;
const audio_base_url='http://139.180.156.187:92';
final audio_end_url="all-praise-is-due-to-allah,-lord-of-the-worlds1649840438.m4a";
var url=ApiConstants.audio_base_url;

class SingleSurah extends StatefulWidget {
  Surah surahDetails;

  SingleSurah({Key? key, required this.surahDetails}) : super(key: key);

  @override
  State<SingleSurah> createState() => _SingleSurahState();
}

class _SingleSurahState extends State<SingleSurah> {
  final TextEditingController _Notecontroller = TextEditingController();

  modifiedAyat selectedAudioAyat= new modifiedAyat();

  notesDialog(var context, String surahId, String ayatId, String type) {
    String country_id;
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          clipBehavior: Clip.antiAlias,
          child: Container(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              10.height,
              Text('Save with a note',
                  style:
                      TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
              10.height,
              Container(
                margin: EdgeInsets.all(5.0),
                height: 40.0,
                child: TextFormField(
                    controller: _Notecontroller,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(fontSize: 12.0, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Write a note..",
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
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: surahBgColor, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: surahBgColor, width: 0.0),
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
                            child: Text('Cancel',
                                style: TextStyle(
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
                            child: Text('Save',
                                style: TextStyle(
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

  modifiedAyat ayat = new modifiedAyat();
  List<modifiedAyat> _ayat = [];
  List<Surah> _surah = [];
  var ayatNumbers = List<int>.empty(growable: true).obs;
  bool _isVisible = false;
  bool _isPlayerVisible = false;
  bool _ischoseAudioVisible=false;
  bool isPlayingAudio=true;
  var localFilePath;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();

  //List<AyatWordBank> _wordBank=[];
  List<AyatTafsir> _tafsirBank = [];
  List<bool> _isVisibleButton = [];
  var playPauseIcon = 'assets/images/player_play_icon.png';
  var playIcon = 'assets/images/player_play_icon.png';
  var pauseIcon = 'assets/images/player_pause_icon.png';

  //get all ayat
  getallAyat() async {
    await DBProvider.db.getAyat(widget.surahDetails.id!).then((value) {
      value.forEach((element) {
        setState(() {
          _ayat.add(modifiedAyat.fromJson(element));
        });
      });

    });
  }

  void initState() {
    getallAyat();
    makefalse();
    super.initState();
  }



  makefalse() async {
    for (int i = 1; i <= widget.surahDetails.totalAyatEn!; i++) {
      _isVisibleButton.add(false);
    }

  }

  @override
  @override
  Widget build(BuildContext context) {
    dynamic previous_surah_id = widget.surahDetails.id;
    dynamic _selectedsurah = 0;
    dynamic _selectedayat = 0;

    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
          title: Row(
        children: [
          Text("Al Quran"),
          SizedBox(
            width: 100,
          ),
          //*************************drop down search*******************************************
          IconButton(
              onPressed: () async {
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                          height: 160,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 25.0),
                                child: Container(
                                  height: 70,
                                  width: 300,
                                  child: DropdownSearch<Surah>(
                                    items: _surah,
                                    itemAsString: (Surah surah) => surah.nameEn.toString(),
                                    dropdownDecoratorProps: DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                        labelText: "Search surah here",
                                        // hintText: "country in menu mode",
                                      ),
                                    ),
                                    onChanged: (surah) async {
                                      _selectedsurah = surah?.id;

                                      setState(() {
                                        _selectedayat = 0;
                                      });
                                      final totalayat = await DBProvider.db
                                          .getselectedSuraAyat(_selectedsurah);
                                      getAyatNumbers(totalayat);
                                    },
                                    //selectedItem: "Brazil",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Container(
                                      height: 60,
                                      width: 170,
                                      child: DropdownSearch<int>(
                                        items: ayatNumbers,
                                        dropdownDecoratorProps:
                                            DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                            labelText: "Search ayat here",
                                          ),
                                        ),
                                        onChanged: (_ayat) {
                                          setState(() {
                                            _selectedayat = _ayat;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                      height: 50,
                                      width: 130,
                                      child: InkWell(
                                        onTap: () {
                                          if (_selectedayat == 0 &&
                                              _selectedsurah == 0) {
                                            toast(
                                                "Please select surah and ayat");
                                            return;
                                          }
                                          if (_selectedayat == 0) {
                                            toast("Invalid ayat number");
                                            return;
                                          }
                                          if (_selectedsurah == 0) {
                                            toast("Please select a surah");
                                            return;
                                          }

                                          if (_selectedayat != 0 &&
                                              _selectedsurah != 0) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => TestScreen(surahId: _selectedsurah, ayatNumber: _selectedayat, surahDetails: _surah.elementAt(_selectedsurah - 1),
                                                      )),
                                            );
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: primaryColor),
                                          child: Center(
                                            child: Text(
                                              'Submit'.toUpperCase(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.0),
                                            ),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ));
                    });
              },
              icon: Icon(Icons.search)),
        ],
      )),
      body: Column(
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

                                  if(selectedAudioAyat.ayaNumber==1)
                                  {
                                    toast("No previous ayat");
                                    return;
                                  }

                                 // print(_ayat[0].ayaNumber);
                                  var pos=selectedAudioAyat.ayaNumber!-1;
                                  print(pos.toString()+"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
                                  selectedAudioAyat=_ayat[pos-1];
                                  print(_ayat[pos].toString()+"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");


                                  getAllAudio(selectedAudioAyat.audio_ar.toString());

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
                                    _ischoseAudioVisible=!_ischoseAudioVisible;
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
                                   setState(() {
                                     _ischoseAudioVisible=!_ischoseAudioVisible;
                                   });
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
                                  isPlayingAudio=false;
                                  if(selectedAudioAyat.ayaNumber==widget.surahDetails.totalAyatEn)
                                    {
                                      toast("No next ayat");
                                      return;
                                    }

                                  var pos=selectedAudioAyat.ayaNumber!;
                                  selectedAudioAyat=_ayat[pos];
                                  getAllAudio(selectedAudioAyat.audio_ar.toString());

                                });


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
                                                      setState(() {
                                                        isPlayingAudio=!isPlayingAudio;
                                                      });
                                                      Get.back();
                                                  getAllAudio(selectedAudioAyat.audio_bn.toString());


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
                                                      getAllAudio(selectedAudioAyat.audio_en.toString());

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
                                                      getAllAudio(selectedAudioAyat.audio_ar.toString());

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

                     SizedBox(
                        height: 10,
                      ),
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
                      itemCount: _ayat.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: _getSingleAyat),
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () async {
                              dynamic previous_surah_id = widget.surahDetails.id;

                              if (widget.surahDetails.id == 1) {
                                toast("No More Surah");
                                return;
                              }
                              previous_surah_id -= 1;
                              var previoussurah = await DBProvider.db
                                  .getSurahWithId(previous_surah_id);
                              var previousayats = await DBProvider.db
                                  .getallAyats(previous_surah_id);
                              setState(() {
                                widget.surahDetails = previoussurah;

                                for (int i = 1;i <= widget.surahDetails.totalAyatEn!; i++) {
                                  _isVisibleButton.add(false);
                                }
                                _ayat = previousayats;
                              });
                            },

                            // icon: Icon(Icons.navigate_before,color: Colors.white),

                            child: Text(
                              "Previous",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (widget.surahDetails.id == 114) {
                                toast("No More Surah");
                                return;
                              }
                              dynamic next_surah_id = widget.surahDetails.id;
                              next_surah_id += 1;
                              var nextsurah = await DBProvider.db
                                  .getSurahWithId(next_surah_id);
                              var nextayats =
                                  await DBProvider.db.getallAyats(next_surah_id);
                              setState(() {
                                widget.surahDetails = nextsurah;

                                for (int i = 1; i <= widget.surahDetails.totalAyatEn!; i++) {
                                  _isVisibleButton.add(false);
                                }
                                _ayat = nextayats;
                              });
                            },
                            child: Text(
                              "Next",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            //icon: Icon(Icons.navigate_next,color: Colors.white,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body?.text).documentElement!.text;

    return parsedString;
  }

  Widget _getSingleAyat(BuildContext context, int position) {
    var ayat = _ayat;
    return GestureDetector(
      onLongPress: () {},
      child: Column(
        children: [

          Visibility(
            visible: _isVisibleButton[position],
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
                          List<AyatTafsir> _tafsirBank = [];
                          var ayat = _ayat[position];
                          Iterable temp1 = jsonDecode(ayat.ayat_tafsir.toString());
                          _tafsirBank = temp1.map((e) => AyatTafsir.fromJson(e)).toList();


                          showDialog(
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Dialog(
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
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
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
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/dialog_bg.png'),
                                                  fit: BoxFit.cover),
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                10.height,
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'যুগের জ্ঞানের আলোকে মৌলিক তাফসীর',
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                10.height,
                                                VerticalLine(),
                                                10.height,
                                                Html(
                                                  data: _ayat[position].nameAr,
                                                  shrinkWrap: true,
                                                  style: {
                                                    "p": Style(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        textAlign:
                                                            TextAlign.center,
                                                        fontSize:
                                                            FontSize.xLarge)
                                                  },
                                                ),
                                                10.height,
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        left: 5.0,
                                                        bottom: 10.0),
                                                    child: Text(
                                                      '${_ayat[position].nameBn}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 17.0),
                                                    )),
                                                10.height,
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    InkWell(
                                                      onTap: (() {

                                                        var previous=_ayat[position].ayaNumber;
                                                        setState(() {

                                                          if(previous==1)
                                                          {
                                                            toast("No previous tafsir");
                                                            return;
                                                          }
                                                          previous=previous!-1;
                                                          _ayat[position].ayaNumber=previous;
                                                          toast(_ayat[position].ayaNumber.toString());


                                                        });
                                                      }),
                                                      child: Container(
                                                          color:
                                                              Colors.grey[300],
                                                          padding:
                                                              EdgeInsets.all(
                                                                  5.0),
                                                          child: Icon(Icons
                                                              .keyboard_double_arrow_left)),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                          '${widget.surahDetails.nameBn} : ${_ayat[position].ayaNumber}'),
                                                    ),
                                                    InkWell(
                                                      onTap: (() {
                                                        var next=_ayat[position].ayaNumber;
                                                        print(next.toString()+"aaaaa");
                                                        setState(() {
                                                          if(next==widget.surahDetails.totalAyatEn)
                                                            {
                                                              toast("No next tafsir");
                                                              return;
                                                            }
                                                          next=next!+1;
                                                          _ayat[position].ayaNumber=next;
                                                          List<AyatTafsir> _tafsirBank = [];
                                                          var ayat = _ayat[next!];
                                                          toast(_ayat[position].ayaNumber.toString());
                                                         // _tafsirBank[position].tafsirBn=_tafsirBank[next!].tafsirBn;
                                                          //debugPrint(_tafsirBank[next!].tafsirBn,wrapWidth: 1024);
                                                          Iterable temp1 = jsonDecode(ayat.ayat_tafsir.toString());
                                                          _tafsirBank = temp1.map((e) => AyatTafsir.fromJson(e)).toList();


                                                        });

                                                      }),
                                                      child: Container(
                                                          color:
                                                              Colors.grey[300],
                                                          padding:
                                                              EdgeInsets.all(
                                                                  5.0),
                                                          child: Icon(Icons
                                                              .keyboard_double_arrow_right)),
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
                                                    child: Column(
                                                      children: List.generate(
                                                          _tafsirBank.length ??
                                                              0, (index) {
                                                        //var tafsirList = _tafsirBank;
                                                        AyatTafsir word =
                                                            new AyatTafsir();
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                  child: Text(_parseHtmlString(_tafsirBank[index].tafsirBn.toString()))
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
                          List<AyatWordBank> _wordBank = [];
                          var ayat = _ayat[position];
                          //******************for word bank************
                          Iterable temp = jsonDecode(ayat.ayat_word_bank.toString());
                          _wordBank = temp
                              .map((e) => AyatWordBank.fromJson(e))
                              .toList();
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Dialog(
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
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
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
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
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
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                10.height,
                                                VerticalLine(),
                                                10.height,
                                                Container(
                                                  margin: EdgeInsets.all(10.0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      color: Colors.grey[100]),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Html(
                                                        data: _ayat[position]
                                                            .nameAr,
                                                        shrinkWrap: true,
                                                        style: {
                                                          "p": Style(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              fontSize: FontSize
                                                                  .xLarge)
                                                        },
                                                      ),
                                                      10.height,
                                                      Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5.0,
                                                                  bottom: 10.0),
                                                          child: Text(
                                                            _ayat[position]
                                                                .nameBn
                                                                .toString(),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      Image.asset(
                                                        'assets/images/option_play_icon.png',
                                                        height: 30.0,
                                                        width: 30.0,
                                                      ),
                                                      InkWell(
                                                        onTap: () {

                                                          Clipboard.setData(new ClipboardData(text: _wordBank[0].nameEn)).then((_){
                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_wordBank[0].nameEn.toString())));
                                                          });
                                                        },
                                                        child: Image.asset(
                                                          'assets/images/option_read_icon.png',
                                                          height: 30.0,
                                                          width: 30.0,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap:() async {
                                                          final RenderObject? box = context.findRenderObject();
                                                          {
                                                            await Share.share(_wordBank[0].nameEn,
                                                            );
                                                          }

                                                        },

                                                        child: Image.asset(
                                                          'assets/images/option_share_icon.png',
                                                          height: 30.0,
                                                          width: 30.0,
                                                        ),
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
                                                          _wordBank.length ?? 0,
                                                          (index) {
                                                        var wordList =
                                                            _wordBank;
                                                        AyatWordBank word =
                                                            wordList![index];
                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: Get.width *
                                                                  0.7,
                                                              height: 50.0,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0),
                                                                  color: Colors
                                                                          .grey[
                                                                      100]),
                                                              margin: EdgeInsets
                                                                  .all(3.0),
                                                              child: Html(
                                                                data:
                                                                    word.nameAr,
                                                                shrinkWrap:
                                                                    true,
                                                                style: {
                                                                  "p": Style(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          FontSize.rem(
                                                                              1.6),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      whiteSpace:
                                                                          WhiteSpace
                                                                              .NORMAL,
                                                                      color: Colors
                                                                          .red,
                                                                      display:
                                                                          Display
                                                                              .BLOCK)
                                                                },
                                                              ),
                                                            ),
                                                            Text(
                                                              '${word.nameEn}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .redAccent,
                                                                  fontSize:
                                                                      15.0),
                                                            ),
                                                            Text(
                                                              '${word.nameBn}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .redAccent,
                                                                  fontSize:
                                                                      15.0),
                                                            ),
                                                            10.height,
                                                            Text(
                                                              '${word.translateEn}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .redAccent,
                                                                  fontSize:
                                                                      15.0),
                                                            ),
                                                            10.height,
                                                            Text(
                                                              '${word.translateBn}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .redAccent,
                                                                  fontSize:
                                                                      15.0),
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
                          showConfirmDialogCustom(context,
                              title: "Do you want to bookmark this ayat?",
                              dialogType: DialogType.CONFIRMATION,
                              onAccept: (context) {
                            toast('Please login to add bookmark');
                            Get.back();
                            Get.toNamed(AppPages.getLoginRoute());
                          });
                        },
                        child: Image.asset(
                          'assets/images/option_flag_icon.png',
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          notesDialog(
                              context,
                              widget.surahDetails.id.toString(),
                              ayat[position].id.toString(),
                              "Note");
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
                             selectedAudio=position;
                              selectedAudioAyat=  _ayat[selectedAudio];
                            _isPlayerVisible = !_isPlayerVisible;
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

                          Clipboard.setData(new ClipboardData(text: ayat[position].nameEn)).then((_){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ayat[position].nameEn.toString())));
                          });
                        },
                        child: Image.asset(
                          'assets/images/option_read_icon.png',
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                      InkWell(
                        onTap:() async {
                          final RenderObject? box = context.findRenderObject();
                          {
                            await Share.share(ayat[position].nameEn,
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
                      _isVisibleButton.replaceRange(0, _isVisibleButton.length, _isVisibleButton.map((element) => false));
                      _isVisible = false;
                      _isPlayerVisible=false;
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
                      onTap: () {
                        setState(() {
                          _isVisibleButton.replaceRange(0, _isVisibleButton.length, _isVisibleButton.map((element) => false));
                          _isVisibleButton[position] =
                              !_isVisibleButton[position];
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
                    data: ayat[position].nameAr!,
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
                      '${ayat[position].nameEn}',
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.w400),
                    )),
                5.height,
                Container(
                    padding: EdgeInsets.only(left: 5.0, bottom: 10.0),
                    child: Text(
                      '${ayat[position].nameBn}',
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.w400),
                    )),
              ],
            ),
          ),
          VerticalLineModified()

        ],
      ),
    );
  }

  //******************api call with parameters***********************************
  Future<List<Surah>?> getallAyatdropdown() async {
    var client = http.Client();
    Iterable surahList;

    Map<String, String> header = {
      'x-api-key': "3R5TWxA0GAn04EQ42haCnYtFxeRlV08yMi5o",
    };
    Map<String, dynamic> queryParams = {
      'sura_id': widget.surahDetails.id,
      //'ayat_no': widget.surahDetails.
    };
    Uri uri = Uri.parse(endpointUrl);
    final finalUri = uri.replace(queryParameters: queryParams);

    final response = await client.get((finalUri), headers: header);

    var JsonData = jsonDecode(response.body);
  }
  //*****************Get all Audio*********************
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







///get all the ayat
  void getAyatNumbers(int totalAyat) {
    //print(ayatNumbers.toString());
    ayatNumbers.clear();

    for (int i = 1; i <= totalAyat; i++) {
      ayatNumbers.add(i);
    }
  }

}

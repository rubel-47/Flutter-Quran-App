import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/model/hadis/hadis_list.dart';
import 'package:qrf/model/hadis/modified_hadis_list.dart';
import 'package:qrf/model/quran/surah_list.dart';

import '../../controllers/database/quran_database.dart';
import '../../model/hadis/hadis_details.dart';
import '../../routes/app_pages.dart';
import '../../utils/color.dart';
import '../quran/single_ayat_screen_offline.dart';
import 'hadis_details_screen_offline.dart';
import 'hadis_search_screen_offline.dart';

class HadisScreenOffile extends StatefulWidget {
  const HadisScreenOffile({Key? key}) : super(key: key);

  @override
  State<HadisScreenOffile> createState() => _HadisScreenOffileState();
}

class _HadisScreenOffileState extends State<HadisScreenOffile> {
  TextEditingController _hadisname=TextEditingController();
  TextEditingController _hadisnumber=TextEditingController();
  modifiedHadis hadis = new modifiedHadis();
  List<modifiedHadis> _hadis = [];
  List<Surah> _surah=[];


  //Get all hadis
  getAllHadis() async {
    await DBProvider.db. getHadis().then((value) {
      value.forEach((element) {
        setState(() {
          _hadis.add(modifiedHadis.fromJson(element));

        }
        );
      }

      );

    }
    );

  }
  //***************************************************

  void initState() {
    getAllHadis();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    dynamic _selectedhadiId=0;
    dynamic _selectedhadisNo=0;
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        title: Row(
          children: [
            Text("AL HADITH"),
            SizedBox(width: 100,),
            IconButton(
                onPressed: () async {
                  List<HadisBook> _hadisBank = [];
                  var len=_hadis.length;
                  for(int i=0;i<len;i++)
                    {
                      var hadis = _hadis[i].hadis_book;
                      Iterable temp1 = jsonDecode(hadis.toString());
                      _hadisBank.addAll( temp1.map((e) => HadisBook.fromJson(e)).toList());
                    }

                  showModalBottomSheet<void>(
                    barrierColor: Colors.transparent,
                    elevation: 200,
                      isScrollControlled: false,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),

                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                            height: 160,
                            child:  Column(

                              children:   <Widget>
                              [
                                Padding(
                                  padding: const EdgeInsets.only(right: 25.0),
                                  child: Container(
                                    height: 70,
                                    width: 300,
                                    child: DropdownSearch<HadisBook>(
                                      items:_hadisBank,
                                      itemAsString: (HadisBook hadisbook) => hadisbook.bookName.toString(),
                                      dropdownDecoratorProps: DropDownDecoratorProps(
                                        dropdownSearchDecoration: InputDecoration(
                                          labelText: "Search hadisbook name",

                                        ),

                                      ),
                                      onChanged: (hadisbook) async {
                                       setState(() {
                                         _selectedhadiId=hadisbook?.hadisId;
                                         //print(_selectedhadisbookName.toString());
                                       });

                                      },
                                      //selectedItem: "Brazil",
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0),
                                      child: Container(
                                        height: 60,
                                        width: 170,
                                        child: DropdownSearch<HadisBook>(
                                          items: _hadisBank,
                                          itemAsString: (HadisBook hadisbook) => hadisbook.hadisNo.toString(),
                                          dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                            InputDecoration(
                                              labelText: "Search hadis no here",
                                            ),
                                          ),
                                          onChanged: (hadisbook) {
                                            setState(() {
                                              _selectedhadisNo=hadisbook;

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
                                            if(_selectedhadiId==0||_selectedhadisNo==0)
                                              {
                                                toast("please select something");
                                                return;
                                              }
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => HadisSearchScreenOffline(hadisId: _selectedhadiId,hadisBook:_selectedhadisNo)),
                                            );


                                          },
                                          child: Opacity(

                                            opacity: 1,
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
                                          ),
                                        ))
                                  ],
                                ),








                              ],
                            )
                        );

                      }
                  );



                },


                icon: Icon(Icons.search)

            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/app_bg.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Column(
            children: <Widget>[

              Expanded(
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[

                        10.height,

                                ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: 2,
                            shrinkWrap: true,
                            itemBuilder:
                                (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => HadisDetailsScreenOffline(HadisDetails: _hadis[index],)),
                                  );
                                },
                                child: Container(
                                  height: 65.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 2.0),
                                  ),
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(10.0),
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    _hadis[index].hadisAr.toString(),
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              );
                            },
                          ),

                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

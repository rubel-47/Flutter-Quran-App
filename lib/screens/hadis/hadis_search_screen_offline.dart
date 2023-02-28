import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:html/parser.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/controllers/database/quran_database.dart';
import 'package:qrf/model/hadis/hadis_details.dart';
import 'package:qrf/model/hadis/modified_hadis_list.dart';

import '../../model/hadis/hadis_details.dart';
import '../../model/hadis/hadis_details.dart';
import '../../model/hadis/hadis_details.dart';
import '../../model/hadis/hadis_details.dart';
import '../../model/quran/surah_list.dart';
import '../../utils/color.dart';
import '../../utils/widgets.dart';


class HadisSearchScreenOffline extends StatefulWidget {
   final hadisId;
   HadisBook hadisBook;

   HadisSearchScreenOffline({Key? key,required this.hadisId,required this.hadisBook}) : super(key: key);

  @override
  State<HadisSearchScreenOffline> createState() => _HadisSearchScreenOfflineState();
}

class _HadisSearchScreenOfflineState extends State<HadisSearchScreenOffline> {
  List<modifiedHadis> _hadisfromdb=[];
  modifiedHadis hadis = new modifiedHadis();
  List<modifiedHadis> _hadis = [];
  List<Surah> _surah=[];



  getquerywithhadisNo() async {
    await DBProvider.db.getHadisDetails(widget.hadisId).then((value) {
      value.forEach((element) {
        setState(() {
          _hadisfromdb.add(modifiedHadis.fromJson(element));

        }
        );
      }

      );

    }

    );


  }
  @override
  void initState() {
    getquerywithhadisNo();
    getAllHadis();
    super.initState();
  }
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

  @override
  Widget build(BuildContext context) {
    dynamic _selectedhadiId=0;
    dynamic _selectedhadisNo=0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appBgColor,
      appBar:  AppBar(
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

                      context: context,
                      builder: (BuildContext context) {
                        return Opacity(
                          opacity: 1,
                          child: SizedBox(
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
                          ),
                        );

                      }
                  );



                },


                icon: Icon(Icons.search)

            ),
          ],
        ),
      ),

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


            ],

          ),

              Expanded(
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[

                        Expanded(
                            child:
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'হাদিস নং - '+_hadisfromdb[0].hadisNo.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    10.height,
                                    Text(_hadisfromdb[0].hadisAr.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    10.height,
                                    Text(
                                      'অর্থঃ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    10.height,
                                    Text(_hadisfromdb[0].meaningBn.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    10.height,
                                    Text(_hadisfromdb[0].meaningEn.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    10.height,
                                    Text(
                                      'বিস্তারিতঃ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    10.height,
                                    Html(
                                      data:
                                      _hadisfromdb[0].description.toString(),
                                      shrinkWrap: true,
                                      style: {
                                        "p": Style(
                                            fontWeight: FontWeight.w600,
                                            fontSize: FontSize.medium,
                                            textAlign: TextAlign.center,
                                            direction: TextDirection.rtl,
                                            whiteSpace: WhiteSpace.NORMAL,
                                            display: Display.BLOCK)
                                      },
                                    ),
                                    Text(
                                      'কন্টেন্টঃ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    10.height,
                                    Html(
                                      data:
                                      widget.hadisBook.Content,
                                      shrinkWrap: true,
                                      style: {
                                        "p": Style(
                                            fontWeight: FontWeight.w600,
                                            fontSize: FontSize.medium,
                                            textAlign: TextAlign.center,
                                            direction: TextDirection.rtl,
                                            whiteSpace: WhiteSpace.NORMAL,
                                            display: Display.BLOCK)
                                      },
                                    ),

                                  ],
                                ),
                              ),
                            )

                        ),
                      ],
                    )
                  ],
                ),
              )
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
}

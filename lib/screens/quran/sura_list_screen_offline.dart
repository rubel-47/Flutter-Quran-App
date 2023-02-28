import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/screens/quran/all_ayats_single_surah_offline.dart';

import 'package:qrf/screens/quran/single_ayat_screen_offline.dart';
import '../../controllers/database/quran_database.dart';
import '../../model/quran/ayat_list.dart';
import '../../model/quran/modified_ayat_list.dart';
import '../../model/quran/surah_list.dart';
import '../../routes/app_pages.dart';
import '../../utils/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  List<Surah> _surah=[];
  List<Ayat> _ayat=[];
  List<AyatWordBank> _ayatwordbank=[];
  List<AyatTafsir> _ayattafsir=[];
  List<modifiedAyat> _modifiedayat=[];
  var ayatNumbers = List<int>.empty(growable: true).obs;


  void initState() {
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

    }
    );

  }
  @override
  Widget build(BuildContext context) {
    dynamic _selectedsurah=0;
    dynamic _selectedayat=0;
    return Scaffold(
      appBar: AppBar(
          title:  Row(
            children: [
              Text("Al Quran"),
              SizedBox(width: 120,),
              IconButton(
                  onPressed: () async {

                    showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                              height: 160,
                              child: Column(

                                children:   <Widget>
                                [

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
                                          _selectedsurah =surah?.id;
                                          setState(() {
                                            _selectedayat=0;
                                          });
                                          final totalayat= await DBProvider.db.getselectedSuraAyat(_selectedsurah);
                                          getAyatNumbers(totalayat);
                                          //controller.getAyatNumbers(surah?.totalAyatEn);
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
                                          child: DropdownSearch<int>(

                                              items:ayatNumbers,

                                              dropdownDecoratorProps: DropDownDecoratorProps(

                                                dropdownSearchDecoration: InputDecoration(

                                                  labelText: "Search ayat here",

                                                  // hintText: "country in menu mode",
                                                ),
                                              ),
                                              onChanged: (_ayat)
                                              {
                                                setState(() {
                                                  _selectedayat=_ayat;



                                                });
                                              }

                                            //selectedItem: "Brazil",
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Container(

                                          height: 50,
                                          width: 130,
                                          child:   InkWell(
                                            onTap: () {
                                              if (_selectedayat == 0 && _selectedsurah == 0)
                                              {
                                                toast("Please select surah and ayat");
                                                return;
                                              }
                                              if(_selectedayat==0)
                                                {
                                                  toast("Invalid ayat number");
                                                  return;
                                                }

                                               //toast(_selectedsurah.toString());
                                              if (_selectedayat != 0 && _selectedsurah != 0) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TestScreen(
                                                            surahId: _selectedsurah,
                                                            ayatNumber: _selectedayat,
                                                            surahDetails: _surah
                                                                .elementAt(
                                                                _selectedsurah -
                                                                    1),)),
                                                );
                                              }
                                            },
                                            child: Container(
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
                                          )
                                      )


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
          )
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

              Expanded(
                child: SingleChildScrollView(
                  child: ListView.builder(
                      itemCount: _surah.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {

                        var surah=_surah[index];

                        return InkWell(
                          onTap: () {

                            if(mounted) {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SingleSurah(surahDetails: _surah[index],)),
                              );

                            }


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
                                        Text('${surah.nameEn}'),
                                        Html(
                                          data: '${surah.nameAr}',
                                          shrinkWrap: true,
                                          style: {
                                            "p": Style(
                                              //padding: EdgeInsets.only(right: 12.0),
                                                fontFamily: 'Quran Font',
                                                wordSpacing: 5,
                                                fontWeight: FontWeight.bold,
                                                fontSize: FontSize.rem(1.2),
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
                      }
                  ),
                ),
              ),

            ],
          ),
        ],
      ),);
  }

  void getAyatNumbers(int totalAyat){
    //print(ayatNumbers.toString());
    ayatNumbers.clear();

    for(int i=1;i<=totalAyat;i++)
    {
      ayatNumbers.add(i);
    }

  }
}

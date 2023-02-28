

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrf/model/hadis/modified_hadis_list.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/hadis/hadis_list.dart';
import '../../model/quran/ayat_list.dart';
import '../../model/quran/modified_ayat_list.dart';
import '../../model/quran/surah_list.dart';
import 'package:path/path.dart';



class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'test.db');

    return await openDatabase(path, version: 1, onOpen: (db) {


    },
        onCreate: (Database db, int version) async {

          await db.execute('CREATE TABLE Surah('
              'id INTEGER PRIMARY KEY,'
              'name_en TEXT,'
              'name_bn TEXT,'
              'name_ar TEXT,'
              'sura_type_en  TEXT,'
              'sura_type_bn TEXT,'
              'sura_type_ar TEXT,'
              'total_ayat_en INTEGER,'
              'total_ayat_bn TEXT,'
              'total_ayat_ar TEXT,'
              'sanenojul_en TEXT,'
              'sanenojul_bn TEXT,'
              'sanenojul_ar TEXT'
              ')');

          await db.execute('CREATE TABLE Ayat('
              'id INTEGER,'
               'audio_ar TEXT,'
              'audio_en TEXT,'
              'audio_bn TEXT,'
              'name_ar TEXT,'
              'name_en TEXT,'
              'name_bn TEXT,'
              'aya_number INTEGER,'
              'verse_key TEXT,'
              'sanenojul TEXT,'
              'tafsir TEXT,'
              'sajda INTEGER,'
              'sajda_number INTEGER,'
              'ruku INTEGER,'
              'ruku_number INTEGER,'
              'suraId INTEGER ,'
              'suraNameAr TEXT,'
              'suraNameEn TEXT,'
              'suraNameBn TEXT,'
              'paraId INTEGER,'
              'paraNameAr TEXT,'
              'paraNameEn TEXT,'
              'paraNameBn TEXT,'
              'ayat_tafsir_string TEXT,'
              'ayat_word_bank_string TEXT'

              ')');



          await db.execute('CREATE TABLE Hadis('
              'id INTEGER,'
              'hadis_ar TEXT,'
              'hadis_no INTEGER,'
              'meaning_bn TEXT,'
              'meaning_en TEXT,'
              'description TEXT,'
              'hadis_author_by INTEGER,'
              'hadis_author_name TEXT,'
              'narrated_by INTEGER,'
              'narrated_by_name TEXT,'
              'hadis_book_string TEXT'

              ')');
        }
    );
  }

  //**************************create modified ayat *************************************************
createmodifiedayat(List<modifiedAyat> modifiedayat) async
{
  final db=await database;
  var batch = db?.batch();
   modifiedayat.forEach((ayat) {
     batch?.insert("Ayat", ayat.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
   });
  await batch?.commit(continueOnError: true,noResult: true);

}




//********************Count ID*******************************
  Future<int?> getCount(String tbl) async {
    final db = await this.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(id) FROM $tbl'));


  }
  //*********************************************************
  Future<int?> getTotalCount(String tbl) async {
    final db = await database;
    return Sqflite.firstIntValue( await db!.rawQuery('SELECT COUNT(id) FROM $tbl'));
  }

  // *****************************Insert surah on database***********************************************
  createSurah(List<Surah> surahs) async {

    final db = await database;
    var batch = db?.batch();
    surahs.forEach((surah) {
      batch?.insert("Surah", surah.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);

    });

    await batch?.commit(continueOnError: true,noResult: true);


  }



  //*************Create ayat word bank***************************
  createayatwordBank(AyatWordBank ayatwordbank) async {

    final db = await database;
    final res = await db?.insert(
        'AyatWordBank', ayatwordbank.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);

    return res;
  }
  //*************************************Create tafsir********************************
  createtafsir(AyatTafsir ayattafsir) async {

    final db = await database;
    final res = await db?.insert(
        'AyatTafsir', ayattafsir.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);

    return res;
  }




  // *******************************Delete all surahs***********************************
  Future<int?> deleteSurah() async {
    final db = await database;
    final res = await db?.rawDelete('DELETE FROM Ayat');

    return res;
  }
  //**********************get hadis************************
  Future<List> getHadis() async {
    var db = await database;
    var list = await db?.query("Hadis");

    return list!.toList();
  }
  //*****************************
  Future<List> getHadisDetails(int hadisId) async {
    var db = await database;
    var list = await db?.query("Hadis",where: 'id=?',whereArgs: [hadisId]);

    return list!.toList();
  }


//Get all ayat by Surah

  Future<List> getAyat(int suraId) async {
    var db = await database;
    var list = await db?.rawQuery("select * from Ayat WHERE suraId=$suraId");
    return list!.toList();
  }
  //Get all Surah

  Future<List> getSurah() async {
    var db = await database;
    var list = await db?.query("Surah");
    return list!.toList();
  }
  //Get total ayat with suraId
  Future<int> getselectedSuraAyat (int suraID) async
  {
    final db = await database;
    final mysurah = await db?.rawQuery("SELECT total_ayat_en FROM Surah WHERE id =$suraID");

    var temp=jsonEncode(mysurah);
    Iterable list=jsonDecode(temp);
    int x=0;
    list.forEach((element) {

      x=element['total_ayat_en'];
    });

    return x;

  }
  Future<modifiedAyat> getselectedAyats(int suraid , int ayatnumber) async
  {
    final db=await database;
    final myayats=await db?.rawQuery("select * from Ayat where suraId=$suraid and aya_number =$ayatnumber;");
    var singleayat;
    myayats?.forEach((element) {
      singleayat=modifiedAyat.fromJson(element);

    });

    return singleayat;
  }
  //****************Get Surah*************************

Future<Surah> getSurahWithId(int suraid) async
{
  final db =await database;
  final selectedsurah=await db?.rawQuery("select * from Surah where id=$suraid;");
  var surah;
  selectedsurah?.forEach((element) {
    surah=Surah.fromJson(element);

  });
  return surah;
}
//**********************Get ayats****************************
  Future<List<modifiedAyat> > getallAyats(int suraid) async
  {
    final db=await database;
    final myayats=await db?.rawQuery("select * from Ayat where suraId=$suraid;");
    List<modifiedAyat> listofAyat=[];
    myayats?.forEach((element) {
      listofAyat.add(modifiedAyat.fromJson(element));

    });


    return listofAyat;
  }
  //*************************************
  createAyat(List<Ayat> ayats) async
  {
    final db=await database;
    var batch = db?.batch();
    ayats.forEach((ayat) {
      var modifiedayat=modifiedAyat.fromJson(ayat.toJson());

      final temp=ayat.ayatTafsir?.map((e) => e.toJson()).toList();
      modifiedayat.ayat_tafsir=jsonEncode(temp);

      final temp1=ayat.ayatWordBank?.map((e) => e.toJson()).toList();
      modifiedayat.ayat_word_bank=jsonEncode(temp1);


      batch?.insert("Ayat", modifiedayat.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);

    });
    await batch?.commit(continueOnError: true,noResult: true);

  }
  //**************************************************
  createHadis(List<Hadis> hadiss) async
  {
    final db=await database;
    var batch = db?.batch();
    hadiss.forEach((hadis) {
      var modifiedhadis=modifiedHadis.fromJson(hadis.toJson());
      final temp=hadis.hadisBook?.map((e) => e.toJson()).toList();
      modifiedhadis.hadis_book=jsonEncode(temp);
      batch?.insert("Hadis", modifiedhadis.toJson());

    });
    await batch?.commit(continueOnError: true,noResult: true);

  }




}


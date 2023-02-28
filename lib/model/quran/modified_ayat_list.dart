  class modifiedAyat {
  int? id;
  String? audio_ar;
  String? audio_en;
  String? audio_bn;
  String? nameAr;
  String? nameEn;
  String? nameBn;
  int? ayaNumber;
  String? verseKey;
  String? sanenojul;
  String? tafsir;
  int? sajda;
  int? sajdaNumber;
  int? ruku;
  int? rukuNumber;
  int? suraId;
  String? suraNameAr;
  String? suraNameEn;
  String? suraNameBn;
  int? paraId;
  String? paraNameAr;
  String? paraNameEn;
  String? paraNameBn;
  String? ayat_tafsir;
  String? ayat_word_bank;



  modifiedAyat(
      {
        this.id,
        this.audio_ar,
        this.audio_en,
        this.audio_bn,
        this.nameAr,
        this.nameEn,
        this.nameBn,
        this.ayaNumber,
        this.verseKey,
        this.sanenojul,
        this.tafsir,
        this.sajda,
        this.sajdaNumber,
        this.ruku,
        this.rukuNumber,
        this.suraId,
        this.suraNameAr,
        this.suraNameEn,
        this.suraNameBn,
        this.paraId,
        this.paraNameAr,
        this.paraNameEn,
        this.paraNameBn,
        this.ayat_tafsir,
        this.ayat_word_bank,

         });

  modifiedAyat.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    audio_ar=json['audio_ar'];
    audio_en=json['audio_en'];
    audio_bn=json['audio_bn'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    nameBn = json['name_bn'];
    ayaNumber = json['aya_number'];
    verseKey = json['verse_key'];
    sanenojul = json['sanenojul'];
    tafsir = json['tafsir'];
    sajda = json['sajda'];
    sajdaNumber = json['sajda_number'];
    ruku = json['ruku'];
    rukuNumber = json['ruku_number'];
    suraId = json['suraId'];
    suraNameAr = json['suraNameAr'];
    suraNameEn = json['suraNameEn'];
    suraNameBn = json['suraNameBn'];
    paraId = json['paraId'];
    paraNameAr = json['paraNameAr'];
    paraNameEn = json['paraNameEn'];
    paraNameBn = json['paraNameBn'];
    ayat_tafsir=json['ayat_tafsir_string'];
    ayat_word_bank=json['ayat_word_bank_string'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['audio_ar']=this.audio_ar;
    data['audio_en']=this.audio_en;
    data['audio_bn']=this.audio_bn;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['name_bn'] = this.nameBn;
    data['aya_number'] = this.ayaNumber;
    data['verse_key'] = this.verseKey;
    data['sanenojul'] = this.sanenojul;
    data['tafsir'] = this.tafsir;
    data['sajda'] = this.sajda;
    data['sajda_number'] = this.sajdaNumber;
    data['ruku'] = this.ruku;
    data['ruku_number'] = this.rukuNumber;
    data['suraId'] = this.suraId;
    data['suraNameAr'] = this.suraNameAr;
    data['suraNameEn'] = this.suraNameEn;
    data['suraNameBn'] = this.suraNameBn;
    data['paraId'] = this.paraId;
    data['paraNameAr'] = this.paraNameAr;
    data['paraNameEn'] = this.paraNameEn;
    data['paraNameBn'] = this.paraNameBn;
    data['ayat_tafsir_string']=this.ayat_tafsir;
    data['ayat_word_bank_string']=this.ayat_word_bank;


    return data;
  }
}
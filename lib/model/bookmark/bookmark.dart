class BookmarkData {
  int? status;
  List<BookMark>? bookMark;

  BookmarkData({this.status, this.bookMark});

  BookmarkData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['book_mark'] != null) {
      bookMark = <BookMark>[];
      json['book_mark'].forEach((v) {
        bookMark!.add(new BookMark.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.bookMark != null) {
      data['book_mark'] = this.bookMark!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookMark {
  int? id;
  int? ayatId;
  int? suraId;
  String? type;
  String? message;
  String? createdAt;
  String? suraNameAr;
  String? suraNameEn;
  String? suraNameBn;
  BookmarkAyat? bookmarkAyat;

  BookMark(
      {this.id,
      this.ayatId,
      this.suraId,
      this.type,
      this.message,
      this.createdAt,
      this.suraNameAr,
      this.suraNameEn,
      this.suraNameBn,
      this.bookmarkAyat});

  BookMark.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ayatId = json['ayat_id'];
    suraId = json['sura_id'];
    type = json['type'];
    message = json['message'];
    createdAt = json['created_at'];
    suraNameAr = json['suraNameAr'];
    suraNameEn = json['suraNameEn'];
    suraNameBn = json['suraNameBn'];
    bookmarkAyat = json['bookmark_ayat'] != null
        ? new BookmarkAyat.fromJson(json['bookmark_ayat'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ayat_id'] = this.ayatId;
    data['sura_id'] = this.suraId;
    data['type'] = this.type;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    data['suraNameAr'] = this.suraNameAr;
    data['suraNameEn'] = this.suraNameEn;
    data['suraNameBn'] = this.suraNameBn;
    if (this.bookmarkAyat != null) {
      data['bookmark_ayat'] = this.bookmarkAyat!.toJson();
    }
    return data;
  }
}

class BookmarkAyat {
  int? id;
  String? commonAudio1;
  String? commonAudio2;
  String? audioAr;
  String? audioEn;
  String? audioBn;
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
  int? paraId;
  String? paraNameAr;
  String? paraNameEn;
  String? paraNameBn;
  List<AyatWordBank>? ayatWordBank;
  List<AyatTafsir>? ayatTafsir;

  BookmarkAyat(
      {this.id,
      this.commonAudio1,
      this.commonAudio2,
      this.audioAr,
      this.audioEn,
      this.audioBn,
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
      this.paraId,
      this.paraNameAr,
      this.paraNameEn,
      this.paraNameBn,
      this.ayatWordBank,
      this.ayatTafsir});

  BookmarkAyat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commonAudio1 = json['common_audio_1'];
    commonAudio2 = json['common_audio_2'];
    audioAr = json['audio_ar'];
    audioEn = json['audio_en'];
    audioBn = json['audio_bn'];
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
    paraId = json['paraId'];
    paraNameAr = json['paraNameAr'];
    paraNameEn = json['paraNameEn'];
    paraNameBn = json['paraNameBn'];
    if (json['ayat_word_bank'] != null) {
      ayatWordBank = <AyatWordBank>[];
      json['ayat_word_bank'].forEach((v) {
        ayatWordBank!.add(new AyatWordBank.fromJson(v));
      });
    }
    if (json['ayat_tafsir'] != null) {
      ayatTafsir = <AyatTafsir>[];
      json['ayat_tafsir'].forEach((v) {
        ayatTafsir!.add(new AyatTafsir.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['common_audio_1'] = this.commonAudio1;
    data['common_audio_2'] = this.commonAudio2;
    data['audio_ar'] = this.audioAr;
    data['audio_en'] = this.audioEn;
    data['audio_bn'] = this.audioBn;
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
    data['paraId'] = this.paraId;
    data['paraNameAr'] = this.paraNameAr;
    data['paraNameEn'] = this.paraNameEn;
    data['paraNameBn'] = this.paraNameBn;
    if (this.ayatWordBank != null) {
      data['ayat_word_bank'] =
          this.ayatWordBank!.map((v) => v.toJson()).toList();
    }
    if (this.ayatTafsir != null) {
      data['ayat_tafsir'] = this.ayatTafsir!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AyatWordBank {
  int? id;
  int? ayatId;
  int? position;
  int? wId;
  String? nameAr;
  String? nameEn;
  String? nameBn;
  String? translateEn;
  String? translateBn;
  int? rootWordId;
  String? rootWordNameAr;
  String? rootWordNameEn;
  String? rootWordNameBn;
  Null? subRootWordId;
  Null? subRootWordNameAr;
  Null? subRootWordNameEn;
  Null? subRootWordNameBn;

  AyatWordBank(
      {this.id,
      this.ayatId,
      this.position,
      this.wId,
      this.nameAr,
      this.nameEn,
      this.nameBn,
      this.translateEn,
      this.translateBn,
      this.rootWordId,
      this.rootWordNameAr,
      this.rootWordNameEn,
      this.rootWordNameBn,
      this.subRootWordId,
      this.subRootWordNameAr,
      this.subRootWordNameEn,
      this.subRootWordNameBn});

  AyatWordBank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ayatId = json['ayat_id'];
    position = json['position'];
    wId = json['wId'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    nameBn = json['name_bn'];
    translateEn = json['translate_en'];
    translateBn = json['translate_bn'];
    rootWordId = json['rootWordId'];
    rootWordNameAr = json['rootWordNameAr'];
    rootWordNameEn = json['rootWordNameEn'];
    rootWordNameBn = json['rootWordNameBn'];
    subRootWordId = json['subRootWordId'];
    subRootWordNameAr = json['subRootWordNameAr'];
    subRootWordNameEn = json['subRootWordNameEn'];
    subRootWordNameBn = json['subRootWordNameBn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ayat_id'] = this.ayatId;
    data['position'] = this.position;
    data['wId'] = this.wId;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['name_bn'] = this.nameBn;
    data['translate_en'] = this.translateEn;
    data['translate_bn'] = this.translateBn;
    data['rootWordId'] = this.rootWordId;
    data['rootWordNameAr'] = this.rootWordNameAr;
    data['rootWordNameEn'] = this.rootWordNameEn;
    data['rootWordNameBn'] = this.rootWordNameBn;
    data['subRootWordId'] = this.subRootWordId;
    data['subRootWordNameAr'] = this.subRootWordNameAr;
    data['subRootWordNameEn'] = this.subRootWordNameEn;
    data['subRootWordNameBn'] = this.subRootWordNameBn;
    return data;
  }
}

class AyatTafsir {
  int? id;
  int? ayatId;
  String? tafsirEn;
  String? tafsirBn;
  int? authorId;
  String? authorName;

  AyatTafsir(
      {this.id,
      this.ayatId,
      this.tafsirEn,
      this.tafsirBn,
      this.authorId,
      this.authorName});

  AyatTafsir.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ayatId = json['ayat_id'];
    tafsirEn = json['tafsir_en'];
    tafsirBn = json['tafsir_bn'];
    authorId = json['authorId'];
    authorName = json['authorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ayat_id'] = this.ayatId;
    data['tafsir_en'] = this.tafsirEn;
    data['tafsir_bn'] = this.tafsirBn;
    data['authorId'] = this.authorId;
    data['authorName'] = this.authorName;
    return data;
  }
}
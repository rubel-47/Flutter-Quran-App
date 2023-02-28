import 'dart:convert';

/*List<Surah> employeeFromJson(String str) =>
    List<Surah>.from(json.decode(str).map((x) => Surah.fromJson(x)));

String employeeToJson(List<Surah> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));*/


class Surah {
  int? id;
  String? nameEn;
  String? nameBn;
  String? nameAr;
  String? suraTypeEn;
  String? suraTypeBn;
  String? suraTypeAr;
  int? totalAyatEn;
  String? totalAyatBn;
  String? totalAyatAr;
  String? sanenojulEn;
  String? sanenojulBn;
  String? sanenojulAr;

  Surah(
      {this.id,
      this.nameEn,
      this.nameBn,
      this.nameAr,
      this.suraTypeEn,
      this.suraTypeBn,
      this.suraTypeAr,
      this.totalAyatEn,
      this.totalAyatBn,
      this.totalAyatAr,
      this.sanenojulEn,
      this.sanenojulBn,
      this.sanenojulAr});

    Surah.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameBn = json['name_bn'];
    nameAr = json['name_ar'];
    suraTypeEn = json['sura_type_en'];
    suraTypeBn = json['sura_type_bn'];
    suraTypeAr = json['sura_type_ar'];
    totalAyatEn = json['total_ayat_en'];
    totalAyatBn = json['total_ayat_bn'];
    totalAyatAr = json['total_ayat_ar'];
    sanenojulEn = json['sanenojul_en'];
    sanenojulBn = json['sanenojul_bn'];
    sanenojulAr = json['sanenojul_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_bn'] = this.nameBn;
    data['name_ar'] = this.nameAr;
    data['sura_type_en'] = this.suraTypeEn;
    data['sura_type_bn'] = this.suraTypeBn;
    data['sura_type_ar'] = this.suraTypeAr;
    data['total_ayat_en'] = this.totalAyatEn;
    data['total_ayat_bn'] = this.totalAyatBn;
    data['total_ayat_ar'] = this.totalAyatAr;
    data['sanenojul_en'] = this.sanenojulEn;
    data['sanenojul_bn'] = this.sanenojulBn;
    data['sanenojul_ar'] = this.sanenojulAr;
    return data;
  }
}

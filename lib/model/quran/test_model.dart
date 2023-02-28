/*import 'dart:convert';

List<Employee> employeeFromJson(String str) =>
    List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String employeeToJson(List<Employee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));*/

/*class Employee {
  int id;
  String name;
  String email;


  Employee({
    required this.id,
    required this.name,
    required this.email,

  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    name: json["name"],
    email: json["email"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,

  };
}*/
/*import 'dart:convert';

List<Surah> employeeFromJson(String str) =>
    List<Surah>.from(json.decode(str).map((x) => Surah.fromJson(x)));

String employeeToJson(List<Surah> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));*/

/*
class Surah {
  int? id;
  String? name_en;
  String? name_bn;
  String? name_ar;
  String? sura_type_en;
  String? sura_type_bn;
  String? sura_type_ar;
  int? total_ayat_en;
  String? total_ayat_bn;
  String? total_ayat_ar;
  String? sanenojul_en;
  String? sanenojul_bn;
  String? sanenojul_ar;

  Surah(
      {this.id,
        this.name_en,
        this.name_bn,
        this.name_ar,
        this.sura_type_en,
        this.sura_type_bn,
        this.sura_type_ar,
        this.total_ayat_en,
        this.total_ayat_bn,
        this.total_ayat_ar,
        this.sanenojul_en,
        this.sanenojul_bn,
        this.sanenojul_ar});

  factory Surah.fromJson(Map<String, dynamic> json) =>Surah(
    id : json['id'],
    name_en:   json['name_en'],
    name_bn:  json['name_bn'],
    name_ar:   json['name_ar'],
    sura_type_en:   json['sura_type_en'],
    sura_type_bn:   json['sura_type_bn'],
    sura_type_ar:   json['sura_type_ar'],
    total_ayat_en:   json['total_ayat_en'],
    total_ayat_bn:   json['total_ayat_bn'],
    total_ayat_ar:   json['total_ayat_ar'],
    sanenojul_en:   json['sanenojul_en'],
    sanenojul_bn:   json['sanenojul_bn'],
    sanenojul_ar:   json['sanenojul_ar'],
  );


  Map<String, dynamic> toJson()=> {
    "id":id,
    "name_en":name_en,
    "name_bn":name_bn,
    "name_ar":name_ar,
    "sura_type_en":sura_type_en,
    "sura_type_bn":sura_type_bn,
    "sura_type_ar":sura_type_ar,
    "total_ayat_en":total_ayat_en,
    "total_ayat_bn":total_ayat_bn,
    "total_ayat_ar":total_ayat_ar,
    "sanenojul_en":sanenojul_en,
    "sanenojul_bn":sanenojul_bn,
    "sanenojul_ar":sanenojul_ar,





  }
}*/

class modifiedHadis {
  int? id;
  String? hadisAr;
  int? hadisNo;
  String? meaningBn;
  String? meaningEn;
  String? description;
  int? hadisAuthorBy;
  String? hadisAuthorName;
  int? narratedBy;
  String? narratedByName;
  String? hadis_book;



  modifiedHadis(
      {
        this.id,
        this.hadisAr,
        this.hadisNo,
        this.meaningBn,
        this.meaningEn,
        this.description,
        this.hadisAuthorBy,
        this.hadisAuthorName,
        this.narratedBy,
        this.narratedByName,
        this.hadis_book,

      });

  modifiedHadis.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    hadisAr = json['hadis_ar'];
    hadisNo = json['hadis_no'];
    meaningBn = json['meaning_bn'];
    meaningEn = json['meaning_en'];
    description = json['description'];
    hadisAuthorBy = json['hadis_author_by'];
    hadisAuthorName = json['hadis_author_name'];
    narratedBy = json['narrated_by'];
    narratedByName = json['narrated_by_name'];
    hadis_book=json['hadis_book_string'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['hadis_ar'] = this.hadisAr;
    data['hadis_no'] = this.hadisNo;
    data['meaning_bn'] = this.meaningBn;
    data['meaning_en'] = this.meaningEn;
    data['description'] = this.description;
    data['hadis_author_by'] = this.hadisAuthorBy;
    data['hadis_author_name'] = this.hadisAuthorName;
    data['narrated_by'] = this.narratedBy;
    data['narrated_by_name'] = this.narratedByName;
    data['hadis_book_string']=this.hadis_book;


    return data;
  }
}
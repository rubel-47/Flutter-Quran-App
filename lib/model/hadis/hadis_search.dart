class HadisSearch {
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
  List<HadisBook>? hadisBook;

  HadisSearch(
      {this.id,
      this.hadisAr,
      this.hadisNo,
      this.meaningBn,
      this.meaningEn,
      this.description,
      this.hadisAuthorBy,
      this.hadisAuthorName,
      this.narratedBy,
      this.narratedByName,
      this.hadisBook});

  HadisSearch.fromJson(Map<String, dynamic> json) {
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
    if (json['hadis_book'] != null) {
      hadisBook = <HadisBook>[];
      json['hadis_book'].forEach((v) {
        hadisBook!.add(new HadisBook.fromJson(v));
      });
    }
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
    if (this.hadisBook != null) {
      data['hadis_book'] = this.hadisBook!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HadisBook {
  int? id;
  int? hadisId;
  int? bookId;
  String? bookName;
  Null? bookIntroduce;
  Null? bookDescription;
  String? referenceNo;
  int? hadisNo;
  String? comment;

  HadisBook(
      {this.id,
      this.hadisId,
      this.bookId,
      this.bookName,
      this.bookIntroduce,
      this.bookDescription,
      this.referenceNo,
      this.hadisNo,
      this.comment});

  HadisBook.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hadisId = json['hadis_id'];
    bookId = json['book_id'];
    bookName = json['bookName'];
    bookIntroduce = json['book_introduce'];
    bookDescription = json['book_description'];
    referenceNo = json['reference_no'];
    hadisNo = json['hadis_no'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hadis_id'] = this.hadisId;
    data['book_id'] = this.bookId;
    data['bookName'] = this.bookName;
    data['book_introduce'] = this.bookIntroduce;
    data['book_description'] = this.bookDescription;
    data['reference_no'] = this.referenceNo;
    data['hadis_no'] = this.hadisNo;
    data['comment'] = this.comment;
    return data;
  }
}
class PaperSearch {
  int? id;
  String? researchPaperName;
  int? paperNumber;
  String? description;
  String? purchaseLink;
  int? regularPrice;
  String? discountType;
  int? discount;
  int? discountPrice;
  int? researchPaperAuthorId;
  String? researchPaperAuthor;
  int? publicationId;
  String? publicationName;
  String? coverImage;
  List<ResearchIndex>? researchIndex;
  List<ResearchTags>? researchTags;

  PaperSearch(
      {this.id,
      this.researchPaperName,
      this.paperNumber,
      this.description,
      this.purchaseLink,
      this.regularPrice,
      this.discountType,
      this.discount,
      this.discountPrice,
      this.researchPaperAuthorId,
      this.researchPaperAuthor,
      this.publicationId,
      this.publicationName,
      this.coverImage,
      this.researchIndex,
      this.researchTags});

  PaperSearch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    researchPaperName = json['research_paper_name'];
    paperNumber = json['paper_number'];
    description = json['description'];
    purchaseLink = json['purchase_link'];
    regularPrice = json['regular_price'];
    discountType = json['discount_type'];
    discount = json['discount'];
    discountPrice = json['discount_price'];
    researchPaperAuthorId = json['research_paper_author_id'];
    researchPaperAuthor = json['research_paper_author'];
    publicationId = json['publication_id'];
    publicationName = json['publication_name'];
    coverImage = json['cover_image'];
    if (json['research_index'] != null) {
      researchIndex = <ResearchIndex>[];
      json['research_index'].forEach((v) {
        researchIndex!.add(new ResearchIndex.fromJson(v));
      });
    }
    if (json['research_tags'] != null) {
      researchTags = <ResearchTags>[];
      json['research_tags'].forEach((v) {
        researchTags!.add(new ResearchTags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['research_paper_name'] = this.researchPaperName;
    data['paper_number'] = this.paperNumber;
    data['description'] = this.description;
    data['purchase_link'] = this.purchaseLink;
    data['regular_price'] = this.regularPrice;
    data['discount_type'] = this.discountType;
    data['discount'] = this.discount;
    data['discount_price'] = this.discountPrice;
    data['research_paper_author_id'] = this.researchPaperAuthorId;
    data['research_paper_author'] = this.researchPaperAuthor;
    data['publication_id'] = this.publicationId;
    data['publication_name'] = this.publicationName;
    data['cover_image'] = this.coverImage;
    if (this.researchIndex != null) {
      data['research_index'] =
          this.researchIndex!.map((v) => v.toJson()).toList();
    }
    if (this.researchTags != null) {
      data['research_tags'] =
          this.researchTags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResearchIndex {
  int? researchPaperId;
  String? indexName;
  int? indexPosition;
  String? content;

  ResearchIndex(
      {this.researchPaperId, this.indexName, this.indexPosition, this.content});

  ResearchIndex.fromJson(Map<String, dynamic> json) {
    researchPaperId = json['research_paper_id'];
    indexName = json['index_name'];
    indexPosition = json['index_position'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['research_paper_id'] = this.researchPaperId;
    data['index_name'] = this.indexName;
    data['index_position'] = this.indexPosition;
    data['content'] = this.content;
    return data;
  }
}

class ResearchTags {
  int? researchPaperId;
  int? tagId;
  String? tagName;

  ResearchTags({this.researchPaperId, this.tagId, this.tagName});

  ResearchTags.fromJson(Map<String, dynamic> json) {
    researchPaperId = json['research_paper_id'];
    tagId = json['tag_id'];
    tagName = json['tag_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['research_paper_id'] = this.researchPaperId;
    data['tag_id'] = this.tagId;
    data['tag_name'] = this.tagName;
    return data;
  }
}
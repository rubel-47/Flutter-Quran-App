class Lecture {
  int? id;
  String? lectureName;
  String? videoTitle;
  String? videoDuration;
  String? embeddedCode;
  int? categoryId;
  String? categoryName;
  List<LectureTag>? lectureTag;

  Lecture(
      {this.id,
      this.lectureName,
      this.videoTitle,
      this.videoDuration,
      this.embeddedCode,
      this.categoryId,
      this.categoryName,
      this.lectureTag});

  Lecture.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lectureName = json['lecture_name'];
    videoTitle = json['video_title'];
    videoDuration = json['video_duration'];
    embeddedCode = json['embedded_code'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    if (json['lecture_tag'] != null) {
      lectureTag = <LectureTag>[];
      json['lecture_tag'].forEach((v) {
        lectureTag!.add(new LectureTag.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lecture_name'] = this.lectureName;
    data['video_title'] = this.videoTitle;
    data['video_duration'] = this.videoDuration;
    data['embedded_code'] = this.embeddedCode;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    if (this.lectureTag != null) {
      data['lecture_tag'] = this.lectureTag!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LectureTag {
  int? lectureId;
  int? tagId;
  String? lectureTagName;

  LectureTag({this.lectureId, this.tagId, this.lectureTagName});

  LectureTag.fromJson(Map<String, dynamic> json) {
    lectureId = json['lecture_id'];
    tagId = json['tag_id'];
    lectureTagName = json['lecture_tag_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lecture_id'] = this.lectureId;
    data['tag_id'] = this.tagId;
    data['lecture_tag_name'] = this.lectureTagName;
    return data;
  }
}
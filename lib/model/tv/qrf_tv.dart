class QrfTv {
  int? id;
  String? videoTitle;
  String? videoDuration;
  String? videoId;
  int? categoryId;
  String? categoryName;
  List<VideoTag>? videoTag;

  QrfTv(
      {this.id,
      this.videoTitle,
      this.videoDuration,
      this.videoId,
      this.categoryId,
      this.categoryName,
      this.videoTag});

  QrfTv.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoTitle = json['video_title'];
    videoDuration = json['video_duration'];
    videoId = json['video_id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    if (json['video_tag'] != null) {
      videoTag = <VideoTag>[];
      json['video_tag'].forEach((v) {
        videoTag!.add(new VideoTag.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['video_title'] = this.videoTitle;
    data['video_duration'] = this.videoDuration;
    data['video_id'] = this.videoId;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    if (this.videoTag != null) {
      data['video_tag'] = this.videoTag!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoTag {
  int? videoId;
  int? tagId;
  String? qrfTagName;

  VideoTag({this.videoId, this.tagId, this.qrfTagName});

  VideoTag.fromJson(Map<String, dynamic> json) {
    videoId = json['video_id'];
    tagId = json['tag_id'];
    qrfTagName = json['qrf_tag_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video_id'] = this.videoId;
    data['tag_id'] = this.tagId;
    data['qrf_tag_name'] = this.qrfTagName;
    return data;
  }
}
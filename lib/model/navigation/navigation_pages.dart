class Pages {
  int? id;
  String? pageTitle;
  String? menuName;
  String? menuIcon;
  String? description;
  String? link;
  String? featureImage;

  Pages(
      {this.id,
      this.pageTitle,
      this.menuName,
      this.menuIcon,
      this.description,
      this.link,
      this.featureImage});

  Pages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pageTitle = json['page_title'];
    menuName = json['menu_name'];
    menuIcon = json['menu_icon'];
    description = json['description'];
    link = json['link'];
    featureImage = json['feature_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['page_title'] = this.pageTitle;
    data['menu_name'] = this.menuName;
    data['menu_icon'] = this.menuIcon;
    data['description'] = this.description;
    data['link'] = this.link;
    data['feature_image'] = this.featureImage;
    return data;
  }
}
class Categories {
  String id;
  String title;
  String shortDetails;
  String banner;
  List<SubCategories> subCategories;

  Categories(
      {this.id,
        this.title,
        this.shortDetails,
        this.banner,
        this.subCategories});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortDetails = json['short_details'];
    banner = json['banner'];
    if (json['sub_categories'] != null) {
      subCategories = new List<SubCategories>();
      json['sub_categories'].forEach((v) {
        subCategories.add(new SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['short_details'] = this.shortDetails;
    data['banner'] = this.banner;
    if (this.subCategories != null) {
      data['sub_categories'] =
          this.subCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  String id;
  String title;
  String photo;

  SubCategories({this.id, this.title, this.photo});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['photo'] = this.photo;
    return data;
  }
}
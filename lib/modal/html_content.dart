class HtmlContent {
  String id;
  String title;
  String content;
  String createdDate;
  String deletedFlag;

  HtmlContent(
      {this.id, this.title, this.content, this.createdDate, this.deletedFlag});

  HtmlContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createdDate = json['created_date'];
    deletedFlag = json['deleted_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['created_date'] = this.createdDate;
    data['deleted_flag'] = this.deletedFlag;
    return data;
  }
}
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Faq {
  String id;
  String question;
  String answer;
  String createdDate;
  String updatedDate;
  String userId;
  String deletedFlag;

  Faq(
      {this.id,
        this.question,
        this.answer,
        this.createdDate,
        this.updatedDate,
        this.userId,
        this.deletedFlag,
      });

  Faq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    userId = json['user_id'];
    deletedFlag = json['deleted_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['user_id'] = this.userId;
    data['deleted_flag'] = this.deletedFlag;
    return data;
  }
}

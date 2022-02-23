import 'package:get/get.dart';

class TimeSlotModal {
  List<TimeSlot> timelsots;
  int tomorrow;

  TimeSlotModal({this.timelsots, this.tomorrow});

  TimeSlotModal.fromJson(Map<String, dynamic> json) {
    if (json['timelsots'] != null) {
      timelsots = new List<TimeSlot>();
      json['timelsots'].forEach((v) {
        timelsots.add(new TimeSlot.fromJson(v));
      });
    }
    tomorrow = json['tomorrow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timelsots != null) {
      data['timelsots'] = this.timelsots.map((v) => v.toJson()).toList();
    }
    data['tomorrow'] = this.tomorrow;
    return data;
  }
}

class TimeSlot {
  String id;
  String timeFrom;
  String timeTo;
  RxString status=''.obs;

  TimeSlot({this.id, this.timeFrom, this.timeTo, this.status});

  TimeSlot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
    status.value = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time_from'] = this.timeFrom;
    data['time_to'] = this.timeTo;
    data['status'] = this.status;
    return data;
  }
}

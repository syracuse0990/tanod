
import 'feedback_model.dart';

class AdminFeedbackDetailModel {
  var statusCode;
  var status;
  var message;
  FeedbackDetailModel? data;

  AdminFeedbackDetailModel({this.statusCode, this.status, this.message, this.data});

  AdminFeedbackDetailModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new FeedbackDetailModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}



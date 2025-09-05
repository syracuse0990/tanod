import 'package:intl/intl.dart';

class FCAResponse {
  final int statusCode;
  final String status;
  final String message;
  final List<FCAData> data;

  FCAResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.data,
  });

  factory FCAResponse.fromJson(Map<String, dynamic> json) {
    return FCAResponse(
      statusCode: json['statusCode'],
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List<dynamic>)
          .map((e) => FCAData.fromJson(e))
          .toList(),
    );
  }
}

class FCAData {
  final int groupId;
  final String groupName;
  final int userId;
  final String userName;
  final int deviceId;
  final String deviceName;
  final int tractorId;
  final String tractorName;
  final String dateTagged;

  FCAData({
    required this.groupId,
    required this.groupName,
    required this.userId,
    required this.userName,
    required this.deviceId,
    required this.deviceName,
    required this.tractorId,
    required this.tractorName,
    required this.dateTagged,
  });

  factory FCAData.fromJson(Map<String, dynamic> json) {
    return FCAData(
      groupId: json['group_id'],
      groupName: json['group_name'],
      userId: json['user_id'],
      userName: json['user_name'],
      deviceId: json['device_id'],
      deviceName: json['device_name'],
      tractorId: json['tractor_id'],
      tractorName: json['tractor_name'],
      dateTagged: json['date_tagged'] != null 
        ? formatDate(json['date_tagged']) 
        : "",
    );
  }
}
String formatDate(String dateString) {
  try {
    DateTime parsedDate = DateTime.parse(dateString).toLocal(); 
    return DateFormat("MM-dd-yyyy hh:mm a").format(parsedDate);
  } catch (e) {
    return "";
  }
}
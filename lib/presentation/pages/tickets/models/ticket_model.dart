import 'package:intl/intl.dart';

class TicketsResponse {
  final int statusCode;
  final String status;
  final String message;
  final TicketsData data;

  TicketsResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.data,
  });

  factory TicketsResponse.fromJson(Map<String, dynamic> json) {
    return TicketsResponse(
      statusCode: json['statusCode'] ?? 0,
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: TicketsData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "statusCode": statusCode,
      "status": status,
      "message": message,
      "data": data.toJson(),
    };
  }
}

class TicketsData {
  final List<Ticket> tickets;
  final int pageNo;
  final int totalEntries;
  final int totalPages;

  TicketsData({
    required this.tickets,
    required this.pageNo,
    required this.totalEntries,
    required this.totalPages,
  });

  factory TicketsData.fromJson(Map<String, dynamic> json) {
    return TicketsData(
      tickets: (json['tickets'] as List<dynamic>? ?? [])
          .map((e) => Ticket.fromJson(e))
          .toList(),
      pageNo: int.tryParse(json['page_no'].toString()) ?? 0,
      totalEntries: int.tryParse(json['total_entries'].toString())  ?? 0,
      totalPages: int.tryParse(json['total_pages'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "tickets": tickets.map((e) => e.toJson()).toList(),
      "page_no": pageNo,
      "total_entries": totalEntries,
      "total_pages": totalPages,
    };
  }
}

class Ticket {
  final int id;
  final String title;
  final String description;
  final String? conclusion;
  final int typeId;
  final int stateId;
  final String createdAt;
  final String updatedAt;
  final int createdBy;

  Ticket({
    required this.id,
    required this.title,
    required this.description,
    this.conclusion,
    required this.typeId,
    required this.stateId,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
  });

factory Ticket.fromJson(Map<String, dynamic> json) {
  return Ticket(
    id: int.tryParse(json['id'].toString()) ?? 0,
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    conclusion: json['conclusion'],
    typeId: int.tryParse(json['type_id'].toString()) ?? 0,
    stateId: int.tryParse(json['state_id'].toString()) ?? 0,
    createdAt: formatDate(json['created_at']),
    updatedAt: json['updated_at'] ?? '',
    createdBy: int.tryParse(json['created_by'].toString()) ?? 0,
  );
}

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "conclusion": conclusion,
      "type_id": typeId,
      "state_id": stateId,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "created_by": createdBy,
    };
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
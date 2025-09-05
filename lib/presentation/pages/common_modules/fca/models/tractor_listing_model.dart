class TractorListResponse {
  final int statusCode;
  final String status;
  final String message;
  final List<Tractor> data;

  TractorListResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.data,
  });

  factory TractorListResponse.fromJson(Map<String, dynamic> json) {
    return TractorListResponse(
      statusCode: json['statusCode'],
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List<dynamic>)
          .map((e) => Tractor.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "statusCode": statusCode,
      "status": status,
      "message": message,
      "data": data.map((e) => e.toJson()).toList(),
    };
  }
}

class Tractor {
  final int id;
  final String tractorName;

  Tractor({
    required this.id,
    required this.tractorName,
  });

  factory Tractor.fromJson(Map<String, dynamic> json) {
    return Tractor(
      id: json['id'],
      tractorName: json['tractor_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "tractor_name": tractorName,
    };
  }
}

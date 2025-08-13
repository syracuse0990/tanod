class FarmersResponse {
  final int statusCode;
  final String status;
  final String message;
  final List<Farmer> data;

  FarmersResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.data,
  });

  factory FarmersResponse.fromJson(Map<String, dynamic> json) {
    return FarmersResponse(
      statusCode: json['statusCode'],
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List<dynamic>)
          .map((item) => Farmer.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'status': status,
      'message': message,
      'data': data.map((farmer) => farmer.toJson()).toList(),
    };
  }
}

class Farmer {
  final int id;
  final String name;
  final String profilePhotoUrl;

  Farmer({
    required this.id,
    required this.name,
    required this.profilePhotoUrl,
  });

  factory Farmer.fromJson(Map<String, dynamic> json) {
    return Farmer(
      id: json['id'],
      name: json['name'],
      profilePhotoUrl: json['profile_photo_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profile_photo_url': profilePhotoUrl,
    };
  }
}

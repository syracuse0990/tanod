class User {
  User(
      {this.token,
      // this.latLng,
      this.name,
      this.email,
      this.profileImage});
  // LatLng? latLng;
  String? token;
  String? name;
  String? email;
  String? profileImage;

  factory User.fromJson(Map<String, dynamic>? json) {
    return User(
      token: json?['token'] as String?,
      name: json?['name'] as String?,
      email: json?['email'] as String?,
      profileImage: json?['profileImage'] as String?,

      // latLng:
      //     json?['latLng'] != null ? LatLng.fromJson(json?['latLng'])! : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'token': token,
        'name': name,
        'email': email,
        'profileImage': profileImage,
        // 'latLng': latLng!.toJson(),
      };
}

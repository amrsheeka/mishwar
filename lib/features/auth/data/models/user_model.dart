class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? profileImage;
  final String? licenseImage;
  final String role;
  final DateTime? emailVerifiedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImage,
    this.licenseImage,
    required this.role,
    this.emailVerifiedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'] ?? '',
      profileImage: json['profile_image'],
      licenseImage: json['license_image'],
      role: json['role'],
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'])
          : null,
    );
  }
}
class UserProfile {
  final String id;
  final String fullName;
  final String email;
  final String profileImage;
  final String phoneNumber;
  final String role;
  final String status;
  final bool isAllowed;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.profileImage,
    required this.phoneNumber,
    required this.role,
    required this.status,
    required this.isAllowed,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profileImage'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      role: json['role'] ?? '',
      status: json['status'] ?? '',
      isAllowed: json['isAllowed'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'profileImage': profileImage,
      'phoneNumber': phoneNumber,
      'role': role,
      'status': status,
      'isAllowed': isAllowed,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

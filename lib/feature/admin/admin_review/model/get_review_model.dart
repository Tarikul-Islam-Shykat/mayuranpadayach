

class ReviewAdminModel {
  final String? id;
  final String? userId;
  final String? specialistId;
  final String? businessId;
  final int? rating;
  final String? comment;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Specialist? user;
  final Specialist? specialist;

  ReviewAdminModel({
    this.id,
    this.userId,
    this.specialistId,
    this.businessId,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.specialist,
  });

  factory ReviewAdminModel.fromJson(Map<String, dynamic> json) => ReviewAdminModel(
    id: json["id"],
    userId: json["userId"],
    specialistId: json["specialistId"],
    businessId: json["businessId"],
    rating: json["rating"],
    comment: json["comment"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    user: json["user"] == null ? null : Specialist.fromJson(json["user"]),
    specialist: json["specialist"] == null ? null : Specialist.fromJson(json["specialist"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "specialistId": specialistId,
    "businessId": businessId,
    "rating": rating,
    "comment": comment,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "user": user?.toJson(),
    "specialist": specialist?.toJson(),
  };
}

class Specialist {
  final String? id;
  final String? fullName;
  final String? profileImage;
  final String? specialization;

  Specialist({
    this.id,
    this.fullName,
    this.profileImage,
    this.specialization,
  });

  factory Specialist.fromJson(Map<String, dynamic> json) => Specialist(
    id: json["id"],
    fullName: json["fullName"],
    profileImage: json["profileImage"],
    specialization: json["specialization"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "profileImage": profileImage,
    "specialization": specialization,
  };
}

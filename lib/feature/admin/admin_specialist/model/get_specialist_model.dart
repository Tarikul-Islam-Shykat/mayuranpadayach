class GetSpecialistModel {
  final String? id;
  final String? businessId;
  final String? serviceId;
  final String? fullName;
  final String? phoneNumber;
  final String? profileImage;
  final String? specialization;
  final String? status;
  final int? experience;
  final int? totalRating;
  final int? totalWorks;
  final bool? isAvailable;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Business? business;
  final Business? service;

  GetSpecialistModel({
    this.id,
    this.businessId,
    this.serviceId,
    this.fullName,
    this.phoneNumber,
    this.profileImage,
    this.specialization,
    this.status,
    this.experience,
    this.totalRating,
    this.totalWorks,
    this.isAvailable,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.business,
    this.service,
  });

  factory GetSpecialistModel.fromJson(Map<String, dynamic> json) => GetSpecialistModel(
    id: json["id"],
    businessId: json["businessId"],
    serviceId: json["serviceId"],
    fullName: json["fullName"],
    phoneNumber: json["phoneNumber"],
    profileImage: json["profileImage"],
    specialization: json["specialization"],
    status: json["status"],
    experience: json["experience"],
    totalRating: json["totalRating"],
    totalWorks: json["totalWorks"],
    isAvailable: json["isAvailable"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    business: json["business"] == null ? null : Business.fromJson(json["business"]),
    service: json["service"] == null ? null : Business.fromJson(json["service"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "businessId": businessId,
    "serviceId": serviceId,
    "fullName": fullName,
    "phoneNumber": phoneNumber,
    "profileImage": profileImage,
    "specialization": specialization,
    "status": status,
    "experience": experience,
    "totalRating": totalRating,
    "totalWorks": totalWorks,
    "isAvailable": isAvailable,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "business": business?.toJson(),
    "service": service?.toJson(),
  };
}

class Business {
  final String? name;

  Business({
    this.name,
  });

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
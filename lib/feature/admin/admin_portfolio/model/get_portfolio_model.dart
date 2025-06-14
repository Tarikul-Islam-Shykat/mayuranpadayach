
class GetPortfolioModel {
  String? id;
  String? title;
  String? specialistId;
  String? image;
  String? businessId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Specialist? specialist;
  Business? business;

  GetPortfolioModel({
    this.id,
    this.title,
    this.specialistId,
    this.image,
    this.businessId,
    this.createdAt,
    this.updatedAt,
    this.specialist,
    this.business,
  });

  factory GetPortfolioModel.fromJson(Map<String, dynamic> json) => GetPortfolioModel(
    id: json["id"],
    title: json["title"],
    specialistId: json["specialistId"],
    image: json["image"],
    businessId: json["businessId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    specialist: json["specialist"] == null ? null : Specialist.fromJson(json["specialist"]),
    business: json["business"] == null ? null : Business.fromJson(json["business"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "specialistId": specialistId,
    "image": image,
    "businessId": businessId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "specialist": specialist?.toJson(),
    "business": business?.toJson(),
  };
}

class Business {
  String? name;

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

class Specialist {
  String? fullName;
  String? profileImage;

  Specialist({
    this.fullName,
    this.profileImage,
  });

  factory Specialist.fromJson(Map<String, dynamic> json) => Specialist(
    fullName: json["fullName"],
    profileImage: json["profileImage"],
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "profileImage": profileImage,
  };
}

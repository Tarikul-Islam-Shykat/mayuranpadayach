class ServiceModel {
  String? id;
  String? name;
  String? description;
  int? price;
  String? image;
  bool? isActive;
  bool? isOffered;
  int? offeredPercent;
  String? businessId;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  Business? business;

  ServiceModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.image,
    this.isActive,
    this.isOffered,
    this.offeredPercent,
    this.businessId,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.business,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    image: json["image"],
    isActive: json["isActive"],
    isOffered: json["isOffered"],
    offeredPercent: json["offeredPercent"],
    businessId: json["businessId"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    business: json["business"] == null ? null : Business.fromJson(json["business"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "image": image,
    "isActive": isActive,
    "isOffered": isOffered,
    "offeredPercent": offeredPercent,
    "businessId": businessId,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "business": business?.toJson(),
  };
}

class Business {
  String? name;
  String? image;

  Business({
    this.name,
    this.image,
  });

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
  };
}
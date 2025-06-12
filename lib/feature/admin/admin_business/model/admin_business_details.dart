class AdminBusinessDetails {
  final String? id;
  final String? name;
  final String? about;
  final String? contactNumber;
  final String? image;
  final String? categoryId;
  final String? subCategoryId;
  final double? latitude;
  final double? longitude;
  final String? address;
  final DateTime? openingHours;
  final DateTime? closingHours;
  final String? status;
  final String? openStatus;
  final String? userId;
  final bool? isDeleted;
  final int? overallRating;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Category? category;
  final SubCategory? subCategory;

  AdminBusinessDetails({
    this.id,
    this.name,
    this.about,
    this.contactNumber,
    this.image,
    this.categoryId,
    this.subCategoryId,
    this.latitude,
    this.longitude,
    this.address,
    this.openingHours,
    this.closingHours,
    this.status,
    this.openStatus,
    this.userId,
    this.isDeleted,
    this.overallRating,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.subCategory,
  });

  factory AdminBusinessDetails.fromJson(Map<String, dynamic> json) => AdminBusinessDetails(
    id: json["id"],
    name: json["name"],
    about: json["about"],
    contactNumber: json["contactNumber"],
    image: json["image"],
    categoryId: json["categoryId"],
    subCategoryId: json["subCategoryId"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    address: json["address"],
    openingHours: json["openingHours"] == null ? null : DateTime.parse(json["openingHours"]),
    closingHours: json["closingHours"] == null ? null : DateTime.parse(json["closingHours"]),
    status: json["status"],
    openStatus: json["openStatus"],
    userId: json["userId"],
    isDeleted: json["isDeleted"],
    overallRating: json["overallRating"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    subCategory: json["subCategory"] == null ? null : SubCategory.fromJson(json["subCategory"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "about": about,
    "contactNumber": contactNumber,
    "image": image,
    "categoryId": categoryId,
    "subCategoryId": subCategoryId,
    "latitude": latitude,
    "longitude": longitude,
    "address": address,
    "openingHours": openingHours?.toIso8601String(),
    "closingHours": closingHours?.toIso8601String(),
    "status": status,
    "openStatus": openStatus,
    "userId": userId,
    "isDeleted": isDeleted,
    "overallRating": overallRating,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "category": category?.toJson(),
    "subCategory": subCategory?.toJson(),
  };
}

class Category {
  final String? id;
  final String? name;
  final String? image;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? categoryId;

  Category({
    this.id,
    this.name,
    this.image,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    categoryId: json["categoryId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "categoryId": categoryId,
  };
}
class SubCategory {
  final String? id;
  final String? name;
  final String? image;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? categoryId;

  SubCategory({
    this.id,
    this.name,
    this.image,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    categoryId: json["categoryId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "categoryId": categoryId,
  };
}
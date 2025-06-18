class BusinessData {
  final String id;
  final String name;
  final String about;
  final String contactNumber;
  final String image;
  final String categoryId;
  final String subCategoryId;
  final double latitude;
  final double longitude;
  final String address;
  final String openingHours;
  final String closingHours;
  final String status;
  final String openStatus;
  final String userId;
  final bool isDeleted;
  final int overallRating;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Category category;
  final SubCategory subCategory;

  BusinessData({
    required this.id,
    required this.name,
    required this.about,
    required this.contactNumber,
    required this.image,
    required this.categoryId,
    required this.subCategoryId,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.openingHours,
    required this.closingHours,
    required this.status,
    required this.openStatus,
    required this.userId,
    required this.isDeleted,
    required this.overallRating,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.subCategory,
  });

  factory BusinessData.fromJson(Map<String, dynamic> json) {
    return BusinessData(
      id: json['id'],
      name: json['name'],
      about: json['about'],
      contactNumber: json['contactNumber'],
      image: json['image'],
      categoryId: json['categoryId'],
      subCategoryId: json['subCategoryId'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'],
      openingHours: json['openingHours'],
      closingHours: json['closingHours'],
      status: json['status'],
      openStatus: json['openStatus'],
      userId: json['userId'],
      isDeleted: json['isDeleted'],
      overallRating: json['overallRating'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      category: Category.fromJson(json['category']),
      subCategory: SubCategory.fromJson(json['subCategory']),
    );
  }
}

class Category {
  final String id;
  final String name;
  final String image;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      isDeleted: json['isDeleted'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class SubCategory {
  final String id;
  final String name;
  final String categoryId;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  SubCategory({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      categoryId: json['categoryId'],
      isDeleted: json['isDeleted'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

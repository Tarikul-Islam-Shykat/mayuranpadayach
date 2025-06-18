// business_model.dart
class BusinessListResponse {
  final bool success;
  final String message;
  final BusinessData data;

  BusinessListResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BusinessListResponse.fromJson(Map<String, dynamic> json) {
    return BusinessListResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: BusinessData.fromJson(json['data'] ?? {}),
    );
  }
}

class BusinessData {
  final Meta meta;
  final List<Business> businesses;

  BusinessData({
    required this.meta,
    required this.businesses,
  });

  factory BusinessData.fromJson(Map<String, dynamic> json) {
    return BusinessData(
      meta: Meta.fromJson(json['meta'] ?? {}),
      businesses: (json['data'] as List<dynamic>?)
              ?.map((item) => Business.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class Meta {
  final int page;
  final int limit;
  final int total;

  Meta({
    required this.page,
    required this.limit,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
    );
  }
}

class Business {
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
  final double overallRating;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Category category;
  final SubCategory subCategory;

  Business({
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

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      about: json['about'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
      image: json['image'] ?? '',
      categoryId: json['categoryId'] ?? '',
      subCategoryId: json['subCategoryId'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      address: json['address'] ?? '',
      openingHours: json['openingHours'] ?? '',
      closingHours: json['closingHours'] ?? '',
      status: json['status'] ?? '',
      openStatus: json['openStatus'] ?? '',
      userId: json['userId'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      overallRating: (json['overallRating'] ?? 0.0).toDouble(),
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      category: Category.fromJson(json['category'] ?? {}),
      subCategory: SubCategory.fromJson(json['subCategory'] ?? {}),
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
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
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
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      categoryId: json['categoryId'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}

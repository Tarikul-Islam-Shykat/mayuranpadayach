// business_response_model.dart
class BusinessResponseModel {
  final bool success;
  final String message;
  final BusinessData data;

  BusinessResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BusinessResponseModel.fromJson(Map<String, dynamic> json) {
    return BusinessResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: BusinessData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

// business_data_model.dart
class BusinessData {
  final Meta meta;
  final List<CardSwiperBusiness> data;

  BusinessData({
    required this.meta,
    required this.data,
  });

  factory BusinessData.fromJson(Map<String, dynamic> json) {
    return BusinessData(
      meta: Meta.fromJson(json['meta'] ?? {}),
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => CardSwiperBusiness.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meta': meta.toJson(),
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

// meta_model.dart
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
      page: json['page'] ?? 0,
      limit: json['limit'] ?? 0,
      total: json['total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'total': total,
    };
  }
}

// business_model.dart
class CardSwiperBusiness {
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

  CardSwiperBusiness({
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

  factory CardSwiperBusiness.fromJson(Map<String, dynamic> json) {
    return CardSwiperBusiness(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      about: json['about'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
      image: json['image'] ?? '',
      categoryId: json['categoryId'] ?? '',
      subCategoryId: json['subCategoryId'] ?? '',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      address: json['address'] ?? '',
      openingHours: json['openingHours'] ?? '',
      closingHours: json['closingHours'] ?? '',
      status: json['status'] ?? '',
      openStatus: json['openStatus'] ?? '',
      userId: json['userId'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      overallRating: (json['overallRating'] ?? 0).toDouble(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      category: Category.fromJson(json['category'] ?? {}),
      subCategory: SubCategory.fromJson(json['subCategory'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'about': about,
      'contactNumber': contactNumber,
      'image': image,
      'categoryId': categoryId,
      'subCategoryId': subCategoryId,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'openingHours': openingHours,
      'closingHours': closingHours,
      'status': status,
      'openStatus': openStatus,
      'userId': userId,
      'isDeleted': isDeleted,
      'overallRating': overallRating,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'category': category.toJson(),
      'subCategory': subCategory.toJson(),
    };
  }
}

// category_model.dart
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
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'isDeleted': isDeleted,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

// subcategory_model.dart
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
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'isDeleted': isDeleted,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

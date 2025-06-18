class FavoriteItem {
  final String id;
  final String userId;
  final String businessId;
  final bool isFavorite;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Business business;

  FavoriteItem({
    required this.id,
    required this.userId,
    required this.businessId,
    required this.isFavorite,
    required this.createdAt,
    required this.updatedAt,
    required this.business,
  });

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json['id'],
      userId: json['userId'],
      businessId: json['businessId'],
      isFavorite: json['isFavorite'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      business: Business.fromJson(json['business']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'businessId': businessId,
      'isFavorite': isFavorite,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'business': business.toJson(),
    };
  }
}

class Business {
  final String id;
  final String name;
  final String image;
  final String address;
  final Category category;
  final int overallRating;

  Business({
    required this.id,
    required this.name,
    required this.image,
    required this.address,
    required this.category,
    required this.overallRating,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      address: json['address'],
      category: Category.fromJson(json['category']),
      overallRating: json['overallRating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'address': address,
      'category': category.toJson(),
      'overallRating': overallRating,
    };
  }
}

class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}

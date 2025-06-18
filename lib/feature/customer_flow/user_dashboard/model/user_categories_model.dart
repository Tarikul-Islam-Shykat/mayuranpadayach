class UserCategoriesModel {
  final String id;
  final String name;
  final String? image;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<SubCategory> subCategories;

  UserCategoriesModel({
    required this.id,
    required this.name,
    this.image,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.subCategories,
  });

  factory UserCategoriesModel.fromJson(Map<String, dynamic> json) {
    var subCats = <SubCategory>[];
    if (json['subCategories'] != null) {
      subCats = List<Map<String, dynamic>>.from(json['subCategories'])
          .map((e) => SubCategory.fromJson(e))
          .toList();
    }
    return UserCategoriesModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'],
      isDeleted: json['isDeleted'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      subCategories: subCats,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'isDeleted': isDeleted,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'subCategories': subCategories.map((e) => e.toJson()).toList(),
      };
}

class SubCategory {
  final String id;
  final String name;

  SubCategory({
    required this.id,
    required this.name,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

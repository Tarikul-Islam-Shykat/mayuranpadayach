

class CategoryModel {
  final String id;
  final String name;
  final String image;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;
  final List<SubCategoryModel> subCategories;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.subCategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      isDeleted: json['isDeleted'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      subCategories: List<SubCategoryModel>.from(
        json['subCategories'].map((x) => SubCategoryModel.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'isDeleted': isDeleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'subCategories': subCategories.map((x) => x.toJson()).toList(),
    };
  }
}
class SubCategoryModel {
  final String id;
  final String name;

  SubCategoryModel({
    required this.id,
    required this.name,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}


// // To parse this JSON data, do
// //
// //     final businessCategoryAndSubCategory = businessCategoryAndSubCategoryFromJson(jsonString);
//
// import 'dart:convert';
//
// BusinessCategoryAndSubCategory businessCategoryAndSubCategoryFromJson(String str) => BusinessCategoryAndSubCategory.fromJson(json.decode(str));
//
// String businessCategoryAndSubCategoryToJson(BusinessCategoryAndSubCategory data) => json.encode(data.toJson());
//
// class BusinessCategoryAndSubCategory {
//   final bool? success;
//   final String? message;
//   final List<Datum>? data;
//
//   BusinessCategoryAndSubCategory({
//     this.success,
//     this.message,
//     this.data,
//   });
//
//   factory BusinessCategoryAndSubCategory.fromJson(Map<String, dynamic> json) => BusinessCategoryAndSubCategory(
//     success: json["success"],
//     message: json["message"],
//     data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "message": message,
//     "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   final String? id;
//   final String? name;
//   final String? image;
//   final bool? isDeleted;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final List<SubCategory>? subCategories;
//
//   Datum({
//     this.id,
//     this.name,
//     this.image,
//     this.isDeleted,
//     this.createdAt,
//     this.updatedAt,
//     this.subCategories,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     name: json["name"],
//     image: json["image"],
//     isDeleted: json["isDeleted"],
//     createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//     updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//     subCategories: json["subCategories"] == null ? [] : List<SubCategory>.from(json["subCategories"]!.map((x) => SubCategory.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "image": image,
//     "isDeleted": isDeleted,
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//     "subCategories": subCategories == null ? [] : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
//   };
// }
//
// class SubCategory {
//   final String? id;
//   final String? name;
//
//   SubCategory({
//     this.id,
//     this.name,
//   });
//
//   factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
//     id: json["id"],
//     name: json["name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//   };
// }

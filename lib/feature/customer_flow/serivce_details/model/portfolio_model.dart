class PortfolioItem {
  final String id;
  final String title;
  final String specialistId;
  final String image;
  final String businessId;
  final String createdAt;
  final String updatedAt;
  final SpecialistPortfolio specialist;
  final Business business;

  PortfolioItem({
    required this.id,
    required this.title,
    required this.specialistId,
    required this.image,
    required this.businessId,
    required this.createdAt,
    required this.updatedAt,
    required this.specialist,
    required this.business,
  });

  factory PortfolioItem.fromJson(Map<String, dynamic> json) {
    return PortfolioItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      specialistId: json['specialistId'] ?? '',
      image: json['image'] ?? '',
      businessId: json['businessId'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      specialist: SpecialistPortfolio.fromJson(json['specialist'] ?? {}),
      business: Business.fromJson(json['business'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'specialistId': specialistId,
      'image': image,
      'businessId': businessId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'specialist': specialist.toJson(),
      'business': business.toJson(),
    };
  }
}

class SpecialistPortfolio {
  final String fullName;
  final String profileImage;

  SpecialistPortfolio({
    required this.fullName,
    required this.profileImage,
  });

  factory SpecialistPortfolio.fromJson(Map<String, dynamic> json) {
    return SpecialistPortfolio(
      fullName: json['fullName'] ?? '',
      profileImage: json['profileImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'profileImage': profileImage,
    };
  }
}

class Business {
  final String name;

  Business({required this.name});

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}

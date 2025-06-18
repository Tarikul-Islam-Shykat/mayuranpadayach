class ServiceData {
  final Meta meta;
  final List<Service> services;

  ServiceData({
    required this.meta,
    required this.services,
  });

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    return ServiceData(
      meta: Meta.fromJson(json['meta']),
      services: json['data'] != null
          ? List<Service>.from(
              json['data'].map((x) => Service.fromJson(x)),
            )
          : [],
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
      page: json['page'] ?? 0,
      limit: json['limit'] ?? 0,
      total: json['total'] ?? 0,
    );
  }
}

class Service {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final bool isActive;
  final bool isOffered;
  final int offeredPercent;
  final String businessId;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Business business;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.isActive,
    required this.isOffered,
    required this.offeredPercent,
    required this.businessId,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.business,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      image: json['image'] ?? '',
      isActive: json['isActive'] ?? false,
      isOffered: json['isOffered'] ?? false,
      offeredPercent: json['offeredPercent'] ?? 0,
      businessId: json['businessId'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      business: Business.fromJson(json['business'] ?? {}),
    );
  }
}

class Business {
  final String name;
  final String image;

  Business({
    required this.name,
    required this.image,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

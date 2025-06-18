// booking_model.dart
class BookingModel {
  final String id;
  final String userId;
  final String businessId;
  final String serviceId;
  final String specialistId;
  final DateTime bookingDate;
  final double totalPrice;
  final bool paymentStatus;
  final String status;
  final String bookingStatus;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserInfo user;
  final BusinessInfo business;
  final ServiceInfo service;
  final SpecialistInfo specialist;

  BookingModel({
    required this.id,
    required this.userId,
    required this.businessId,
    required this.serviceId,
    required this.specialistId,
    required this.bookingDate,
    required this.totalPrice,
    required this.paymentStatus,
    required this.status,
    required this.bookingStatus,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.business,
    required this.service,
    required this.specialist,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      businessId: json['businessId'] ?? '',
      serviceId: json['serviceId'] ?? '',
      specialistId: json['specialistId'] ?? '',
      bookingDate: DateTime.parse(json['bookingDate']),
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      paymentStatus: json['paymentStatus'] ?? false,
      status: json['status'] ?? '',
      bookingStatus: json['bookingStatus'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      user: UserInfo.fromJson(json['user'] ?? {}),
      business: BusinessInfo.fromJson(json['business'] ?? {}),
      service: ServiceInfo.fromJson(json['service'] ?? {}),
      specialist: SpecialistInfo.fromJson(json['specialist'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'businessId': businessId,
      'serviceId': serviceId,
      'specialistId': specialistId,
      'bookingDate': bookingDate.toIso8601String(),
      'totalPrice': totalPrice,
      'paymentStatus': paymentStatus,
      'status': status,
      'bookingStatus': bookingStatus,
      'isDeleted': isDeleted,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'user': user.toJson(),
      'business': business.toJson(),
      'service': service.toJson(),
      'specialist': specialist.toJson(),
    };
  }
}

class UserInfo {
  final String fullName;
  final String profileImage;

  UserInfo({
    required this.fullName,
    required this.profileImage,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
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

class BusinessInfo {
  final String name;
  final String image;
  final String address;
  final double overallRating;

  BusinessInfo({
    required this.name,
    required this.image,
    required this.address,
    required this.overallRating,
  });

  factory BusinessInfo.fromJson(Map<String, dynamic> json) {
    return BusinessInfo(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      address: json['address'] ?? '',
      overallRating: (json['overallRating'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'address': address,
      'overallRating': overallRating,
    };
  }
}

class ServiceInfo {
  final String name;
  final double price;

  ServiceInfo({
    required this.name,
    required this.price,
  });

  factory ServiceInfo.fromJson(Map<String, dynamic> json) {
    return ServiceInfo(
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
    };
  }
}

class SpecialistInfo {
  final String fullName;
  final String profileImage;
  final String specialization;

  SpecialistInfo({
    required this.fullName,
    required this.profileImage,
    required this.specialization,
  });

  factory SpecialistInfo.fromJson(Map<String, dynamic> json) {
    return SpecialistInfo(
      fullName: json['fullName'] ?? '',
      profileImage: json['profileImage'] ?? '',
      specialization: json['specialization'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'profileImage': profileImage,
      'specialization': specialization,
    };
  }
}

class BookingResponse {
  final bool success;
  final String message;
  final BookingData data;

  BookingResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: BookingData.fromJson(json['data'] ?? {}),
    );
  }
}

class BookingData {
  final BookingMeta meta;
  final List<BookingModel> result;

  BookingData({
    required this.meta,
    required this.result,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      meta: BookingMeta.fromJson(json['meta'] ?? {}),
      result: (json['result'] as List<dynamic>?)
              ?.map((e) => BookingModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class BookingMeta {
  final int page;
  final int limit;
  final int total;

  BookingMeta({
    required this.page,
    required this.limit,
    required this.total,
  });

  factory BookingMeta.fromJson(Map<String, dynamic> json) {
    return BookingMeta(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
    );
  }
}

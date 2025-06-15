class BookingAdminModel {
  final String? id;
  final String? userId;
  final String? businessId;
  final String? serviceId;
  final String? specialistId;
  final DateTime? bookingDate;
  final int? totalPrice;
  final bool? paymentStatus;
  final String? status;
  final String? bookingStatus;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;
  final Business? business;
  final Service? service;

  BookingAdminModel({
    this.id,
    this.userId,
    this.businessId,
    this.serviceId,
    this.specialistId,
    this.bookingDate,
    this.totalPrice,
    this.paymentStatus,
    this.status,
    this.bookingStatus,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.business,
    this.service,
  });

  factory BookingAdminModel.fromJson(Map<String, dynamic> json) => BookingAdminModel(
    id: json["id"],
    userId: json["userId"],
    businessId: json["businessId"],
    serviceId: json["serviceId"],
    specialistId: json["specialistId"],
    bookingDate: json["bookingDate"] == null ? null : DateTime.parse(json["bookingDate"]),
    totalPrice: json["totalPrice"],
    paymentStatus: json["paymentStatus"],
    status: json["status"],
    bookingStatus: json["bookingStatus"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    business: json["business"] == null ? null : Business.fromJson(json["business"]),
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "businessId": businessId,
    "serviceId": serviceId,
    "specialistId": specialistId,
    "bookingDate": bookingDate?.toIso8601String(),
    "totalPrice": totalPrice,
    "paymentStatus": paymentStatus,
    "status": status,
    "bookingStatus": bookingStatus,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "user": user?.toJson(),
    "business": business?.toJson(),
    "service": service?.toJson(),
  };
}

class Business {
  final String? name;
  final String? address;

  Business({
    this.name,
    this.address,
  });

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    name: json["name"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
  };
}

class Service {
  final String? name;
  final int? price;

  Service({
    this.name,
    this.price,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    name: json["name"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
  };
}

class User {
  final String? fullName;
  final String? profileImage;

  User({
    this.fullName,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    fullName: json["fullName"],
    profileImage: json["profileImage"],
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "profileImage": profileImage,
  };
}

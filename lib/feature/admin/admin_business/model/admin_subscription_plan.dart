
class AdminSubscriptionModel {
  final String? id;
  final String? title;
  final int? price;
  final int? duration;
  final String? status;
  final int? platformFee;
  final Features? features;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AdminSubscriptionModel({
    this.id,
    this.title,
    this.price,
    this.duration,
    this.status,
    this.platformFee,
    this.features,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory AdminSubscriptionModel.fromJson(Map<String, dynamic> json) => AdminSubscriptionModel(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    duration: json["duration"],
    status: json["status"],
    platformFee: json["platformFee"],
    features: json["features"] == null ? null : Features.fromJson(json["features"]),
    createdBy: json["createdBy"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "duration": duration,
    "status": status,
    "platformFee": platformFee,
    "features": features?.toJson(),
    "createdBy": createdBy,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Features {
  final bool? verifiedBadge;
  final bool? inPersonPayments;
  final bool? customQuotes;
  final bool? bookingAndListing;
  final bool? prioritySupport;

  Features({
    this.verifiedBadge,
    this.inPersonPayments,
    this.customQuotes,
    this.bookingAndListing,
    this.prioritySupport,
  });

  factory Features.fromJson(Map<String, dynamic> json) => Features(
    verifiedBadge: json["verifiedBadge"],
    inPersonPayments: json["inPersonPayments"],
    customQuotes: json["customQuotes"],
    bookingAndListing: json["bookingAndListing"],
    prioritySupport: json["prioritySupport"],
  );

  Map<String, dynamic> toJson() => {
    "verifiedBadge": verifiedBadge,
    "inPersonPayments": inPersonPayments,
    "customQuotes": customQuotes,
    "bookingAndListing": bookingAndListing,
    "prioritySupport": prioritySupport,
  };
}


class SubscriptionOffer {
  final String id;
  final String title;
  final int price;
  final int duration;
  final String status;
  final int platformFee;
  final List<FeatureItem> features;
  final String createdAt;
  final String updatedAt;

  SubscriptionOffer({
    required this.id,
    required this.title,
    required this.price,
    required this.duration,
    required this.status,
    required this.platformFee,
    required this.features,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubscriptionOffer.fromJson(Map<String, dynamic> json) {
    final rawFeatures = json['features'] as Map<String, dynamic>;

    return SubscriptionOffer(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      duration: json['duration'],
      status: json['status'],
      platformFee: json['platformFee'],
      features: rawFeatures.entries
          .map((entry) => FeatureItem(category: entry.key, value: entry.value))
          .toList(),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class FeatureItem {
  final String category;
  final bool value;

  FeatureItem({required this.category, required this.value});
}
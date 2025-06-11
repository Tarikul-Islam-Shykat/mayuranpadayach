// models/specialist_model.dart
class SpecialistModel {
  final String id;
  final String name;
  final String specialistType;
  final double rating;
  final int perfectHaircuts;
  final double customerRate;
  final int yearsExperience;
  final List<ReviewModel> reviews;
  final List<String> portfolioImages;
  final String profileImage;
  final bool isBookingAvailable;
  final String bookingDate;

  SpecialistModel({
    required this.id,
    required this.name,
    required this.specialistType,
    required this.rating,
    required this.perfectHaircuts,
    required this.customerRate,
    required this.yearsExperience,
    required this.reviews,
    required this.portfolioImages,
    required this.profileImage,
    this.isBookingAvailable = true,
    this.bookingDate = "",
  });

  factory SpecialistModel.fromJson(Map<String, dynamic> json) {
    return SpecialistModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      specialistType: json['specialistType'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      perfectHaircuts: json['perfectHaircuts'] ?? 0,
      customerRate: (json['customerRate'] ?? 0).toDouble(),
      yearsExperience: json['yearsExperience'] ?? 0,
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((review) => ReviewModel.fromJson(review))
          .toList() ?? [],
      portfolioImages: List<String>.from(json['portfolioImages'] ?? []),
      profileImage: json['profileImage'] ?? '',
      isBookingAvailable: json['isBookingAvailable'] ?? true,
      bookingDate: json['bookingDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialistType': specialistType,
      'rating': rating,
      'perfectHaircuts': perfectHaircuts,
      'customerRate': customerRate,
      'yearsExperience': yearsExperience,
      'reviews': reviews.map((review) => review.toJson()).toList(),
      'portfolioImages': portfolioImages,
      'profileImage': profileImage,
      'isBookingAvailable': isBookingAvailable,
      'bookingDate': bookingDate,
    };
  }
}

class ReviewModel {
  final String id;
  final String reviewerName;
  final String review;
  final double rating;
  final String reviewerImage;
  final DateTime reviewDate;

  ReviewModel({
    required this.id,
    required this.reviewerName,
    required this.review,
    required this.rating,
    required this.reviewerImage,
    required this.reviewDate,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      reviewerName: json['reviewerName'] ?? '',
      review: json['review'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      reviewerImage: json['reviewerImage'] ?? '',
      reviewDate: DateTime.parse(json['reviewDate'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reviewerName': reviewerName,
      'review': review,
      'rating': rating,
      'reviewerImage': reviewerImage,
      'reviewDate': reviewDate.toIso8601String(),
    };
  }
}
// lib/models/studio_model.dart

class StudioModel {
  final String id;
  final String name;
  final String category;
  final double latitude;
  final double longitude;
  final int totalReviews;
  final double rating;
  final int discountPercentage;
  final String basicInfo;
  final List<String> portfolioImages;
  final List<Specialist> specialists;
  final ContactInfo contactInfo;
  final ReviewSummary reviewSummary;
  final List<WrittenReview> writtenReviews;
  final List<SubService> subServices;

  StudioModel({
    required this.id,
    required this.name,
    required this.category,
    required this.latitude,
    required this.longitude,
    required this.totalReviews,
    required this.rating,
    required this.discountPercentage,
    required this.basicInfo,
    required this.portfolioImages,
    required this.specialists,
    required this.contactInfo,
    required this.reviewSummary,
    required this.writtenReviews,
    required this.subServices,
  });
}

class Specialist {
  final String id;
  final String name;
  final String category;
  final String imagePath;
  final double rating;

  Specialist({
    required this.id,
    required this.name,
    required this.category,
    required this.imagePath,
    required this.rating,
  });
}

class ContactInfo {
  final String phone;
  final String email;
  final String address;
  final String website;

  ContactInfo({
    required this.phone,
    required this.email,
    required this.address,
    required this.website,
  });
}

class ReviewSummary {
  final int totalReviews;
  final int fiveStars;
  final int fourStars;
  final int threeStars;
  final int twoStars;
  final int oneStar;

  ReviewSummary({
    required this.totalReviews,
    required this.fiveStars,
    required this.fourStars,
    required this.threeStars,
    required this.twoStars,
    required this.oneStar,
  });

  double get fiveStarPercentage => (fiveStars / totalReviews) * 100;
  double get fourStarPercentage => (fourStars / totalReviews) * 100;
  double get threeStarPercentage => (threeStars / totalReviews) * 100;
  double get twoStarPercentage => (twoStars / totalReviews) * 100;
  double get oneStarPercentage => (oneStar / totalReviews) * 100;
}

class WrittenReview {
  final String id;
  final String comment;
  final double rating;
  final String userName;
  final DateTime reviewTime;
  final String userAvatar;

  WrittenReview({
    required this.id,
    required this.comment,
    required this.rating,
    required this.userName,
    required this.reviewTime,
    required this.userAvatar,
  });
}

class SubService {
  final String id;
  final String serviceImage;
  final String name;
  final double amount;
  final int durationHours;

  SubService({
    required this.id,
    required this.serviceImage,
    required this.name,
    required this.amount,
    required this.durationHours,
  });
}
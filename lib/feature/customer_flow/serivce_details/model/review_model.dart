class Review {
  final String id;
  final String userId;
  final String specialistId;
  final String businessId;
  final int rating;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ReviewUser user;
  final SpecialistReview specialist;

  Review({
    required this.id,
    required this.userId,
    required this.specialistId,
    required this.businessId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.specialist,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      specialistId: json['specialistId'] ?? '',
      businessId: json['businessId'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      user: ReviewUser.fromJson(json['user'] ?? {}),
      specialist: SpecialistReview.fromJson(json['specialist'] ?? {}),
    );
  }
}

class ReviewUser {
  final String id;
  final String fullName;
  final String profileImage;

  ReviewUser({
    required this.id,
    required this.fullName,
    required this.profileImage,
  });

  factory ReviewUser.fromJson(Map<String, dynamic> json) {
    return ReviewUser(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      profileImage: json['profileImage'] ?? '',
    );
  }
}

class SpecialistReview {
  final String id;
  final String fullName;
  final String profileImage;
  final String specialization;

  SpecialistReview({
    required this.id,
    required this.fullName,
    required this.profileImage,
    required this.specialization,
  });

  factory SpecialistReview.fromJson(Map<String, dynamic> json) {
    return SpecialistReview(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      profileImage: json['profileImage'] ?? '',
      specialization: json['specialization'] ?? '',
    );
  }
}

class ReviewResponse {
  final bool success;
  final String message;
  final List<Review> data;

  ReviewResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List).map((e) => Review.fromJson(e)).toList(),
    );
  }
}

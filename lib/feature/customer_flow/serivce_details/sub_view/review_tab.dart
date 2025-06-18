// lib/widgets/review_tab.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/feature/customer_flow/serivce_details/controller/service_details_cnt.dart';
import 'package:prettyrini/feature/customer_flow/serivce_details/model/review_model.dart';

class ReviewTab extends StatelessWidget {
  const ReviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    final StudioController controller = Get.find<StudioController>();

    return Obx(() => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Review summary header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  headingText(
                      text: 'All Review (${controller.reviews.length})',
                      fontWeight: FontWeight.bold),
                  Row(
                    children: [
                      const Icon(Icons.star,
                          color: Colors.deepPurple, size: 20),
                      const SizedBox(width: 4),
                      smallText(
                          text: _calculateAverageRating(
                            controller.reviews,
                          ),
                          fontWeight: FontWeight.bold)
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Rating breakdown
              if (controller.reviews.isNotEmpty) ...[
                _buildRatingBar(
                    5, _calculateRatingPercentage(controller.reviews, 5)),
                _buildRatingBar(
                    4, _calculateRatingPercentage(controller.reviews, 4)),
                _buildRatingBar(
                    3, _calculateRatingPercentage(controller.reviews, 3)),
                _buildRatingBar(
                    2, _calculateRatingPercentage(controller.reviews, 2)),
                _buildRatingBar(
                    1, _calculateRatingPercentage(controller.reviews, 1)),
              ],
              const SizedBox(height: 20),

              headingText(
                  text: 'What People Say\'s', fontWeight: FontWeight.bold),

              const SizedBox(height: 10),

              if (controller.reviews.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: normalText(
                        text: 'No reviews available',
                        fontWeight: FontWeight.bold),
                  ),
                )
              else
                ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.reviews.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final review = controller.reviews[index];
                    return _buildReviewCard(review);
                  },
                ),
            ],
          ),
        ));
  }

  // Calculate average rating from the reviews list
  String _calculateAverageRating(List<Review> reviews) {
    if (reviews.isEmpty) return '0.0';

    double totalRating =
        reviews.fold(0.0, (sum, review) => sum + review.rating);
    double average = totalRating / reviews.length;
    return average.toStringAsFixed(1);
  }

  // Calculate percentage for each rating level
  double _calculateRatingPercentage(List<Review> reviews, int rating) {
    if (reviews.isEmpty) return 0.0;

    int count = reviews.where((review) => review.rating == rating).length;
    return (count / reviews.length) * 100;
  }

  Widget _buildRatingBar(int stars, double percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.star, color: Colors.deepPurple, size: 16),
          const SizedBox(width: 4),
          smallText(
            text: '$stars.0',
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          smallerText(
            text: '${percentage.toStringAsFixed(0)}%',
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // User avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade300,
                ),
                child: review.user.profileImage.isNotEmpty
                    ? ClipOval(
                        child: Image.network(
                          review.user.profileImage,
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildDefaultAvatar(review.user.fullName),
                        ),
                      )
                    : _buildDefaultAvatar(review.user.fullName),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    normalText(
                        text: review.user.fullName.isNotEmpty
                            ? review.user.fullName
                            : 'Anonymous User',
                        fontWeight: FontWeight.bold),
                    smallText(
                      text:
                          'Booking on ${review.createdAt.day} ${_getMonthName(review.createdAt.month)}',
                    ),
                  ],
                ),
              ),

              // Rating
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.deepPurple, size: 16),
                  const SizedBox(width: 4),
                  smallText(
                    text: review.rating.toString(),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          smallText(
              text: review.comment.isNotEmpty
                  ? review.comment
                  : 'No comment provided',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              color: Colors.grey),
        ],
      ),
    );
  }

  // Build default avatar with user's initials
  Widget _buildDefaultAvatar(String fullName) {
    String initials = '';
    if (fullName.isNotEmpty) {
      List<String> names = fullName.split(' ');
      initials = names.length >= 2
          ? '${names[0][0]}${names[1][0]}'.toUpperCase()
          : names[0][0].toUpperCase();
    } else {
      initials = 'U';
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue.shade100,
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade700,
          ),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}

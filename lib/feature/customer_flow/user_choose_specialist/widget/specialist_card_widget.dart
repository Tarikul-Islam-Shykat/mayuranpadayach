// widgets/specialist_card_widget.dart
import 'package:flutter/material.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/feature/user/user_choose_specialist/model/specialist_model.dart';
import 'dart:async';

class SpecialistCardWidget extends StatefulWidget {
  final SpecialistModel specialist;

  const SpecialistCardWidget({
    Key? key,
    required this.specialist,
  }) : super(key: key);

  @override
  State<SpecialistCardWidget> createState() => _SpecialistCardWidgetState();
}

class _SpecialistCardWidgetState extends State<SpecialistCardWidget> {
  late PageController _pageController;
  late Timer _timer;
  int _currentReviewIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Auto-slide reviews every 3 seconds
    if (widget.specialist.reviews.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        if (mounted) {
          _currentReviewIndex =
              (_currentReviewIndex + 1) % widget.specialist.reviews.length;
          _pageController.animateToPage(
            _currentReviewIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Profile Images Row
            _buildProfileImagesRow(),
            const SizedBox(height: 16),

            // Specialist Info
            _buildSpecialistInfo(),
            const SizedBox(height: 12),

            // Rating and Review Slider
            _buildReviewSlider(),
            const SizedBox(height: 16),

            // Stats Row
            _buildStatsRow(),
            const SizedBox(height: 20),

            // Add Specialist Button
            _buildAddButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImagesRow() {
    return Row(
      children: [
        // First profile (reduced opacity)
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.grey[300],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                ImagePath.splashLogo,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.person, color: Colors.grey),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),

        // Second profile (reduced opacity)
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.grey[300],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                ImagePath.splashLogo,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.person, color: Colors.grey),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),

        // Main profile with heart icon
        Stack(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey[300],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  ImagePath.splashLogo,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.person, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: -2,
              right: -2,
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Color(0xFF8B5CF6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSpecialistInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "sdfasf",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "sdfasf",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "sdfasf",
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF8B5CF6),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewSlider() {
    if (widget.specialist.reviews.isEmpty) {
      return _buildRatingOnly();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Rating stars
        Row(
          children: [
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < widget.specialist.rating.floor()
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.amber,
                  size: 16,
                );
              }),
            ),
            const SizedBox(width: 8),
            Text(
              widget.specialist.rating.toString(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Auto-sliding reviews
        SizedBox(
          height: 80,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentReviewIndex = index;
              });
            },
            itemCount: widget.specialist.reviews.length,
            itemBuilder: (context, index) {
              final review = widget.specialist.reviews[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: AssetImage(review.reviewerImage),
                        onBackgroundImageError: (error, stackTrace) {},
                        child: review.reviewerImage.isEmpty
                            ? const Icon(Icons.person, size: 12)
                            : null,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        review.reviewerName,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8B5CF6),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: List.generate(5, (starIndex) {
                          return Icon(
                            starIndex < review.rating.floor()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 12,
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: Text(
                      review.review,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                        height: 1.3,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        // Dots indicator
        if (widget.specialist.reviews.length > 1)
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                widget.specialist.reviews.length,
                (index) => Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentReviewIndex == index
                        ? const Color(0xFF8B5CF6)
                        : Colors.grey[300],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildRatingOnly() {
    return Row(
      children: [
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < widget.specialist.rating.floor()
                  ? Icons.star
                  : Icons.star_border,
              color: Colors.amber,
              size: 16,
            );
          }),
        ),
        const SizedBox(width: 8),
        Text(
          widget.specialist.rating.toString(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatItem('', 'Perfect Haircuts'),
        _buildStatItem('', 'Customer Rate'),
        _buildStatItem('+', 'Years Experience'),
      ],
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAddButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // Handle add specialist
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8B5CF6),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Add Specialist',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

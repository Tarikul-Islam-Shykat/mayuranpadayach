// lib/data/dummy_data.dart

import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/feature/customer_flow/serivce_details/model/studio_model.dart';


class DummyData {
  static List<StudioModel> getStudioList() {
    return [
      StudioModel(
        id: "1",
        name: "Zero Hair Studio",
        category: "Hair Salon",
        latitude: 40.7831,
        longitude: -73.9712,
        totalReviews: 120,
        rating: 4.9,
        discountPercentage: 20,
        basicInfo: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.",
        portfolioImages: [
          ImagePath.splashLogo,
          ImagePath.splashLogo,
          ImagePath.splashLogo,
          ImagePath.splashLogo,
          ImagePath.splashLogo,
          ImagePath.splashLogo,
        ],
        specialists: [
          Specialist(
            id: "s1",
            name: "John Smith",
            category: "Senior Hair Stylist",
            imagePath: ImagePath.splashLogo,
            rating: 4.8,
          ),
          Specialist(
            id: "s2",
            name: "Maria Garcia",
            category: "Hair Colorist",
            imagePath: ImagePath.splashLogo,
            rating: 4.9,
          ),
          Specialist(
            id: "s3",
            name: "David Johnson",
            category: "Barber Specialist",
            imagePath: ImagePath.splashLogo,
            rating: 4.7,
          ),
          Specialist(
            id: "s4",
            name: "Sarah Wilson",
            category: "Hair Treatment Expert",
            imagePath: ImagePath.splashLogo,
            rating: 4.8,
          ),
        ],
        contactInfo: ContactInfo(
          phone: "+1 (555) 123-4567",
          email: "info@zerohairstudio.com",
          address: "115 Manhattan, New York",
          website: "www.zerohairstudio.com",
        ),
        reviewSummary: ReviewSummary(
          totalReviews: 120,
          fiveStars: 90,
          fourStars: 18,
          threeStars: 0,
          twoStars: 9,
          oneStar: 3,
        ),
        writtenReviews: [
          WrittenReview(
            id: "r1",
            comment: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.",
            rating: 5.0,
            userName: "Dianne Russell",
            reviewTime: DateTime(2024, 3, 26),
            userAvatar: ImagePath.splashLogo,
          ),
          WrittenReview(
            id: "r2",
            comment: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.",
            rating: 4.0,
            userName: "Annette Black",
            reviewTime: DateTime(2024, 3, 26),
            userAvatar: ImagePath.splashLogo,
          ),
          WrittenReview(
            id: "r3",
            comment: "Great service and professional staff. Highly recommend this place for anyone looking for quality hair styling.",
            rating: 5.0,
            userName: "Robert Fox",
            reviewTime: DateTime(2024, 3, 25),
            userAvatar: ImagePath.splashLogo,
          ),
          WrittenReview(
            id: "r4",
            comment: "Amazing experience! The staff was very friendly and the results exceeded my expectations.",
            rating: 4.5,
            userName: "Jenny Wilson",
            reviewTime: DateTime(2024, 3, 24),
            userAvatar: ImagePath.splashLogo,
          ),
        ],
        subServices: [
          SubService(
            id: "ss1",
            serviceImage: ImagePath.splashLogo,
            name: "Regular Haircut & Beard",
            amount: 30.0,
            durationHours: 1,
          ),
          SubService(
            id: "ss2",
            serviceImage: ImagePath.splashLogo,
            name: "VIP Haircut & Beard",
            amount: 50.0,
            durationHours: 1,
          ),
          SubService(
            id: "ss3",
            serviceImage: ImagePath.splashLogo,
            name: "Regular Haircut",
            amount: 20.0,
            durationHours: 1,
          ),
          SubService(
            id: "ss4",
            serviceImage: ImagePath.splashLogo,
            name: "Hair Styling & Treatment",
            amount: 45.0,
            durationHours: 2,
          ),
        ],
      ),
      // Add more studios here if needed
      StudioModel(
        id: "2",
        name: "AZ Electrician",
        category: "Electrician",
        latitude: 40.7589,
        longitude: -73.9851,
        totalReviews: 85,
        rating: 4.7,
        discountPercentage: 15,
        basicInfo: "Professional electrical services for residential and commercial properties. Licensed and insured electricians with over 10 years of experience.",
        portfolioImages: [
          ImagePath.splashLogo,
          ImagePath.splashLogo,
          ImagePath.splashLogo,
        ],
        specialists: [
          Specialist(
            id: "s5",
            name: "Alex Zhang",
            category: "Master Electrician",
            imagePath: ImagePath.splashLogo,
            rating: 4.8,
          ),
          Specialist(
            id: "s6",
            name: "Mike Rodriguez",
            category: "Commercial Electrician",
            imagePath: ImagePath.splashLogo,
            rating: 4.6,
          ),
        ],
        contactInfo: ContactInfo(
          phone: "+1 (555) 987-6543",
          email: "contact@azelectrician.com",
          address: "123 Electric Ave, New York",
          website: "www.azelectrician.com",
        ),
        reviewSummary: ReviewSummary(
          totalReviews: 85,
          fiveStars: 60,
          fourStars: 15,
          threeStars: 5,
          twoStars: 3,
          oneStar: 2,
        ),
        writtenReviews: [
          WrittenReview(
            id: "r5",
            comment: "Excellent electrical work! Professional and reliable service. Fixed my electrical issues quickly.",
            rating: 5.0,
            userName: "Tom Anderson",
            reviewTime: DateTime(2024, 3, 20),
            userAvatar: ImagePath.splashLogo,
          ),
        ],
        subServices: [
          SubService(
            id: "ss5",
            serviceImage: ImagePath.splashLogo,
            name: "Electrical Inspection",
            amount: 75.0,
            durationHours: 2,
          ),
          SubService(
            id: "ss6",
            serviceImage: ImagePath.splashLogo,
            name: "Wiring Installation",
            amount: 120.0,
            durationHours: 4,
          ),
        ],
      ),
    ];
  }
}
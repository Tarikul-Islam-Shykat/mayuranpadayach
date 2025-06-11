// controllers/specialist_controller.dart
import 'package:get/get.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:prettyrini/core/const/image_path.dart';


import '../model/specialist_model.dart';


class SpecialistController extends GetxController {
  final CardSwiperController cardController = CardSwiperController();
  
  final RxList<SpecialistModel> specialists = <SpecialistModel>[].obs;
  final RxInt currentIndex = 0.obs;
  final RxString currentSpecialistName = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadSpecialists();
  }
  
  void loadSpecialists() {
    specialists.value = [
      SpecialistModel(
        id: '1',
        name: 'Arlene McCoy',
        specialistType: 'Hair Specialist',
        rating: 4.8,
        perfectHaircuts: 250,
        customerRate: 98.0,
        yearsExperience: 4,
        profileImage: ImagePath.profile,
        bookingDate: 'Today 2:30 PM',
        portfolioImages: [
          ImagePath.portfolio,
          ImagePath.football,
          ImagePath.player,
          ImagePath.goalkipper,
          ImagePath.gellary,
          ImagePath.alert,
        ],
        reviews: [
          ReviewModel(
            id: '1',
            reviewerName: 'Savannah Nguyen',
            review: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            rating: 4.9,
            reviewerImage: ImagePath.profile,
            reviewDate: DateTime.now(),
          ),
          ReviewModel(
            id: '1b',
            reviewerName: 'Brooklyn Simmons',
            review: 'Amazing haircut! Professional service and great attention to detail. Highly recommended for anyone looking for quality.',
            rating: 4.8,
            reviewerImage: ImagePath.profile,
            reviewDate: DateTime.now(),
          ),
          ReviewModel(
            id: '1c',
            reviewerName: 'Jenny Wilson',
            review: 'Best barber in town! Always delivers exactly what I want. Very skilled and friendly.',
            rating: 5.0,
            reviewerImage: ImagePath.profile,
            reviewDate: DateTime.now(),
          ),
        ],
      ),
      SpecialistModel(
        id: '2',
        name: 'Jerome Bell',
        specialistType: 'Beard Specialist',
        rating: 4.7,
        perfectHaircuts: 180,
        customerRate: 96.0,
        yearsExperience: 3,
        profileImage: ImagePath.profile,
        bookingDate: 'Tomorrow 10:00 AM',
        portfolioImages: [
          ImagePath.football,
          ImagePath.player,
          ImagePath.portfolio,
          ImagePath.alert,
          ImagePath.gellary,
          ImagePath.goalkipper,
        ],
        reviews: [
          ReviewModel(
            id: '2',
            reviewerName: 'Brooklyn Simmons',
            review: 'Exceptional service and attention to detail. Highly recommended!',
            rating: 4.8,
            reviewerImage: ImagePath.profile,
            reviewDate: DateTime.now(),
          ),
          ReviewModel(
            id: '2b',
            reviewerName: 'Ralph Edwards',
            review: 'Great experience! Professional and skilled. Will definitely come back.',
            rating: 4.7,
            reviewerImage: ImagePath.profile,
            reviewDate: DateTime.now(),
          ),
        ],
      ),
      SpecialistModel(
        id: '3',
        name: 'Robert Fox',
        specialistType: 'Style Expert',
        rating: 4.9,
        perfectHaircuts: 320,
        customerRate: 99.0,
        yearsExperience: 6,
        profileImage: ImagePath.profile,
        bookingDate: 'Today 4:00 PM',
        portfolioImages: [
          ImagePath.player,
          ImagePath.goalkipper,
          ImagePath.football,
          ImagePath.portfolio,
          ImagePath.alert,
          ImagePath.gellary,
        ],
        reviews: [
          ReviewModel(
            id: '3',
            reviewerName: 'Annette Black',
            review: 'Amazing experience! Professional and skilled barber.',
            rating: 5.0,
            reviewerImage: ImagePath.profile,
            reviewDate: DateTime.now(),
          ),
          ReviewModel(
            id: '3b',
            reviewerName: 'Jacob Jones',
            review: 'Outstanding work! Very happy with my haircut. Excellent service.',
            rating: 4.9,
            reviewerImage: ImagePath.profile,
            reviewDate: DateTime.now(),
          ),
          ReviewModel(
            id: '3c',
            reviewerName: 'Albert Flores',
            review: 'Top quality service. Great attention to detail and very professional.',
            rating: 4.8,
            reviewerImage: ImagePath.profile,
            reviewDate: DateTime.now(),
          ),
        ],
      ),
    ];
    
    if (specialists.isNotEmpty) {
      currentSpecialistName.value = specialists[0].name;
    }
  }
  
  bool onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    if (currentIndex != null && currentIndex < specialists.length) {
      this.currentIndex.value = currentIndex;
      currentSpecialistName.value = specialists[currentIndex].name;
    }
    
    switch (direction) {
      case CardSwiperDirection.left:
        print('Passed on ${specialists[previousIndex].name}');
        break;
      case CardSwiperDirection.right:
        print('Liked ${specialists[previousIndex].name}');
        break;
      case CardSwiperDirection.top:
        print('Super liked ${specialists[previousIndex].name}');
        break;
      case CardSwiperDirection.bottom:
        print('Bottom swipe on ${specialists[previousIndex].name}');
        break;
      case CardSwiperDirection.none:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
    
    return true; // Allow the swipe
  }
  
  void dislikeCurrentCard() {
    cardController.swipe(CardSwiperDirection.left);
  }
  
  void likeCurrentCard() {
    cardController.swipe(CardSwiperDirection.right);
  }
  
  void superLikeCurrentCard() {
    cardController.swipe(CardSwiperDirection.top);
  }
  
  void addSpecialist() {
    if (currentIndex.value < specialists.length) {
      final specialist = specialists[currentIndex.value];
      print('Adding specialist: ${specialist.name}');
      // Implement add specialist logic here
    }
  }
  
  @override
  void onClose() {
    cardController.dispose();
    super.onClose();
  }
}
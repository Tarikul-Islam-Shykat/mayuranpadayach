class Urls {
  static const String baseUrl = 'https://mayuranpadayach.vercel.app/api/v1';
  static const String signUp = '$baseUrl/users/register';
  static const String verifyOTP = '$baseUrl/auth/verify-otp';
  static const String changePassword = '$baseUrl/auth/change-password';
  static const String getUserProfile = '$baseUrl/auth/profile';

  // --------------------------------------
  static const String login = '$baseUrl/auth/login';

  static const String setupProfile = '$baseUrl/users/update-profile';
  static const String authentication = '$baseUrl/auth/verify-auth';
  static const String resetPassword = '$baseUrl/auth/reset-password';
  static const String logout = '$baseUrl/auth/logout';
  static const String forgotPass = '$baseUrl/auth/forgot-password';
  static const String pickUpLocation = '$baseUrl/user/pickup-locations';
  static String getCalendar(String date, String locationUuid) =>
      '$baseUrl/calendar?date=$date&pickup_location_uuid=$locationUuid';

  //---------------------------User---------------------------------------
  static const String getFavBuisness = "$baseUrl/favBusiness"; //id PUT
  static const String getBuiessnessDetailsById = "$baseUrl/businesses"; //id PUT
  static const String getServiceByBuisnesID = "$baseUrl/services/all";
  static const String getReviewsByID = "$baseUrl/reviews/business/";
  static const String getBuisnessView = "$baseUrl/portfolios/all?businessId";

  //---------------------------Admin---------------------------------------
  static const String addBusiness = "$baseUrl/businesses/create";
  static const String editBusiness = "$baseUrl/businesses"; //id PUT
  static const String addBusinessCategory = "$baseUrl/categories";
  static const String userBusiness = "$baseUrl/businesses?limit=10";
  static const String adminBusinessDetails = "$baseUrl/businesses"; //id
  static const String adminBusinessDelete = "$baseUrl/businesses"; //DELETE id

  static const String allServiceGet = "$baseUrl/services/all"; //id
  static const String serviceCreate = "$baseUrl/services"; //id
  static const String serviceEdit = "$baseUrl/services"; //id PUT
  static const String serviceDelete = "$baseUrl/services"; //id DELETE

  static const String getAdminSpecialist =
      "$baseUrl/specialists/all?limit=10"; //page GET ID

  static const String getAdminSpecialist = "$baseUrl/specialists/all?limit=10"; //page GET page
  static const String createAdminSpecialist = "$baseUrl/specialists"; //POST
  static const String editAdminSpecialist = "$baseUrl/specialists"; //PUT
  static const String deleteAdminSpecialist = "$baseUrl/specialists"; //DELETE

  static const String getPortfolio = "$baseUrl/portfolios/all"; //GET
  static const String createPortfolio = "$baseUrl/portfolios"; //POST
  static const String editPortfolio = "$baseUrl/portfolios"; //PUT id
  static const String deletePortfolio = "$baseUrl/portfolios"; //DELETE id

  static const String getReviewAdmin = "$baseUrl/reviews/business"; //GET id

  static const String getAdminSubscription =
      "$baseUrl/subscriptionOffers"; //GET id
  static const String adminBookingStatus =
      "$baseUrl/bookings?limit=10"; //GET Page
}

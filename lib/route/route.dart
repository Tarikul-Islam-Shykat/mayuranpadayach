import 'package:get/get.dart';
import 'package:prettyrini/feature/admin/admin_booking/view/booking_screen.dart';
import 'package:prettyrini/feature/admin/admin_business/view/business_screen.dart';
import 'package:prettyrini/feature/admin/admin_home/view/admin_home_screen.dart';
import 'package:prettyrini/feature/admin/admin_service/view/about_screen.dart';
import 'package:prettyrini/feature/admin/admin_service/view/portfolio_screen.dart';
import 'package:prettyrini/feature/admin/admin_business/view/business_details_screen.dart';
import 'package:prettyrini/feature/admin/admin_service/view/service_screen.dart';
import 'package:prettyrini/feature/auth/screen/otp_very_screen.dart';
import 'package:prettyrini/feature/auth/screen/sign_up_screen.dart';
import 'package:prettyrini/feature/profile_screen/view/change_pasword.dart';
import 'package:prettyrini/feature/profile_screen/view/edit_profile.dart';
import 'package:prettyrini/feature/profile_screen/view/profile_screen.dart';
import '../feature/admin/admin_booking/view/booking_details_screen.dart';
import '../feature/admin/admin_service/view/about_details_screen.dart';
import '../feature/admin/admin_specialist/view/specialist_screen.dart';
import '../feature/auth/screen/forget_pasword_screen.dart';
import '../feature/auth/screen/login_screen.dart';
import '../feature/auth/screen/reset_password.dart';
import '../feature/splash_screen/screen/splash_screen.dart';

class AppRoute {
  //common route name
  static String splashScreen = '/splashScreen';
  static String loginScreen = "/loginScreen";
  static String signUpScreen = "/signupScreen";
  static String forgetScreen = "/forgetScreen";
  static String otpVerificationScreen = "/otpVerificationScreen";
  static String resetPassScreen = "/resetPassScreen";
  static String profileScreen = "/profileScreen";
  static String editProfileScreen = "/editProfileScreen";
  static String changePasswordScreen = "/changePasswordScreen";

  //user route name

  //admin route name
  static const String adminHomeScreen = "/admin_home_screen";
  static const String adminBusinessScreen = "/admin_business_screen";
  static const String adminServiceScreen = "/admin_service_screen";
  static const String adminBusinessDetailsScreen =
      "/admin_service_Details_screen";
  static const String servicePortfolioScreen = "/service_portfolio_screen";
  static const String serviceSpecialistScreen = "/service_specialist_screen";
  static const String serviceAboutScreen = "/service_about_screen";
  static const String serviceAboutDetailsScreen =
      "/service_about_details_screen";
  static const String bookingScreen = "/booking_screen";
  static const String bookingDetailsScreen = "/booking_details_screen";

  //common getter
  static String getSplashScreen() => splashScreen;
  static String getLoginScreen() => loginScreen;
  static String getSignUpScreen() => signUpScreen;
  static String getForgetScreen() => forgetScreen;
  static String getOtpVerificationScreen() => otpVerificationScreen;
  static String getResetPassScreen() => resetPassScreen;
  static String getProfileScreen() => profileScreen;
  static String getEditProfileScreen() => editProfileScreen;
  static String getChangeScreen() => changePasswordScreen;
  //user getter

  //admin getter
  static String getAdminHomeScreen() => adminHomeScreen;
  static String getAdminBusinessScreen() => adminBusinessScreen;
  static String getAdminServiceScreen() => adminServiceScreen;
  static String getAdminServiceDetailsScreen() => adminBusinessDetailsScreen;
  static String getServicePortfolioScreen() => servicePortfolioScreen;
  static String getServiceSpecialistScreen() => serviceSpecialistScreen;
  static String getServiceAboutScreen() => serviceAboutScreen;
  static String getServiceAboutDetailsScreen() => serviceAboutDetailsScreen;
  static String getBookingScreen() => bookingScreen;
  static String getBookingDetailsScreen() => bookingDetailsScreen;

  static List<GetPage> routes = [
    //common route page
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signUpScreen, page: () => SignUpScreen()),
    GetPage(name: forgetScreen, page: () => ForgetPasswordScreen()),
    GetPage(
        name: otpVerificationScreen,
        page: () {
          final String email = Get.arguments?['email'] ?? '';
          return OtpVeryScreen(email: email);
        }),
    // GetPage(
    //     name: otpVerificationScreen,
    //     page: () => OtpVeryScreen(
    //           email: "",
    //         )),
    GetPage(name: resetPassScreen, page: () => ResetPasswordScreen()),
    GetPage(name: profileScreen, page: () => ProfileScreen()),
    GetPage(name: editProfileScreen, page: () => EditProfile()),
    GetPage(name: changePasswordScreen, page: () => ChangePasword()),

    //user route page

    //admin route page
    GetPage(name: adminHomeScreen, page: () => AdminHomeScreen()),
    GetPage(name: adminBusinessScreen, page: () => BusinessScreen()),
    GetPage(name: adminServiceScreen, page: () => ServiceScreen()),
    GetPage(
        name: adminBusinessDetailsScreen, page: () => BusinessDetailsScreen()),
    GetPage(name: servicePortfolioScreen, page: () => PortfolioScreen()),
    GetPage(name: serviceSpecialistScreen, page: () => SpecialistScreen()),
    GetPage(name: serviceAboutScreen, page: () => AboutScreen()),
    GetPage(name: serviceAboutDetailsScreen, page: () => AboutDetailsScreen()),
    GetPage(name: bookingScreen, page: () => BookingScreen()),
    GetPage(name: bookingDetailsScreen, page: () => BookingDetailsScreen()),
  ];
}

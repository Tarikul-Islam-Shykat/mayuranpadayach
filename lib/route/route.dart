import 'package:get/get.dart';
import 'package:prettyrini/feature/auth/screen/otp_very_screen.dart';
import 'package:prettyrini/feature/auth/screen/sign_up_screen.dart';
import 'package:prettyrini/feature/profile_screen/view/change_pasword.dart';
import 'package:prettyrini/feature/profile_screen/view/edit_profile.dart';
import 'package:prettyrini/feature/profile_screen/view/profile_screen.dart';
import '../feature/auth/screen/forget_pasword_screen.dart';
import '../feature/auth/screen/login_screen.dart';
import '../feature/auth/screen/reset_password.dart';
import '../feature/splash_screen/screen/splash_screen.dart';

class AppRoute {
  static String splashScreen = '/splashScreen';
  static String loginScreen = "/loginScreen";
  static String signUpScreen = "/signupScreen";
  static String forgetScreen = "/forgetScreen";
  static String otpVerificationScreen = "/otpVerificationScreen";
  static String resetPassScreen = "/resetPassScreen";
  static String profileScreen = "/profileScreen";
  static String editProfileScreen = "/editProfileScreen";
  static String changePasswordScreen = "/changePasswordScreen";

  static String getSplashScreen() => splashScreen;
  static String getLoginScreen() => loginScreen;
  static String getSignUpScreen() => signUpScreen;
  static String getForgetScreen() => forgetScreen;
  static String getOtpVerificationScreen() => otpVerificationScreen;
  static String getResetPassScreen() => resetPassScreen;
  static String getProfileScreen() => profileScreen;
  static String getEditProfileScreen() => editProfileScreen;
  static String getChangeScreen() =>changePasswordScreen ;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () =>  SplashScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signUpScreen, page: () => SignUpScreen()),
    GetPage(name: forgetScreen, page: () =>  ForgetPasswordScreen()),
    GetPage(name: otpVerificationScreen, page: () =>  OtpVeryScreen()),
    GetPage(name: resetPassScreen, page: () => ResetPasswordScreen()),
    GetPage(name: profileScreen, page: () => ProfileScreen()),
    GetPage(name: editProfileScreen, page: () => EditProfile()),
    GetPage(name: changePasswordScreen, page: () => ChangePasword()),
  ];
}

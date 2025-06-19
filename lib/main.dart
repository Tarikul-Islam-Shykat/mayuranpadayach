import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/controller/theme_controller.dart';
import 'package:prettyrini/feature/customer_flow/serivce_details/model/dummy_data.dart';
import 'package:prettyrini/feature/customer_flow/serivce_details/ui/service_details_page.dart';
import 'package:prettyrini/feature/customer_flow/user_booking_page/ui/user_booking_details.dart';
import 'package:prettyrini/feature/customer_flow/user_booking_page/ui/user_booking_page.dart';
import 'package:prettyrini/feature/customer_flow/user_dashboard/ui/user_dashboard.dart';
import 'package:prettyrini/feature/customer_flow/user_dashboard/widget/card_swiper_.dart';
import 'package:prettyrini/feature/customer_flow/user_fav/ui/user_fav_ui.dart';
import 'package:prettyrini/feature/customer_flow/user_home_page/ui/user_home_page.dart';
import 'package:prettyrini/feature/customer_flow/user_search/ui/user_search_page.dart';
import 'package:prettyrini/route/route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/const/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configEasyLoading();
  await SharedPreferences.getInstance();
  Get.put(ThemeController());
  runApp(
    MyApp(),
  );
}

void configEasyLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = AppColors.grayColor
    ..textColor = Colors.white
    ..indicatorColor = Colors.white
    ..maskColor = Colors.green
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  @override
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        title: 'Foot Fitness',
        getPages: AppRoute.routes,
        initialRoute: AppRoute.splashScreen,
        builder: EasyLoading.init(),
        //home: UserDashboard(),
        //  home: UserHomePage(),
      ),
    );
  }
}

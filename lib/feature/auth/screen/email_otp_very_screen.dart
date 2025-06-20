import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/feature/auth/widget/custom_booton_widget.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/const/image_path.dart';
import '../../../route/route.dart';
import '../widget/app_button.dart';

class EmailOtpVeryScreen extends StatefulWidget {
  const EmailOtpVeryScreen({super.key});

  @override
  State<EmailOtpVeryScreen> createState() => _EmailOtpVeryScreenState();
}

class _EmailOtpVeryScreenState extends State<EmailOtpVeryScreen> {
  final List<TextEditingController> _controllers = List.generate(
    5,
        (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());
  String get _otp => _controllers.map((controller) => controller.text).join();
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    for (var i = 0; i < 5; i++) {
      _controllers[i].dispose();
      _focusNodes[i].dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _canResend = false;
  }




  TextEditingController emailOtpController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50.h),

            Center(child: Image.asset(ImagePath.loginLogo,width: 71.w,height: 48.h,fit: BoxFit.fill,)),
            SizedBox(height: 10,),
            Center(child: headingText(text:  "Apply Code Here",)),
            SizedBox(height: 4,),
            Center(child: smallText(text: "Please check your email. Give correct authentication code here.",maxLines: 2,color: AppColors.grayColor,textAlign: TextAlign.center)),
            SizedBox(height: 20.h,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                5,
                    (index) => _buildOtpTextField(index),
              ),
            ),
            Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomButton(
                  onTap: ()=>Get.toNamed(AppRoute.resetPassScreen),
                  title: Text("Apply Code",
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 15.h,),
                AppButton(
                  onTap: () { },
                  bgColor: Color(0xFF1E1E240A),
                  textColor: AppColors.blackColor,
                  name: 'Send Email Again',),
                SizedBox(height: 15.h,)

              ],
            ),

          ],
        ),
      ),

    );
  }

  Widget _buildOtpTextField(int index) {
    return Container(
      width: 40.h,
      height: 40.h,
      decoration: BoxDecoration(
        color: Color(0xFF1E1E240A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 24),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          // Auto focus to next field when this field is filled
          if (value.isNotEmpty && index < 4) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          }
          setState(() {});
        },
      ),
    );
  }
}

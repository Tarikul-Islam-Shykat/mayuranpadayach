import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/const/app_colors.dart';

// class ServiceTile extends StatelessWidget {
//   const ServiceTile({
//     super.key, required this.onTap, required this.name, required this.image,
//   });
//   final VoidCallback onTap;
//   final String name;
//   final String image;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5.0),
//       child: ListTile(
//         onTap: onTap,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         tileColor: AppColors.whiteColor,
//         contentPadding: EdgeInsets.symmetric(horizontal: 10),
//         leading:Container(
//           height: 42,
//           width: 40,
//           padding: EdgeInsets.all(2),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.grey.shade200
//           ),
//           child: ClipRRect(
//               borderRadius: BorderRadius.circular(100),
//               child: Image.asset(image)),
//         ),
//         title: Text(name,style: GoogleFonts.poppins(
//           fontWeight: FontWeight.w500,
//           fontSize: 16.sp,
//           color: AppColors.textBlackColor,
//         ),),
//         trailing: Icon(Icons.arrow_forward_ios,size:20.sp,color:Colors.purple,),
//       ),
//     );
//   }
// }


serviceTile(
    final VoidCallback onTap,
    final String name,
    final String image,
    ){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      tileColor: AppColors.whiteColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      leading:Container(
        height: 34.h,
        width: 40.w,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.grey.shade200
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: Image.asset(image)),
      ),
      title: Text(name,style: GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        color: AppColors.textBlackColor,
      ),),
      trailing: Icon(Icons.arrow_forward_ios,size:20.sp,color:Colors.purple,),
    ),
  );
}

Widget fieldText({
  required String name,
}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
       name,
        style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlackColor),
      ),
      SizedBox(height: 5,),
    ],
  );
}
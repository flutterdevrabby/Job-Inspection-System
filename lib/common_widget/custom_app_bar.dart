// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../constants/text_font_style.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String titleText;
//   final String subTitleText;
//   final bool automaticallyImplyLeading;

//   const CustomAppBar({
//     super.key,
//     required this.titleText,
//     required this.subTitleText,
//     this.automaticallyImplyLeading = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Column(
//         spacing: 30.h,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             titleText,
//             style: TextFontStyle.headLine28c3D3D3DInterW700.copyWith(
//               fontSize: 18.sp,
//               color: Colors.white,
//             ),
//           ),

//           Text(
//             subTitleText,
//             style: TextFontStyle.headLine28c3D3D3DInterW700.copyWith(
//               fontSize: 18.sp,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),

//       // elevation: 0,
//       // leading: (automaticallyImplyLeading
//       //     ? BackButton(
//       //         color: AppColors.c051F42,
//       //         onPressed: () {
//       //           NavigationService.goBack;
//       //         },
//       //       )
//       //     : null),
//       // title: Text(titleText, style: TextFontStyle.headLine28c3D3D3DInterW700),
//       // centerTitle: false,
//       // automaticallyImplyLeading: automaticallyImplyLeading,
//       backgroundColor: Color(0xFF2D8D7C),
//       elevation: 0,
//     );
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(120.h);
// }

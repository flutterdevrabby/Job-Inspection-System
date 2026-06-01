// import 'package:artneidich_app/common_widget/header_widget.dart';
// import 'package:artneidich_app/gen/assets.gen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';

// import '../../../../constants/text_font_style.dart';
// import '../../../../helpers/ui_helpers.dart';
// import '../../../provider/inspector_progress_provider.dart';

// class CameraSettingScreen extends StatefulWidget {
//   const CameraSettingScreen({super.key});

//   @override
//   State<CameraSettingScreen> createState() => _CameraSettingScreenState();
// }

// class _CameraSettingScreenState extends State<CameraSettingScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<InspectorProgressProvider>(
//       builder: (context, provider, child) {
//         return Scaffold(
//           body: SingleChildScrollView(
//             physics: const ClampingScrollPhysics(),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 HeaderWidget(
//                   title: "Settings",
//                   icon: Assets.icons.camera.path,
//                   subtitle: 'Camera Settings',
//                 ),
//                 UIHelper.verticalSpace(30.h),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.w),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Force Portrait Mode",
//                               style: TextFontStyle.headLine16c141414InterW400
//                                   .copyWith(
//                                     color: const Color(0xFF323539),
//                                     fontSize: 14.sp,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                             ),
//                             SizedBox(height: 4.h),
//                             Text(
//                               provider.isCamera
//                                   ? "Camera will open in Portrait"
//                                   : "Camera will open in Landscape",
//                               style: TextFontStyle.headLine16c141414InterW400
//                                   .copyWith(
//                                     color: Colors.grey,
//                                     fontSize: 12.sp,
//                                   ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(width: 16.w),
//                       // Custom Switch
//                       GestureDetector(
//                         onTap: () {
//                           provider.toggleUpdateCamera(!provider.isCamera);
//                         },
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 200),
//                           width: 50.w,
//                           height: 28.h,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.r),
//                             color: provider.isCamera
//                                 ? const Color(0xFF2D8D7C)
//                                 : Colors.grey,
//                           ),
//                           child: AnimatedAlign(
//                             duration: const Duration(milliseconds: 200),
//                             alignment: provider.isCamera
//                                 ? Alignment.centerRight
//                                 : Alignment.centerLeft,
//                             child: Padding(
//                               padding: EdgeInsets.all(3.w),
//                               child: Container(
//                                 width: 22.w,
//                                 height: 22.h,
//                                 decoration: const BoxDecoration(
//                                   color: Colors.white,
//                                   shape: BoxShape.circle,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 UIHelper.verticalSpaceExtraLarge,
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

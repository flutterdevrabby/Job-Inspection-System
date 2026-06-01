import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/text_font_style.dart';
import '../../../../helpers/ui_helpers.dart';

class InspectionInternalNotesWidget extends StatelessWidget {
  final String noteInspector;
  // final String noteAp;
  // final String formInspector;
  const InspectionInternalNotesWidget({
    super.key,
    required this.noteInspector,
    //    required this.noteAp,
    // required this.formInspector,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Color(0xFFF7F7F5),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        spacing: 8.h,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'Note to Inspector',
                  style: TextFontStyle.headLine16c141414InterW400.copyWith(
                    color: const Color(0xFF848B94),
                    fontSize: 14.sp,

                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              UIHelper.horizontalSpace(20.w),

              Text(
                ": ",
                style: TextFontStyle.headLine16c141414InterW400.copyWith(
                  color: const Color(0xFF848B94),
                  fontSize: 14.sp,

                  fontWeight: FontWeight.w500,
                ),
              ),

              UIHelper.horizontalSpace(20.w),

              // value comes just after colon
              Expanded(
                child: Text(
                  noteInspector,
                  style: TextFontStyle.headLine16c141414InterW400.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),

          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Expanded(
          //       child: Text(
          //         "Notes to AP/AR",
          //         style: TextFontStyle.headLine16c141414InterW400.copyWith(
          //           color: const Color(0xFF848B94),
          //           fontSize: 14.sp,

          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //     ),

          //     UIHelper.horizontalSpace(20.w),

          //     Text(
          //       ": ",
          //       style: TextFontStyle.headLine16c141414InterW400.copyWith(
          //         color: const Color(0xFF848B94),
          //         fontSize: 14.sp,

          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),

          //     UIHelper.horizontalSpace(20.w),

          //     // value comes just after colon
          //     Expanded(
          //       child: Text(
          //         noteAp,
          //         style: TextFontStyle.headLine16c141414InterW400.copyWith(
          //           fontWeight: FontWeight.w400,
          //           color: Colors.black,
          //           fontSize: 14.sp,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),

          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Expanded(
          //       child: Text(
          //         "From Inspector",
          //         style: TextFontStyle.headLine16c141414InterW400.copyWith(
          //           color: const Color(0xFF848B94),
          //           fontSize: 14.sp,

          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //     ),

          //     UIHelper.horizontalSpace(20.w),

          //     Text(
          //       ": ",
          //       style: TextFontStyle.headLine16c141414InterW400.copyWith(
          //         color: const Color(0xFF848B94),
          //         fontSize: 14.sp,

          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),

          //     UIHelper.horizontalSpace(20.w),

          //     // value comes just after colon
          //     Expanded(
          //       child: Text(
          //         formInspector,
          //         style: TextFontStyle.headLine16c141414InterW400.copyWith(
          //           fontWeight: FontWeight.w400,
          //           color: Colors.black,
          //           fontSize: 14.sp,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

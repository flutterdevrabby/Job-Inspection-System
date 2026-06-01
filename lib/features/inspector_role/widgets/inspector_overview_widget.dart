import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/text_font_style.dart';

class InspectorOverviewAppBarWidget extends StatelessWidget {
  final String fName;
  final String name;
  final String email;
  const InspectorOverviewAppBarWidget({
    super.key,
    required this.fName,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16.w,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(12.r),
          ),

          child: Text(
            fName.isNotEmpty ? fName.trim().split(' ').first[0] : "?",
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 6.h,
          children: [
            Text(
              name,
              style: TextFontStyle.headLine16c2D8D7CInterW700.copyWith(
                color: Colors.black,
              ),
            ),
            Text(
              email,
              style: TextFontStyle.headLine16c141414InterW400.copyWith(
                color: Color(0xFF8E8E93),
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

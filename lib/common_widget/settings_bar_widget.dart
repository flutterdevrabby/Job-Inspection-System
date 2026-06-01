import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/text_font_style.dart';
import '../helpers/navigation_service.dart';

class SettingAppBarWidget extends StatelessWidget {
  final String fName;
  final String name;
  final String email;
  const SettingAppBarWidget({
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
        IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          onPressed: () {
            NavigationService.goBack;
          },
          icon: Icon(Icons.arrow_back),
        ),
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

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 6.h,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextFontStyle.headLine16c2D8D7CInterW700.copyWith(
                  color: Colors.black,
                ),
              ),
              Text(
                email,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextFontStyle.headLine16c2D8D7CInterW700.copyWith(
                  color: Color(0xFFB3B3B3),
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

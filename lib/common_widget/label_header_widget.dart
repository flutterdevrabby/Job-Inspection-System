import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/text_font_style.dart';

class LabelHeaderWidget extends StatelessWidget {
  final String title;
  final String icon;
  final String subtitle;
  const LabelHeaderWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 180.h,
      color: Color(0xFF2D8D7C),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            spacing: 40.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextFontStyle.headLine28c3D3D3DInterW700.copyWith(
                  fontSize: 18.sp,
                  color: Colors.white,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 10.w,
                children: [
                  Image.asset(
                    icon,
                    width: 40.w,
                    height: 40.h,
                    fit: BoxFit.cover,
                  ),

                  Text(
                    subtitle,
                    style: TextFontStyle.headLine28c3D3D3DInterW700.copyWith(
                      fontSize: 18.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

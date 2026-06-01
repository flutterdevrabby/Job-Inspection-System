import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivityWidget extends StatelessWidget {
  final String fName;
  final String title;
  final String subtitle;
  final String time;
  const ActivityWidget({
    super.key,
    required this.fName,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade400,
          child: Text(fName.isNotEmpty ? fName.trim().split(' ').first[0] : ""),
        ),

        Expanded(
          child: Column(
            spacing: 4.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextFontStyle.headLine16c141414InterW400.copyWith(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                subtitle,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextFontStyle.headLine16c141414InterW400.copyWith(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),

              Text(
                time,
                style: TextFontStyle.headLine16c141414InterW400.copyWith(
                  color: Colors.grey,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

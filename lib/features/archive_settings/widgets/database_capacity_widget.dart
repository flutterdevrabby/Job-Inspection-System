import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DatabaseCapacityWidget extends StatelessWidget {
  final String title;
  final String capacity;
  const DatabaseCapacityWidget({
    super.key,
    required this.title,
    required this.capacity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 20.w,
      children: [
        // Photo
        Text(
          title,
          style: TextFontStyle.headLine14c323539InterW400.copyWith(
            color: const Color(0xFF848B94),
            fontWeight: FontWeight.w500,
          ),
        ),

        // Capacity
        Expanded(
          child: Text(
            capacity,
            maxLines: 1,
            style: TextFontStyle.headLine14c323539InterW400.copyWith(
              color: const Color(0xFF353333),
              fontSize: 12.sp,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:artneidich_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/text_font_style.dart';

class InspectionDetailsWidget extends StatelessWidget {
  final String title;
  final String value;

  const InspectionDetailsWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextFontStyle.headLine16c141414InterW400.copyWith(
                color: const Color(0xFF848B94),
                fontSize: 14.sp,

                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // colon fixed – no Expanded
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
            flex: 2,
            child: Text(
              value,
              style: TextFontStyle.headLine16c141414InterW400.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common_widget/custom_button.dart';
import '../../../common_widget/custom_text_field.dart';
import '../../../constants/text_font_style.dart';
import '../../../helpers/navigation_service.dart';
import '../../../helpers/ui_helpers.dart';

class UpdateLabel extends StatelessWidget {
  final TextEditingController labelnameController;

  final VoidCallback onTap;
  const UpdateLabel({
    super.key,
    required this.labelnameController,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Edit Label Name",
          style: TextFontStyle.headLine14c323539InterW400.copyWith(
            color: const Color(0xFF09090B),
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),

        UIHelper.verticalSpace(8.h),

        Text(
          "Label Name",
          style: TextFontStyle.headLine14c323539InterW400.copyWith(
            color: const Color(0xFF323539),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),

        UIHelper.verticalSpace(8.h),

        CustomTextField(
          maxLines: 5,
          controller: labelnameController,
          style: TextFontStyle.headLine14c323539InterW400.copyWith(
            color: Color(0xFF71717A),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Label is required";
            }
            return null;
          },
        ),
        UIHelper.verticalSpace(8.h),

        Row(
          spacing: 20.w,
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Expanded(
              child: CustomButton(
                style: TextFontStyle.headLine16c2D8D7CInterW700.copyWith(
                  color: Color(0xFF000000),
                ),
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
                color: Color(0xFFF4F4F5),
                onPressed: () {
                  NavigationService.goBack;
                },
                text: "Cancel",
              ),
            ),

            Expanded(
              child: CustomButton(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
                onPressed: onTap,
                text: "Update label",
              ),
            ),
          ],
        ),
      ],
    );
  }
}

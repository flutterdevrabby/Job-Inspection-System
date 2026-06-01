import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common_widget/custom_text_field.dart';
import '../../../constants/text_font_style.dart';
import '../../../constants/validation.dart';
import '../../../helpers/ui_helpers.dart';

class ProfileWidget extends StatelessWidget {
  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController email;
  final GlobalKey<FormState> formkey;
  const ProfileWidget({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.formkey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Form(
        key: formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("First Name", style: TextFontStyle.headLine14c323539InterW400),
            UIHelper.verticalSpace(10.h),
            CustomTextField(
              controller: firstName,
              style: TextFontStyle.headLine14c323539InterW400.copyWith(
                color: Color(0xFF71717A),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "First Name is required";
                }
                return null;
              },
            ),

            UIHelper.verticalSpace(12.h),

            Text("Last Name", style: TextFontStyle.headLine14c323539InterW400),
            UIHelper.verticalSpace(10.h),
            CustomTextField(
              controller: lastName,
              style: TextFontStyle.headLine14c323539InterW400.copyWith(
                color: Color(0xFF71717A),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Last Name is required";
                }
                return null;
              },
            ),

            UIHelper.verticalSpace(12.h),

            Text("Email", style: TextFontStyle.headLine14c323539InterW400),
            UIHelper.verticalSpace(10.h),
            CustomTextField(
              controller: email,
              readOnly: true,
              style: TextFontStyle.headLine14c323539InterW400.copyWith(
                color: Color(0xFF71717A),
              ),
              validator: emailValidation,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:artneidich_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpSettingsTitleWidget extends StatelessWidget {
  final String title;
  final String icon;
  final String icon2;
  final VoidCallback onPressed;
  const HelpSettingsTitleWidget({
    super.key,
    required this.title,
    required this.icon2,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(icon, width: 20.w, height: 20.h, fit: BoxFit.cover),
            UIHelper.horizontalSpace(20.w),
            Text(title, style: TextFontStyle.headLine14c323539InterW400),

            Spacer(),

            Image.asset(icon2, width: 20.w, height: 20.h, fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }
}

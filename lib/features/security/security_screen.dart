import 'package:artneidich_app/common_widget/header_widget.dart';
import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/text_font_style.dart';
import '../../helpers/all_routes.dart';
import '../../helpers/navigation_service.dart';
import '../../helpers/ui_helpers.dart';
import '../settings/widgets/settings_title_widget.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(
              title: "Settings",
              icon: Assets.icons.profile.path,
              subtitle: "Security & Permissions",
            ),

            UIHelper.verticalSpace(30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "Permission Levels",
                style: TextFontStyle.headLine14c323539InterW400.copyWith(
                  color: const Color(0xFF8E8E93),
                  fontSize: 13.sp,

                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            UIHelper.verticalSpace(20.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Divider(color: Color(0xFFEFEFF1), thickness: 1.5),
            ),
            UIHelper.verticalSpace(10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SettingsTitleWidget(
                title: 'Admin',
                icon: Assets.icons.frame1.path,
                onPressed: () {
                  NavigationService.navigateTo(Routes.adminScreen);
                },
              ),
            ),
            UIHelper.verticalSpace(10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Divider(color: Color(0xFFEFEFF1), thickness: 1.5),
            ),
            UIHelper.verticalSpace(10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SettingsTitleWidget(
                title: 'Inspector',
                icon: Assets.icons.frame5.path,
                onPressed: () {
                  NavigationService.navigateTo(Routes.inspectorScreen);
                },
              ),
            ),
            UIHelper.verticalSpace(10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Divider(color: Color(0xFFEFEFF1), thickness: 1.5),
            ),

            UIHelper.verticalSpaceExtraLarge,
          ],
        ),
      ),
    );
  }
}

import 'package:artneidich_app/common_widget/header_widget.dart';
import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/text_font_style.dart';
import '../../helpers/all_routes.dart';
import '../../helpers/navigation_service.dart';
import '../../helpers/ui_helpers.dart';
import '../settings/widgets/settings_title_widget.dart';

class InspectorScreen extends StatefulWidget {
  const InspectorScreen({super.key});

  @override
  State<InspectorScreen> createState() => _InspectorScreenState();
}

class _InspectorScreenState extends State<InspectorScreen> {
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
              subtitle: "Inspector",
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
                title: 'Inspector List',
                icon: Assets.icons.frame1.path,
                onPressed: () {
                  NavigationService.navigateTo(Routes.inspectorListScreen);
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
                title: 'Approval List',
                icon: Assets.icons.frame6.path,
                onPressed: () {
                  NavigationService.navigateTo(Routes.approvalListScreen);
                },
              ),
            ),

            UIHelper.verticalSpaceExtraLarge,
          ],
        ),
      ),
    );
  }
}

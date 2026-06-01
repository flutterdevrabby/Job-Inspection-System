import 'package:artneidich_app/common_widget/header_widget.dart';
import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/text_font_style.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/navigation_service.dart';
import '../../../helpers/ui_helpers.dart';
import '../../settings/widgets/settings_title_widget.dart';

class DataManagementSettingsScreen extends StatefulWidget {
  const DataManagementSettingsScreen({super.key});

  @override
  State<DataManagementSettingsScreen> createState() =>
      _DataManagementSettingsScreenState();
}

class _DataManagementSettingsScreenState
    extends State<DataManagementSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(
              title: "Settings",
              icon: Assets.icons.dataMan.path,
              subtitle: "Data Management",
            ),
            UIHelper.verticalSpace(30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
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
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Divider(color: Color(0xFFEFEFF1), thickness: 1.5),
            ),
            UIHelper.verticalSpace(10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SettingsTitleWidget(
                title: 'Archive Settings',
                icon: Assets.icons.frame1.path,
                onPressed: () {
                  NavigationService.navigateTo(Routes.archiveSettingsScreen);
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Divider(color: Color(0xFFEFEFF1), thickness: 1.5),
            ),
            UIHelper.verticalSpace(10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SettingsTitleWidget(
                title: 'Archive List',
                icon: Assets.icons.archiveList.path,
                onPressed: () {
                  NavigationService.navigateTo(Routes.archiveListScreen);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:developer';
import 'dart:io';

import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:artneidich_app/helpers/all_routes.dart';
import 'package:artneidich_app/helpers/loading_helper.dart';
import 'package:artneidich_app/helpers/navigation_service.dart';
import 'package:artneidich_app/helpers/ui_helpers.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../common_widget/settings_bar_widget.dart';
import '../../constants/app_constants.dart';
import '../../helpers/di.dart';
import '../../helpers/toast.dart';
import '../../networks/api_acess.dart';
import '../../provider/profile_provider.dart';
import 'widgets/settings_title_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),

        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<ProfileProvider>(
                builder: (context, provider, child) {
                  return SettingAppBarWidget(
                    email: provider.data?.email ?? "",
                    fName: provider.data?.firstName ?? "",
                    name:
                        "${provider.data?.firstName ?? ""} ${provider.data?.lastName ?? ""}",
                  );
                },
              ),

              UIHelper.verticalSpace(30.h),
              Text(
                "Settings",
                style: TextFontStyle.headLine14c323539InterW400.copyWith(
                  color: const Color(0xFF8E8E93),
                  fontSize: 13.sp,

                  fontWeight: FontWeight.w500,
                ),
              ),

              UIHelper.verticalSpace(20.h),

              Divider(color: Color(0xFFEFEFF1), thickness: 1.5),
              UIHelper.verticalSpace(10.h),
              SettingsTitleWidget(
                title: 'Profile',
                icon: Assets.icons.frame1.path,
                onPressed: () {
                  NavigationService.navigateTo(Routes.profileScreen);
                },
              ),

              UIHelper.verticalSpace(10.h),
              Divider(color: Color(0xFFEFEFF1), thickness: 1.5),
              UIHelper.verticalSpace(10.h),
              SettingsTitleWidget(
                title: 'Data Management',
                icon: Assets.icons.dataManage.path,
                onPressed: () {
                  NavigationService.navigateTo(
                    Routes.dataManagementSettingsScreen,
                  );
                },
              ),

              UIHelper.verticalSpace(10.h),
              Divider(color: Color(0xFFEFEFF1), thickness: 1.5),
              UIHelper.verticalSpace(10.h),
              SettingsTitleWidget(
                title: 'Security & Permissions',
                icon: Assets.icons.frame2.path,
                onPressed: () {
                  NavigationService.navigateTo(Routes.securityScreen);
                },
              ),

              // UIHelper.verticalSpace(10.h),
              // Divider(color: Color(0xFFEFEFF1), thickness: 1.5),
              // UIHelper.verticalSpace(10.h),
              // SettingsTitleWidget(
              //   isIcon: false,
              //   title: 'Account Deletion',
              //   icon: Assets.images.delete.path,
              //   onPressed: () async {
              //     await showDialog(
              //       barrierDismissible: true,
              //       context: context,
              //       builder: (_) {
              //         return AlertDialog(
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadiusGeometry.circular(10.r),
              //             side: BorderSide(color: Colors.grey),
              //           ),

              //           content: DeleteAlertBox(),
              //         );
              //       },
              //     );
              //   },
              // ),
              UIHelper.verticalSpace(10.h),
              Divider(color: Color(0xFFEFEFF1), thickness: 1.5),
              UIHelper.verticalSpace(10.h),
              SettingsTitleWidget(
                isIcon: false,
                title: 'Logout',
                icon: Assets.icons.logOut.path,
                onPressed: () async {
                  // Get device info once
                  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

                  String deviceId = "";

                  if (Platform.isAndroid) {
                    final androidInfo = await deviceInfo.androidInfo;
                    deviceId = androidInfo.id;
                  } else if (Platform.isIOS) {
                    final iosInfo = await deviceInfo.iosInfo;
                    deviceId = iosInfo.identifierForVendor ?? "";
                  }

                  logoutRxObj
                      .logoutRx(deviceId: deviceId)
                      .waitingForFuture()
                      .then((success) {
                        if (success) {
                          appData.write(kKeyAccessToken, '');
                          appData.write(kKeyIsLoggedIn, false);
                          ToastUtil.showShortToast("Logout Successfully");
                          log(
                            "Device ID==================================$deviceId",
                          );
                          NavigationService.navigateToReplacement(
                            Routes.signinScreen,
                          );
                        }
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

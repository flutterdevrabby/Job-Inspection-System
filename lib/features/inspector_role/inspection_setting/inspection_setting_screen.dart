import 'dart:developer';
import 'dart:io';

import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:artneidich_app/helpers/ui_helpers.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../common_widget/alert_box.dart';
import '../../../constants/app_constants.dart';
import '../../../gen/assets.gen.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/di.dart';
import '../../../helpers/loading_helper.dart';
import '../../../helpers/navigation_service.dart';
import '../../../helpers/toast.dart';
import '../../../networks/api_acess.dart';
import '../../../provider/profile_provider.dart';
import '../../settings/widgets/settings_title_widget.dart';
import '../widgets/inspector_overview_widget.dart';

class InspectionSettingScreen extends StatefulWidget {
  const InspectionSettingScreen({super.key});

  @override
  State<InspectionSettingScreen> createState() =>
      _InspectionSettingScreenState();
}

class _InspectionSettingScreenState extends State<InspectionSettingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<ProfileProvider>(
                builder: (context, profileProvider, child) {
                  if (profileProvider.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF2D8D7C),
                      ),
                    );
                  }
                  return InspectorOverviewAppBarWidget(
                    email: profileProvider.data?.email ?? "",
                    fName: profileProvider.data?.firstName ?? "",
                    name:
                        "${profileProvider.data?.firstName ?? ""} ${profileProvider.data?.lastName ?? ""}",
                  );
                },
              ),

              UIHelper.verticalSpace(30.h),
              Text(
                "Settings",
                style: TextFontStyle.headLine16c141414InterW400.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                  color: Color(0xFF8E8E93),
                ),
              ),
              UIHelper.verticalSpace(8.h),

              //        UIHelper.verticalSpace(10.h),
              //   Divider(color: Color(0xFFEFEFF1), thickness: 1.5),
              // UIHelper.verticalSpace(10.h),

              // SettingsTitleWidget(
              //   title: 'Camera Settings',
              //   icon: Assets.icons.frame12.path,
              //   onPressed: () {
              //     NavigationService.navigateTo(Routes.cameraSettingScreen);
              //   },
              // ),
              UIHelper.verticalSpace(10.h),
              Divider(color: Color(0xFFEFEFF1), thickness: 1.5),
              UIHelper.verticalSpace(10.h),
              SettingsTitleWidget(
                title: 'Notifications',
                icon: Assets.icons.frame13.path,
                onPressed: () {
                  NavigationService.navigateTo(
                    Routes.inspectNotificationScreen,
                  );
                },
              ),

              UIHelper.verticalSpace(10.h),
              Divider(color: Color(0xFFEFEFF1), thickness: 1.5),
              UIHelper.verticalSpace(10.h),
              SettingsTitleWidget(
                title: 'Help & Support',
                icon: Assets.icons.frame14.path,
                onPressed: () {
                  NavigationService.navigateTo(Routes.helpSupportScreen);
                },
              ),

              UIHelper.verticalSpace(10.h),
              Divider(color: Color(0xFFEFEFF1), thickness: 1.5),
              UIHelper.verticalSpace(10.h),
              SettingsTitleWidget(
                isIcon: false,
                title: 'Account Deletion',
                icon: Assets.images.delete.path,
                onPressed: () async {
                  await showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10.r),
                          side: BorderSide(color: Colors.grey),
                        ),

                        content: DeleteAlertBox(),
                      );
                    },
                  );
                },
              ),
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

import 'dart:developer';

import 'package:artneidich_app/common_widget/header_widget.dart';
import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../constants/text_font_style.dart';
import '../../../../helpers/ui_helpers.dart';
import '../../../provider/push_notification_provider.dart';

class InspectNotificationScreen extends StatefulWidget {
  const InspectNotificationScreen({super.key});

  @override
  State<InspectNotificationScreen> createState() =>
      _InspectNotificationScreenState();
}

class _InspectNotificationScreenState extends State<InspectNotificationScreen> {
  @override
  void initState() {
    super.initState();

    // Fetch notification state on screen load (only if not already fetched)
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<PushNotificationProvider>();

      log("Screen loaded. Provider initialized: ${provider.hasInitialized}");
      log(
        "Current switch value before fetch: ${provider.pushController.value}",
      );

      // This will only fetch if not already initialized
      await provider.fetchNotificationState();

      log(
        "fetchNotificationState completed. Current value: ${provider.pushController.value}",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(
              title: "Settings",
              icon: Assets.icons.push.path,
              subtitle: 'Notification',
            ),
            UIHelper.verticalSpace(30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Push Notification",
                    style: TextFontStyle.headLine16c141414InterW400.copyWith(
                      color: const Color(0xFF323539),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Consumer<PushNotificationProvider>(
                    builder: (context, pushNotificationProvider, child) {
                      return ValueListenableBuilder<bool>(
                        valueListenable:
                            pushNotificationProvider.pushController,
                        builder: (context, currentValue, _) {
                          log("Switch rebuilding with value: $currentValue");

                          return AdvancedSwitch(
                            controller: pushNotificationProvider.pushController,
                            activeColor: const Color(0xFF2D8D7C),
                            inactiveColor: Colors.grey,
                            activeChild: const Text('ON'),
                            inactiveChild: const Text('OFF'),
                            borderRadius: BorderRadius.circular(15),
                            width: 60.w,
                            height: 30.h,
                            enabled: !pushNotificationProvider.isLoading,
                            onChanged: (value) {
                              log("User changed switch to: $value");
                              pushNotificationProvider.updatePushStatus(value);
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpaceExtraLarge,

            // Optional: Add a refresh button for testing
            // Center(
            //   child: ElevatedButton(
            //     onPressed: () {
            //       context.read<PushNotificationProvider>().refreshNotificationState();
            //     },
            //     child: const Text('Refresh Status'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

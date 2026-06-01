import 'package:artneidich_app/helpers/all_routes.dart';
import 'package:artneidich_app/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/text_font_style.dart';

class OverviewAppBarWidget extends StatelessWidget {
  final String fName;
  final String name;
  final String email;
  const OverviewAppBarWidget({
    super.key,
    required this.fName,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16.w,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(12.r),
          ),

          child: Text(
            fName.isNotEmpty ? fName.trim().split(' ').first[0] : "?",
          ),
        ),

        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 6.h,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextFontStyle.headLine16c2D8D7CInterW700.copyWith(
                  color: Colors.black,
                ),
              ),
              Text(
                email,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextFontStyle.headLine16c2D8D7CInterW700.copyWith(
                  color: Color(0xFFB3B3B3),
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),

        Spacer(),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: Colors.black),
          onSelected: (value) {
            if (value == 'notification') {
              NavigationService.navigateTo(Routes.notificationScreen);
            } else if (value == 'settings') {
              NavigationService.navigateTo(Routes.settingsScreen);
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(value: 'notification', child: Text('Notification')),
            PopupMenuItem(value: 'settings', child: Text('Settings')),
          ],
        ),
      ],
    );
  }
}

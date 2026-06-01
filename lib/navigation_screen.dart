import 'dart:developer';

import 'package:artneidich_app/constants/app_constants.dart';
import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:artneidich_app/features/inspector_role/inspector_overview/inspector_overview_screen.dart';
import 'package:artneidich_app/features/labels/presentation/labels_screen.dart';
import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:artneidich_app/helpers/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'features/inspection/presentation/inspection_screen.dart';
import 'features/inspector_role/inspection_setting/inspection_setting_screen.dart';
import 'features/inspector_role/inspection_view/presentation/inspection_view_screen.dart';
import 'features/overview/presentation/overview_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  Widget _navImage(String path, bool active) {
    return Image.asset(
      path,
      height: 24.h,
      width: 24.w,
      color: active ? Color(0xFFFFFFFF) : Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    // final role = context.watch<RoleProvider>().userRole;

    final role = appData.read(kKeyRole);

    log(
      "Navigation Role ================================================================>>>>>>>>: $role",
    );

    // Admin Role
    List<Widget> adminPages = const [
      OverviewScreen(),
      InspectionScreen(),
      LabelsScreen(),
    ];
    // Inspector Roel
    List<Widget> inspectorPages = const [
      InspectorOverviewScreen(),
      InspectionViewScreen(),
      InspectionSettingScreen(),
    ];

    // admin group (super admin + admin)
    final isAdminGroup = role == "Super Admin" || role == "Admin";

    // choose based on role
    final pages = isAdminGroup ? adminPages : inspectorPages;

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: pages),

      // BOTTOM NAV
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SafeArea(
          child: GNav(
            textStyle: TextFontStyle.headLine16c2D8D7CInterW700,
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() => _selectedIndex = index);
            },

            iconSize: 0, // hide default icon
            gap: 8,

            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),

            duration: const Duration(milliseconds: 350),
            tabBorderRadius: 16.r,

            color: Colors.grey,

            tabBackgroundColor: Color(0xFF2D8D7C),

            tabs: isAdminGroup
                ? [
                    GButton(
                      icon: Icons.home,
                      leading: _navImage(
                        Assets.images.overview.path,
                        _selectedIndex == 0,
                      ),
                      text: 'Overview',
                    ),

                    GButton(
                      icon: Icons.search,
                      leading: _navImage(
                        Assets.images.inspection.path,
                        _selectedIndex == 1,
                      ),
                      text: 'Inspection',
                    ),

                    GButton(
                      icon: Icons.person,
                      leading: _navImage(
                        Assets.images.label.path,
                        _selectedIndex == 2,
                      ),
                      text: 'Labels',
                    ),
                  ]
                : [
                    GButton(
                      icon: Icons.home,
                      leading: _navImage(
                        Assets.images.overview.path,
                        _selectedIndex == 0,
                      ),
                      text: 'Overview',
                    ),

                    GButton(
                      icon: Icons.search,
                      leading: _navImage(
                        Assets.images.inspection.path,
                        _selectedIndex == 1,
                      ),
                      text: 'Inspection',
                    ),

                    GButton(
                      icon: Icons.person,
                      leading: _navImage(
                        Assets.images.setting.path,
                        _selectedIndex == 2,
                      ),
                      text: 'Settings',
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}

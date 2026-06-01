import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/text_font_style.dart';
import '../gen/colors.gen.dart';
import '../helpers/navigation_service.dart';

class AuthCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final bool automaticallyImplyLeading;

  const AuthCustomAppBar({
    super.key,
    required this.titleText,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: (automaticallyImplyLeading
          ? BackButton(
              color: AppColors.c051F42,
              onPressed: () {
                NavigationService.goBack;
              },
            )
          : null),
      title: Text(titleText, style: TextFontStyle.headLine28c3D3D3DInterW700),
      centerTitle: false,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: AppColors.cFFFFFF,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'gen/assets.gen.dart';

final class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D8D7C),
      //    backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: Image.asset(
          Assets.icons.appIcon.path,
          width: 120.w,
          height: 120.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

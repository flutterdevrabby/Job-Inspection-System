import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:artneidich_app/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../provider/inspector_progress_provider.dart';

class MediaWidget extends StatelessWidget {
  final InspectorProgressProvider provider;
  final int labelIndex;
  final int imageIndex;
  const MediaWidget({
    super.key,
    required this.provider,
    required this.labelIndex,
    required this.imageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 4.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              color: Colors.grey.shade400,
            ),
          ),

          ///
          ///
          ///
          ///
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              NavigationService.goBack;
              provider.pickedImage(
                labelIndex: labelIndex,
                imageIndex: imageIndex,
                imageSource: ImageSource.camera,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 10.w,
              children: [
                Icon(Icons.camera_alt, size: 32.sp, color: Color(0xFF0c5a4b)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4.h,
                  children: [
                    Text(
                      "Camera",
                      style: TextFontStyle.headLine14c323539InterW400.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "Take a photo",
                      style: TextFontStyle.headLine14c323539InterW400.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: Color(0xFF7d7e7f),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Divider(color: Colors.black, thickness: 0.1),

          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              NavigationService.goBack;
              provider.pickedImage(
                labelIndex: labelIndex,
                imageIndex: imageIndex,
                imageSource: ImageSource.gallery,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 10.w,
              children: [
                Icon(
                  Icons.photo_library_outlined,
                  size: 32.sp,
                  color: Color(0xFF0c5a4b),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4.h,
                  children: [
                    Text(
                      "Gallery",
                      style: TextFontStyle.headLine14c323539InterW400.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "Choose from gallery",
                      style: TextFontStyle.headLine14c323539InterW400.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: Color(0xFF7d7e7f),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

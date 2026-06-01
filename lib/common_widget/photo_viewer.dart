import 'dart:developer';
import 'dart:io';

import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:artneidich_app/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewerScreen extends StatelessWidget {
  final String labelName;
  final String imagePath;
  const PhotoViewerScreen({
    super.key,
    required this.labelName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    log("Label Name Here = $labelName");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          labelName,
          style: TextFontStyle.headLine16c141414InterW400.copyWith(
            color: Colors.white,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: false,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            NavigationService.goBack;
          },
        ),
      ),
      body: Center(child: PhotoView(imageProvider: FileImage(File(imagePath)))),
    );
  }
}

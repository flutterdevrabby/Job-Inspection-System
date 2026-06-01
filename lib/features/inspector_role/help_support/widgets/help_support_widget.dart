import 'dart:developer';
import 'dart:io';

import 'package:artneidich_app/helpers/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants/text_font_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../helpers/ui_helpers.dart';
import 'help_support_tile_widegt.dart';

class HelpSupportWidget extends StatelessWidget {
  const HelpSupportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Inspector Guideline
        UIHelper.verticalSpace(10.h),
        Divider(color: Color(0xFFEFEFF1), thickness: 1.5),
        UIHelper.verticalSpace(10.h),
        HelpSettingsTitleWidget(
          title: 'Inspection Guidelines',
          icon: Assets.icons.frame15.path,
          icon2: Assets.icons.download.path,

          onPressed: () async {
            // Show loading
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Preparing PDF...'),
                duration: Duration(seconds: 1),
              ),
            );

            try {
              // Load PDF from assets
              final byteData = await rootBundle.load(
                'assets/media/inspection_guidelines.pdf',
              );
              final bytes = byteData.buffer.asUint8List();

              // Get temporary directory
              final tempDir = await getTemporaryDirectory();
              final timestamp = DateTime.now().millisecondsSinceEpoch;
              final filePath =
                  '${tempDir.path}/inspection_guidelines_$timestamp.pdf';

              // Write file
              final file = File(filePath);
              await file.writeAsBytes(bytes, flush: true);

              // Verify file
              if (!await file.exists() || await file.length() == 0) {
                throw Exception('Failed to create PDF file');
              }

              log(' File created: $filePath (${await file.length()} bytes)');

              // Share using SharePlus.instance.share()
              final result = await SharePlus.instance.share(
                ShareParams(
                  files: [
                    XFile(
                      filePath,
                      mimeType: 'application/pdf',
                      name: 'inspection_guidelines.pdf',
                    ),
                  ],
                  text: 'Inspection Guidelines PDF',
                  subject: 'Inspection Guidelines',
                ),
              );

              log('Share result: ${result.status}');

              // Cleanup
              if (result.status == ShareResultStatus.success ||
                  result.status == ShareResultStatus.dismissed) {
                Future.delayed(const Duration(seconds: 5), () {
                  file.delete().catchError((_) {
                    return file;
                  });
                });
              }
            } catch (e, stackTrace) {
              log('Error: $e');
              log('StackTrace: $stackTrace');

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to share: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
        ),
        UIHelper.verticalSpace(10.h),
        Divider(color: Color(0xFFEFEFF1), thickness: 1.5),

        UIHelper.verticalSpace(30.h),

        //
        Text(
          "Support",
          style: TextFontStyle.headLine16c141414InterW400.copyWith(
            color: const Color(0xFF323539),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),

        // Inspector Guideline
        UIHelper.verticalSpace(10.h),
        Divider(color: Color(0xFFEFEFF1), thickness: 1.5),
        UIHelper.verticalSpace(10.h),
        HelpSettingsTitleWidget(
          title: 'Call Office',
          icon: Assets.icons.vector.path,
          icon2: Assets.icons.frame16.path,
          onPressed: () async {
            try {
              final Uri uri = Uri(scheme: 'tel', path: "469-942-5525");
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              } else {
                throw 'Could not open dial pad';
              }
            } catch (e) {
              ToastUtil.showShortToast(e.toString());
            }
          },
        ),
        UIHelper.verticalSpace(10.h),
        Divider(color: Color(0xFFEFEFF1), thickness: 1.5),

        UIHelper.verticalSpace(10.h),
        HelpSettingsTitleWidget(
          title: 'Email Support',
          icon: Assets.icons.frame18.path,
          icon2: Assets.icons.frame17.path,
          onPressed: () {
            NavigationService.navigateTo(Routes.emailSupportScreen);
          },
        ),
        UIHelper.verticalSpace(10.h),
        Divider(color: Color(0xFFEFEFF1), thickness: 1.5),

        // UIHelper.verticalSpace(10.h),
        // HelpSettingsTitleWidget(
        //   title: 'Office Location',
        //   icon: Assets.icons.frame19.path,
        //   icon2: Assets.icons.frame17.path,
        //   onPressed: () {
        //     //  NavigationService.navigateTo(Routes.securityScreen);
        //   },
        // ),
        // UIHelper.verticalSpace(10.h),
        // Divider(color: Color(0xFFEFEFF1), thickness: 1.5),
      ],
    );
  }
}

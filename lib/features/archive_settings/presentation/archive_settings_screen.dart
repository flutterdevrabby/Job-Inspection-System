import 'dart:developer';

import 'package:artneidich_app/common_widget/custom_button.dart';
import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:artneidich_app/helpers/loading_helper.dart';
import 'package:artneidich_app/helpers/navigation_service.dart';
import 'package:artneidich_app/helpers/toast.dart';
import 'package:artneidich_app/helpers/ui_helpers.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../common_widget/header_widget.dart';
import '../../../gen/assets.gen.dart';
import '../../../networks/api_acess.dart';
import '../../../provider/archive_settings_provider.dart';

class ArchiveSettingsScreen extends StatefulWidget {
  const ArchiveSettingsScreen({super.key});

  @override
  State<ArchiveSettingsScreen> createState() => _ArchiveSettingsScreenState();
}

class _ArchiveSettingsScreenState extends State<ArchiveSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ArchiveSettingsProvider>(
      builder: (context, archiveListProvider, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWidget(
                  title: "Settings",
                  icon: Assets.icons.dataMan.path,
                  subtitle: "Archive Settings",
                ),

                UIHelper.verticalSpace(30.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    "Auto-Archive Completed Jobs",
                    style: TextFontStyle.headLine14c323539InterW400.copyWith(
                      color: Color(0xFF323539),
                    ),
                  ),
                ),

                UIHelper.verticalSpace(20.h),

                //
                archiveListProvider.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF2D8D7C),
                        ),
                      )
                    : archiveListProvider.errorMessage != null
                    ? Center(
                        child: Text(
                          "Error: ${archiveListProvider.errorMessage}",
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: DropdownButtonFormField2(
                          isExpanded: true,
                          value: archiveListProvider.initialValue,
                          items: archiveListProvider.archiveList.map((option) {
                            return DropdownMenuItem<int>(
                              value: option['value'],
                              child: Text(
                                option['title'],
                                style: TextFontStyle.headLine14c323539InterW400
                                    .copyWith(color: Color(0xFF71717A)),
                              ),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            archiveListProvider.updateSelectedOption(newValue);

                            log(
                              "Selected Archive Option: ${archiveListProvider.initialValue}",
                            );
                          },

                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 14.h,
                            ),
                            filled: true,
                            fillColor: Color(0xFFFFFFFF),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: Color(0xFFE4E4E7),
                                width: 1.w,
                              ),
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: Color(0xFFE4E4E7),
                                width: 1.w,
                              ),
                            ),
                          ),
                        ),
                      ),

                //     UIHelper.verticalSpace(20.h),

                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                //   child: DatabaseCapacityWidget(
                //     title: 'Maximum Photo Storage :',
                //     capacity: '100 GB',
                //   ),
                // ),
                // UIHelper.verticalSpace(20.h),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                //   child: DatabaseCapacityWidget(
                //     title: 'Current Storage Used :',
                //     capacity: '12.7 G of 100 GB',
                //   ),
                // ),

                // Update Button
                UIHelper.verticalSpace(40.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Align(
                    alignment: .centerEnd,
                    child: CustomButton(
                      minWidth: 0,
                      onPressed: () {
                        // Handle update settings action

                        archiveSettingUpdateRxObj
                            .archiveSettingUpdateRx(
                              autoArchiveDays: archiveListProvider.initialValue,
                            )
                            .waitingForFuture()
                            .then((success) {
                              if (success) {
                                archiveListProvider.fetchArchiveSettings();
                                ToastUtil.showLongToast(
                                  "Archived Settings Updated Successfully",
                                );
                                NavigationService.goBack;
                              }
                            });
                      },
                      text: "Update Settings",
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

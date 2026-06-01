import 'dart:developer';

import 'package:artneidich_app/common_widget/custom_button.dart';
import 'package:artneidich_app/common_widget/custom_text_field.dart';
import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:artneidich_app/helpers/navigation_service.dart';
import 'package:artneidich_app/helpers/toast.dart';
import 'package:artneidich_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../provider/assign_inspector_provider.dart';

// ignore: must_be_immutable
class InspectionViewShowSearchBottomWidget extends StatelessWidget {
  final TextEditingController search;
  final TextEditingController dateController;
  final AssignInspectorProvider provider;

  const InspectionViewShowSearchBottomWidget({
    super.key,
    required this.search,
    required this.dateController,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        // height: 0.30.sh,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
        ),

        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 60.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),

              UIHelper.verticalSpace(16.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Search by City or Due Date",
                    style: TextFontStyle.headLine16c141414InterW400.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.sp,
                      color: Color(0xFF000000),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      NavigationService.goBack;
                      provider.refreshData();
                    },
                    child: Text("Reset Filter"),
                  ),
                ],
              ),

              UIHelper.verticalSpace(10.h),

              CustomTextField(
                controller: search,
                hintText: "Search City name",
                prefixIcon: Assets.icons.frame,
                suffixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: IconButton(
                    onPressed: () {
                      search.clear();
                    },
                    icon: Icon(Icons.close, color: Colors.black),
                  ),
                ),
              ),
              UIHelper.verticalSpace(10.h),
              CustomTextField(
                readOnly: true,
                controller: dateController,
                hintText: "Search by due Date",
                prefixIcon: Assets.icons.calendar,
                onTap: () async {
                  final DateTimeRange? pickedDate = await showDateRangePicker(
                    context: context,

                    cancelText: "Cancel",
                    confirmText: "Confirm",
                    firstDate: DateTime(2025),
                    lastDate: DateTime(2100),
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Color(0xFF2D8D7C),
                            onPrimary: Colors.white,
                            onSurface: Colors.black,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: Color(0xFF2D8D7C),
                            ),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.82,
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.60,
                            ),
                            child: child!,
                          ),
                        ),
                      );
                    },
                  );

                  if (pickedDate != null) {

           //         UI FORMAT
                    String startDate = DateFormat(
                      "dd-MM-yyyy",
                    ).format(pickedDate.start);
                    String endDate = DateFormat(
                      "dd-MM-yyyy",
                    ).format(pickedDate.end);

                    // API FORMAT
                    String startDateAPIFORMAT = DateFormat(
                      "yyyy-MM-dd",
                    ).format(pickedDate.start);
                    String endDateAPIFORMAT = DateFormat(
                      "yyyy-MM-dd",
                    ).format(pickedDate.end);

                    dateController.text = "$startDate - $endDate";

                    provider.updateRangeDatePicker(
                      dueDateFrom: startDateAPIFORMAT,
                      dueDateTo: endDateAPIFORMAT,
                    );

                    //        selectDate = DateFormat("yyyy-MM-dd").format(pickedDate);
                  }
                },
              ),

              UIHelper.verticalSpace(30.h),

              CustomButton(
                onPressed: () {
                  if (search.text.isNotEmpty ||
                      dateController.text.isNotEmpty) {
                    provider.searchJobUpdate(
                      search.text,
                      provider.dueDateFrom,
                      provider.dueDateTo,
                    );
                    log(provider.dueDateFrom.toString());
                    log(provider.dueDateTo.toString());
                    NavigationService.goBack;
                    search.clear();
                    dateController.clear();
                  } else {
                    ToastUtil.showErrorLongToast(
                      "Enter a city name or pick a date to search",
                    );
                  }
                },
                text: "Apply",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

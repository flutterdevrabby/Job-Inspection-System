import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../constants/text_font_style.dart';
import '../../../provider/inspection_provider.dart';

class PopupFilterWidget extends StatelessWidget {
  final InspectionProvider provider;
  const PopupFilterWidget({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Jobs",
          style: TextFontStyle.headLine28c3D3D3DInterW700.copyWith(
            fontSize: 18.sp,
            color: Colors.white,
          ),
        ),

        PopupMenuButton<String>(
          color: Colors.white,
          constraints: BoxConstraints(maxWidth: 170.w),
          //  padding: EdgeInsets.zero,
          //   menuPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10.r),
          ),
          borderRadius: BorderRadius.circular(10.r),
          icon: Icon(Icons.more_vert, color: Colors.white),
          onSelected: (value) async {
            if (value == 'this_month') {
              provider.toggleDateFilter(dateType: "this_month");
            } else if (value == 'previous_month') {
              provider.toggleDateFilter(dateType: "previous_month");
            } else if (value == 'custom') {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),

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
                    child: child!,
                  );
                },
              );

              if (pickedDate != null) {
                provider.toggleDateFilter(
                  dateType: "custom",
                  customDate: DateFormat("yyyy-MM-dd").format(pickedDate),
                );
              }
            }
          },

          itemBuilder: (context) => [
            CheckedPopupMenuItem(
              value: 'this_month',
              checked: provider.selectedDateType == "this_month",
              child: Text(
                'This Month',
                style: TextFontStyle.headLine14c323539InterW400.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            CheckedPopupMenuItem(
              value: 'previous_month',
              checked: provider.selectedDateType == "previous_month",
              child: Text(
                'Previous Month',
                style: TextFontStyle.headLine14c323539InterW400.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            CheckedPopupMenuItem(
              value: 'custom',
              checked: provider.selectedDateType == "custom",
              child: Text(
                'Custom',
                style: TextFontStyle.headLine14c323539InterW400.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

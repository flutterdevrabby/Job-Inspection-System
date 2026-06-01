import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../constants/text_font_style.dart';
import '../../../helpers/ui_helpers.dart';
import '../data/rx_get_report/model/job_report_response.dart';
import '../widgets/emails_log_widget.dart';

class EmailLog extends StatelessWidget {
  final ReportData reportData;
  const EmailLog({super.key, required this.reportData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            "Email Log",
            style: TextFontStyle.headLine16c141414InterW400.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 18.sp,
            ),
          ),
        ),

        UIHelper.verticalSpace(20.h),
        EmailLogWidget(
          title: 'Timestamp',
          value: DateFormat(
            'd MMMM yyyy',
          ).format(reportData.createdAt ?? DateTime.now()),
          status: false,
        ),
        UIHelper.verticalSpace(20.h),
        EmailLogWidget(title: 'Status', value: reportData.status ?? ""),
        //  UIHelper.verticalSpace(20.h),
        //  EmailLogWidget(title: 'Message ID', value: '-', status: false),
      ],
    );
  }
}

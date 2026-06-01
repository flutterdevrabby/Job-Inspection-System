import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/text_font_style.dart';
import '../../../helpers/ui_helpers.dart';
import '../../../provider/job_details_provider.dart';
import '../widgets/contact_card_widget.dart';
import '../widgets/internal_note_widget.dart';
import '../widgets/job_details_widget.dart';

class SummaryWidget extends StatelessWidget {
  final JobDetailsProvider provider;

  const SummaryWidget({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            "Job Summary",
            style: TextFontStyle.headLine16c141414InterW400.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 18.sp,
            ),
          ),
        ),

        UIHelper.verticalSpace(20.h),
        JobDetailsWidget(
          title: 'Inspector',
          value:
              "${provider.data?.inspector?.firstName ?? ""} ${provider.data?.inspector?.lastName ?? ""}",
        ),
        UIHelper.verticalSpace(20.h),
        JobDetailsWidget(
          title: 'FHA Case Details',
          value: provider.data?.fhaCaseDetailsNo ?? "",
        ),
        UIHelper.verticalSpace(20.h),
        JobDetailsWidget(title: 'OrderID', value: provider.data?.orderId ?? ""),
        UIHelper.verticalSpace(20.h),
        JobDetailsWidget(
          title: 'Fee Status',
          value: provider.data?.feeStatus ?? "",
        ),

        UIHelper.verticalSpace(20.h),
        JobDetailsWidget(
          title: 'Agreed Feee',
          value: provider.data?.agreedFee.toString() ?? "",
        ),
        UIHelper.verticalSpace(20.h),
        JobDetailsWidget(
          title: 'Form Type',
          value: provider.data?.formType ?? "",
        ),
        UIHelper.verticalSpace(20.h),
        JobDetailsWidget(
          title: 'Street Address',
          value: provider.data?.streetAddress ?? "",
        ),
        UIHelper.verticalSpace(20.h),
        JobDetailsWidget(
          title: 'Development',
          value: provider.data?.developmentName ?? "",
        ),

        UIHelper.verticalSpace(30.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            "Site Contact Information",
            style: TextFontStyle.headLine16c141414InterW400.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 18.sp,
            ),
          ),
        ),

        UIHelper.verticalSpace(20.h),

        ContactCardWidget(
          name: provider.data?.siteContactName ?? "",
          phone: provider.data?.siteContactPhone ?? "",
          email: provider.data?.siteContactEmail ?? "",
        ),

        UIHelper.verticalSpace(20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            "Internal Notes",
            style: TextFontStyle.headLine16c141414InterW400.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 18.sp,
            ),
          ),
        ),

        UIHelper.verticalSpace(20.h),
        InternalNotesWidget(
          noteInspector: provider.data?.specialNotesForInspector ?? "",
          noteAp: provider.data?.specialNoteForApOrAr ?? "",
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common_widget/header_widget.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../helpers/ui_helpers.dart';
import '../../inspection_view/data/rx_get/model/inspection_response.dart';
import '../widgets/inspection_contact_widget.dart';
import '../widgets/inspection_details_widget.dart';
import '../widgets/inspection_internal_widget.dart';

class InspectionSummaryScreen extends StatelessWidget {
  final Datum datum;

  const InspectionSummaryScreen({super.key, required this.datum});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(
              title: "Jobs",
              icon: Assets.images.jobsIcon.path,
              subtitle: 'Inspections',
            ),

            UIHelper.verticalSpace(20.h),
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
            InspectionDetailsWidget(
              title: 'Assigned By',
              value:
                  '${datum.createdBy?.firstName} ${datum.createdBy?.lastName}',
            ),
            UIHelper.verticalSpace(20.h),
            InspectionDetailsWidget(
              title: 'FHA Case Details',
              value: datum.fhaCaseDetailsNo ?? 'N/A',
            ),
            UIHelper.verticalSpace(20.h),
            InspectionDetailsWidget(
              title: 'OrderID',
              value: datum.orderId ?? 'N/A',
            ),
            //  UIHelper.verticalSpace(20.h),

            //             Do not show Fee
            // Status on inspectors
            // area---
            // InspectionDetailsWidget(
            //   title: 'Fee Status',
            //   value: datum.feeStatus ?? 'N/A',
            // ),
            //   UIHelper.verticalSpace(20.h),

            // Change to Fee
            // InspectionDetailsWidget(
            //   title: 'Agreed Fee',
            //   value: datum.agreedFee.toString(),
            // ),
            UIHelper.verticalSpace(20.h),
            InspectionDetailsWidget(
              title: 'Form Type',
              value: datum.formType ?? 'N/A',
            ),
            UIHelper.verticalSpace(20.h),
            InspectionDetailsWidget(
              title: 'Street Address',
              value: datum.streetAddress ?? 'N/A',
            ),

            //             Does not print on
            // the report
            // UIHelper.verticalSpace(20.h),
            // InspectionDetailsWidget(
            //   title: 'Development',
            //   value: datum.developmentName.toString(),
            // ),
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

            InspectionContactCardWidget(
              name: datum.siteContactName ?? '',
              phone: datum.siteContactPhone ?? '',
              email: datum.siteContactEmail ?? '',
            ),

            UIHelper.verticalSpace(20.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "Submission Details",
                style: TextFontStyle.headLine16c141414InterW400.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 18.sp,
                ),
              ),
            ),

            UIHelper.verticalSpace(16.h),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Submission Status",
                      style: TextFontStyle.headLine16c141414InterW400.copyWith(
                        color: const Color(0xFF848B94),
                        fontSize: 14.sp,

                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  // colon fixed – no Expanded
                  Text(
                    ": ",
                    style: TextFontStyle.headLine16c141414InterW400.copyWith(
                      color: const Color(0xFF848B94),
                      fontSize: 14.sp,

                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  UIHelper.horizontalSpace(20.w),

                  // value comes just after colon
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFDF3D7),

                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 8.h,
                      ),

                      child: Text(
                        datum.reportStatusLabel ?? "",
                        style: TextFontStyle.headLine16c141414InterW400
                            .copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
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
            InspectionInternalNotesWidget(
              noteInspector: datum.specialNotesForInspector ?? "",
              //'Look for the damages caused by thunder',
              //   noteAp: "", // datum.specialNoteForApOrAr ??
              //'None',
              // formInspector:
              //     'Looked for the damages caused by thunder, and found prove of damages in rooftop',
            ),

            UIHelper.verticalSpaceExtraLarge,
          ],
        ),
      ),
    );
  }
}

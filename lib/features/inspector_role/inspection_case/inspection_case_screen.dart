import 'package:artneidich_app/common_widget/custom_text_field.dart';
import 'package:artneidich_app/helpers/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common_widget/custom_button.dart';
import '../../../../common_widget/header_widget.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../helpers/ui_helpers.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/navigation_service.dart';
import '../inspection_view/data/rx_get/model/inspection_response.dart';

class InspectionCaseScreen extends StatefulWidget {
  final String fhaCaseID;
  final bool resubmitStatus;
  final Datum? datum;

  const InspectionCaseScreen({
    super.key,
    required this.fhaCaseID,
    this.datum,
    required this.resubmitStatus,
  });

  @override
  State<InspectionCaseScreen> createState() => _InspectionCaseScreenState();
}

class _InspectionCaseScreenState extends State<InspectionCaseScreen> {
  final fHAcaseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fHAcaseController.text = widget.fhaCaseID;
  }

  @override
  void dispose() {
    super.dispose();
    fHAcaseController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header AppBar Widget
            HeaderWidget(
              title: "Jobs",
              icon: Assets.images.jobsIcon.path,
              subtitle: 'Inspections',
            ),

            UIHelper.verticalSpace(20.h),

            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
              child: Text(
                "FHA Case Details",
                style: TextFontStyle.headLine14c323539InterW400,
              ),
            ),
            UIHelper.verticalSpace(8.h),

            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
              child: CustomTextField(
                controller: fHAcaseController,
                readOnly: true,
              ),
            ),

            UIHelper.verticalSpace(20.h),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
              child: Align(
                alignment: Alignment.topRight,
                child: CustomButton(
                  onPressed: () {
                    if (widget.fhaCaseID.isNotEmpty) {
                      NavigationService.navigateToWithArgs(
                        Routes.inspectionLabelScreen,
                        {
                          "labelType": "endInspector",
                          "datum": widget.datum,
                          "resubmitStatus": widget.resubmitStatus,
                        },
                      );
                    } else {
                      ToastUtil.showShortToast("Fha Case Id is Empty");
                    }
                  },
                  borderRadius: 30.r,
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                    vertical: 12.h,
                  ),
                  minWidth: 0,
                  child: Row(
                    spacing: 10.w,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Text(
                        "Next",
                        style: TextFontStyle.headLine16c2D8D7CInterW700,
                      ),
                      Image.asset(
                        Assets.icons.arrowRight.path,
                        width: 20.w,
                        height: 20.h,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

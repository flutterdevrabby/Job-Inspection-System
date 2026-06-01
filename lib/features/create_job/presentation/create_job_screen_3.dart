import 'dart:developer';

import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:artneidich_app/helpers/navigation_service.dart';
import 'package:artneidich_app/helpers/toast.dart';
import 'package:artneidich_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../common_widget/custom_button.dart';
import '../../../common_widget/custom_text_field.dart';
import '../../../common_widget/job_create_header.dart';
import '../../../constants/text_font_style.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/loading_helper.dart';
import '../../../networks/api_acess.dart';
import '../../../provider/admin_overview_provider.dart';
import '../../../provider/inspection_provider.dart';

class CreateJobScreen3 extends StatefulWidget {
  final String inspectorID;
  final String formType;
  final String feeStatus;
  final int agreedStatus;

  // Second Screen

  final String fhaCaseDetails;
  final String orderID;
  final String streetAddress;
  final String developmentName;
  final String contactName;
  final String phone;
  final String email;

  const CreateJobScreen3({
    super.key,
    required this.inspectorID,
    required this.formType,
    required this.feeStatus,
    required this.agreedStatus,
    required this.fhaCaseDetails,
    required this.orderID,
    required this.streetAddress,
    required this.developmentName,
    required this.contactName,
    required this.phone,
    required this.email,
  });

  @override
  State<CreateJobScreen3> createState() => _CreateJobScreen3State();
}

class _CreateJobScreen3State extends State<CreateJobScreen3> {
  final _dateController = TextEditingController();
  final _noteInspector = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
    _noteInspector.dispose();
  }

  String date = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JobCreateHeaderWidget(
                title: "Jobs",
                icon: Assets.images.createJob.path,
                subtitle: "Create New Job",
                onPressed: () {
                  NavigationService.goBack;
                },
              ),

              UIHelper.verticalSpace(20.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Due Date",
                  style: TextFontStyle.headLine14c323539InterW400,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomTextField(
                  readOnly: true,
                  onTap: () async {
                    final DateTime today = DateTime.now();
                    final DateTime firstSelectableDate = DateTime(
                      today.year,
                      today.month,
                      today.day,
                    ).add(Duration(days: 1));
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate:
                          firstSelectableDate, // picker opens at tomorrow
                      firstDate:
                          firstSelectableDate, // disable today and past dates
                      lastDate: DateTime(2100), // max future date
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
                      setState(() {
                        _dateController.text = DateFormat(
                          'dd-MM-yyyy',
                        ).format(pickedDate);

                        // Global variable for API
                        date = pickedDate.toUtc().toIso8601String();
                      });
                    }
                  },
                  suffixIcon: Icon(
                    Icons.date_range_outlined,
                    color: Color(0xFF2D8D7C),
                  ),
                  controller: _dateController,
                  style: TextFontStyle.headLine14c323539InterW400.copyWith(
                    color: Color(0xFF71717A),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Due Date is required";
                    }
                    return null;
                  },
                ),
              ),

              UIHelper.verticalSpace(12.h),

              //Inspector
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Note to Inspector (Optional)",
                  style: TextFontStyle.headLine14c323539InterW400,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomTextField(
                  maxLines: 8,
                  maxLength: 250,
                  hintStyle: TextFontStyle.headLine14c323539InterW400,
                  hintText: "Write your notes here....",
                  controller: _noteInspector,
                  style: TextFontStyle.headLine14c323539InterW400.copyWith(
                    color: Color(0xFF71717A),
                  ),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return "Note inspector is required";
                  //   }
                  //   return null;
                  // },
                ),
              ),

              UIHelper.verticalSpace(10.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Keep notes under. 250 characters.",
                  style: TextFontStyle.headLine14c323539InterW400,
                ),
              ),

              UIHelper.verticalSpace(20.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Align(
                  alignment: Alignment.topRight,
                  child: CustomButton(
                    onPressed: () {
                      log(date);
                      if (_formKey.currentState!.validate()) {
                        createJobRxObj
                            .createJobRx(
                              inspector: widget.inspectorID,
                              formType: widget.formType,
                              feeStatus: widget.feeStatus,
                              agreedFee: widget.agreedStatus,
                              fhaCaseDetailsNo: widget.fhaCaseDetails,
                              orderId: widget.orderID,
                              streetAddress: widget.streetAddress,
                              developmentName: widget.developmentName,
                              siteContactName: widget.contactName,
                              siteContactPhone: widget.phone,
                              siteContactEmail: widget.email,
                              dueDate: date,
                              specialNotesForInspector: _noteInspector.text,
                            )
                            .waitingForFuture()
                            .then((success) {
                              if (success) {
                                //       context.read<LabelProvider>().refreshAllLabel();
                                // Fresh List for all Job
                                context.read<InspectionProvider>().refresh();

                                // Overview screen data update
                                context
                                    .read<AdminOverviewProvider>()
                                    .fetchAdminOverviewData();

                                ToastUtil.showShortToast(
                                  "Job created successfully",
                                );
                                NavigationService.navigateToReplacement(
                                  Routes.navigationScreen,
                                );
                              }
                            });
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
                          "Assign",
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

              UIHelper.verticalSpaceExtraLarge,
            ],
          ),
        ),
      ),
    );
  }
}

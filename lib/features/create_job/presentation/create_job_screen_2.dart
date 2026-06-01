import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:artneidich_app/helpers/navigation_service.dart';
import 'package:artneidich_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common_widget/custom_button.dart';
import '../../../common_widget/custom_text_field.dart';
import '../../../common_widget/job_create_header.dart';
import '../../../constants/text_font_style.dart';
import '../../../constants/validation.dart';
import '../../../helpers/all_routes.dart';

class CreateJobScreen2 extends StatefulWidget {
  final String inspectorID;
  final String formType;
  final String feeStatus;
  final int agreedStatus;
  const CreateJobScreen2({
    super.key,
    required this.inspectorID,
    required this.formType,
    required this.feeStatus,
    required this.agreedStatus,
  });

  @override
  State<CreateJobScreen2> createState() => _CreateJobScreen2State();
}

class _CreateJobScreen2State extends State<CreateJobScreen2> {
  // Agreed controller
  final _fhaCaseDetailsController = TextEditingController();
  final _orderIdController = TextEditingController();
  final _adressController = TextEditingController();
  final _developermentController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();

    _fhaCaseDetailsController.dispose();
    _orderIdController.dispose();
    _adressController.dispose();
    _developermentController.dispose();
    _nameController.dispose();
    _emailontroller.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
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
                  "FHA Case Details",
                  style: TextFontStyle.headLine14c323539InterW400,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomTextField(
                  controller: _fhaCaseDetailsController,
                  style: TextFontStyle.headLine14c323539InterW400.copyWith(
                    color: Color(0xFF71717A),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "FHA case is required";
                    }
                    return null;
                  },
                ),
              ),

              UIHelper.verticalSpace(12.h),

              // order id
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Order ID",
                  style: TextFontStyle.headLine14c323539InterW400,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomTextField(
                  controller: _orderIdController,
                  style: TextFontStyle.headLine14c323539InterW400.copyWith(
                    color: Color(0xFF71717A),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Order Id is required";
                    }
                    return null;
                  },
                ),
              ),

              // Stress Address
              UIHelper.verticalSpace(12.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Street Address",
                  style: TextFontStyle.headLine14c323539InterW400,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomTextField(
                  controller: _adressController,
                  style: TextFontStyle.headLine14c323539InterW400.copyWith(
                    color: Color(0xFF71717A),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Street address is required";
                    }
                    return null;
                  },
                ),
              ),

              UIHelper.verticalSpace(12.h),

              // Developemnt
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Development Name",
                  style: TextFontStyle.headLine14c323539InterW400,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomTextField(
                  controller: _developermentController,
                  style: TextFontStyle.headLine14c323539InterW400.copyWith(
                    color: Color(0xFF71717A),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Devlopment is required";
                    }
                    return null;
                  },
                ),
              ),

              UIHelper.verticalSpace(12.h),

              // Name
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Site Contact Name",
                  style: TextFontStyle.headLine14c323539InterW400,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomTextField(
                  controller: _nameController,
                  style: TextFontStyle.headLine14c323539InterW400.copyWith(
                    color: Color(0xFF71717A),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name is required";
                    }
                    return null;
                  },
                ),
              ),

              UIHelper.verticalSpace(12.h),

              // Phone
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Phone",
                  style: TextFontStyle.headLine14c323539InterW400,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomTextField(
                  textInputAction: TextInputAction.next,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: _phoneController,
                  style: TextFontStyle.headLine14c323539InterW400.copyWith(
                    color: Color(0xFF71717A),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Phone is required";
                    }
                    return null;
                  },
                ),
              ),

              UIHelper.verticalSpace(12.h),

              // Email
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Email",
                  style: TextFontStyle.headLine14c323539InterW400,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomTextField(
                  controller: _emailontroller,
                  style: TextFontStyle.headLine14c323539InterW400.copyWith(
                    color: Color(0xFF71717A),
                  ),
                  validator: emailValidation,
                ),
              ),

              UIHelper.verticalSpace(20.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Align(
                  alignment: Alignment.topRight,
                  child: CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        NavigationService.navigateToWithArgs(
                          Routes.createJobScreen3,
                          {
                            "inspectorID": widget.inspectorID,
                            "formType": widget.formType,
                            "feeStatus": widget.feeStatus,
                            "agreedStatus": widget.agreedStatus,

                            // second screen
                            "fhaCaseDetails": _fhaCaseDetailsController.text,
                            "orderID": _orderIdController.text,
                            "streetAddress": _adressController.text,
                            "developmentName": _developermentController.text,
                            "contactName": _nameController.text,
                            "phone": _phoneController.text,
                            "email": _emailontroller.text,
                          },
                        );
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

              UIHelper.verticalSpaceExtraLarge,
            ],
          ),
        ),
      ),
    );
  }
}

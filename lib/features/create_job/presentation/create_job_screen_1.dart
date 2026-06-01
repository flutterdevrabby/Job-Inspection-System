import 'dart:developer';

import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:artneidich_app/helpers/navigation_service.dart';
import 'package:artneidich_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../common_widget/custom_button.dart';
import '../../../common_widget/custom_drop_down_widget.dart';
import '../../../common_widget/custom_text_field.dart';
import '../../../common_widget/form_type.dart';
import '../../../common_widget/job_create_header.dart';
import '../../../constants/text_font_style.dart';
import '../../../helpers/all_routes.dart';
import '../../../provider/create_job_provider.dart';

class CreateJobScreen1 extends StatefulWidget {
  const CreateJobScreen1({super.key});

  @override
  State<CreateJobScreen1> createState() => _CreateJobScreen1State();
}

class _CreateJobScreen1State extends State<CreateJobScreen1> {
  // Form Type
  int selectedFormType = -1;

  String? selectformType;
  List<String> formList = ["HUD/FHA 92051 Compliance-FINAL"];

  // Fee Status
  int selectedFeeStatus = -1;

  String? feeStatus;

  List<String> feeStatusList = [
    "Standard",
    "Rush Order",
    "Occupied Fee",
    "Modified Fee",
    "Long Distance Fee",
  ];

  // Agreed controller
  final _agreeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _inspectorController.dispose();
    _agreeController.dispose();
  }

  final _inspectorController = TextEditingController();
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
                  "Select Inspector",
                  style: TextFontStyle.headLine14c323539InterW400,
                ),
              ),
              UIHelper.verticalSpace(10.h),

              /// Inspector Name
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomTextField(
                  hintText: "Inspector Name",
                  hintStyle: TextFontStyle.headLine14c323539InterW400.copyWith(
                    color: Color(0xFF71717A).withValues(alpha: 0.7),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Inspector is required";
                    }
                    return null;
                  },

                  suffixIcon: Icon(Icons.arrow_drop_down),
                  style: TextFontStyle.headLine14c323539InterW400.copyWith(
                    color: Color(0xFF71717A),
                  ),
                  controller: _inspectorController,
                  readOnly: true,
                  onTap: () async {
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      context: context,
                      builder: (_) {
                        return Consumer<CreateJobProvider>(
                          builder: (context, provider, child) {
                            return SizedBox(
                              height: 400.h,
                              child: ListView.builder(
                                controller: provider.scrollController,
                                physics: const BouncingScrollPhysics(),

                                itemCount: provider.hasMore
                                    ? provider.users.length + 1
                                    : provider.users.length,

                                itemBuilder: (_, index) {
                                  if (index < provider.users.length) {
                                    final user = provider.users[index];

                                    return ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                      selectedColor: Colors.green,
                                      title: Text(
                                        "${user.firstName ?? ""} ${user.lastName ?? ""}",
                                        style: TextFontStyle
                                            .headLine14c323539InterW400
                                            .copyWith(color: Color(0xFF71717A)),
                                      ),
                                      subtitle: Text(
                                        user.email ?? "",
                                        style: TextFontStyle
                                            .headLine14c323539InterW400
                                            .copyWith(
                                              color: Color(0xFF71717A),
                                              fontSize: 12.sp,
                                            ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);

                                        /// set name
                                        _inspectorController.text =
                                            "${user.firstName ?? ""} ${user.lastName ?? ""}";

                                        // Update User Id
                                        provider.setSelectedUser(user.id);

                                        log(
                                          "Select User ID=============================================${user.id}",
                                        );
                                      },
                                    );
                                  }

                                  /// bottom loader only when loading more
                                  if (provider.isLoadMore) {
                                    return Padding(
                                      padding: EdgeInsets.all(16.r),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }

                                  return const SizedBox.shrink();
                                },
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),

              UIHelper.verticalSpace(10.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Form Type",
                  style: TextFontStyle.headLine14c323539InterW400,
                ),
              ),

              UIHelper.verticalSpace(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: FormTypeDropDownWidget(
                  hintText: "Select Type",
                  items: formList,
                  value: selectformType,

                  validator: (value) {
                    if (value == null) return "Form Type is required";
                    return null;
                  },

                  onChanged: (value) {
                    setState(() {
                      selectformType = value!;
                    });
                  },
                ),
              ),

              UIHelper.verticalSpace(12.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Fee Status",
                  style: TextFontStyle.headLine14c323539InterW400,
                ),
              ),

              UIHelper.verticalSpace(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomDropDownWidget(
                  hintText: "Select Fee Type",
                  items: feeStatusList,
                  value: selectedFeeStatus == -1 ? null : selectedFeeStatus,

                  validator: (value) {
                    if (value == null) return "Fee Type is required";
                    return null;
                  },

                  onChanged: (value) {
                    setState(() {
                      selectedFeeStatus = value!;

                      if (selectedFormType == 0) {
                        feeStatus = "Standard";
                      } else if (selectedFormType == 1) {
                        feeStatus = "Rush Order";
                      } else if (selectedFormType == 2) {
                        feeStatus = "Occupied Fee";
                      } else if (selectedFormType == 3) {
                        feeStatus = "Modified Fee";
                      } else {
                        feeStatus = "Long Distance Fee";
                      }
                    });
                  },
                ),
              ),

              UIHelper.verticalSpace(12.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Agreed Status",
                  style: TextFontStyle.headLine14c323539InterW400,
                ),
              ),

              UIHelper.verticalSpace(10.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomTextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  hintText: "status fees",

                  prefix: Text("\$"),
                  hintStyle: TextFontStyle.headLine14c323539InterW400.copyWith(
                    color: Color(0xFF71717A).withValues(alpha: 0.7),
                  ),
                  controller: _agreeController,
                  style: TextFontStyle.headLine14c323539InterW400.copyWith(
                    color: Color(0xFF71717A),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Agreed satus is required";
                    }
                    return null;
                  },
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
                          Routes.createJobScreen2,
                          {
                            "inspectorID": context
                                .read<CreateJobProvider>()
                                .selectedUserId,
                            "formType": selectformType,
                            "feeStatus": feeStatus,
                            "agreedStatus": int.tryParse(_agreeController.text),
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
            ],
          ),
        ),
      ),
    );
  }
}

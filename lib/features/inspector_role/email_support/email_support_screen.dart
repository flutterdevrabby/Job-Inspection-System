import 'package:artneidich_app/common_widget/custom_text_field.dart';
import 'package:artneidich_app/common_widget/header_widget.dart';
import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:artneidich_app/helpers/loading_helper.dart';
import 'package:artneidich_app/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../helpers/ui_helpers.dart';
import '../../../../constants/text_font_style.dart';
import '../../../common_widget/custom_button.dart';
import '../../../helpers/toast.dart';
import '../../../networks/api_acess.dart';

class EmailSupportScreen extends StatefulWidget {
  const EmailSupportScreen({super.key});

  @override
  State<EmailSupportScreen> createState() => _EmailSupportScreenState();
}

class _EmailSupportScreenState extends State<EmailSupportScreen> {
  final supportController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    supportController.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(
                title: "Settings",
                icon: Assets.icons.farem21.path,
                subtitle: 'Email Support',
              ),

              UIHelper.verticalSpace(30.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Write your message",
                  style: TextFontStyle.headLine16c141414InterW400.copyWith(
                    color: const Color(0xFF323539),
                    fontSize: 14.sp,

                    fontWeight: FontWeight.w400,
                    height: 1.43,
                  ),
                ),
              ),

              UIHelper.verticalSpace(8.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomTextField(
                  controller: supportController,
                  maxLength: 250,
                  maxLines: 5,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please write your message";
                    }
                    return null;
                  },

                  hintStyle: TextFontStyle.headLine14c323539InterW400.copyWith(
                    color: const Color(0xFF71717A),
                    fontSize: 14.sp,

                    fontWeight: FontWeight.w400,
                  ),

                  hintText: "Write tour message here",
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Keep notes under 250 characters.",
                  style: TextFontStyle.headLine16c141414InterW400.copyWith(
                    color: const Color(0xFF71717A),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              UIHelper.verticalSpace(20.h),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
                child: Align(
                  alignment: Alignment.topRight,
                  child: CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        emailSupportRxObj
                            .emailSupportRx(message: supportController.text)
                            .waitingForFuture()
                            .then((success) {
                              if (success) {
                                ToastUtil.showShortToast(
                                  "Message sent successfully",
                                );
                                NavigationService.goBack;
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
                          "Send",
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

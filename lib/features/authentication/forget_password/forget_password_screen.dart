import 'package:artneidich_app/common_widget/custom_text_field.dart';
import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:artneidich_app/helpers/all_routes.dart';
import 'package:artneidich_app/helpers/loading_helper.dart';
import 'package:artneidich_app/helpers/navigation_service.dart';
import 'package:artneidich_app/helpers/toast.dart';
import 'package:artneidich_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common_widget/auth_custom_app_bar.dart';
import '../../../common_widget/custom_button.dart';
import '../../../constants/validation.dart';
import '../../../networks/api_acess.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _email = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _email.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthCustomAppBar(titleText: 'Forget Password'),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter your email address that is used to create your account",
                style: TextFontStyle.headLine16c141414InterW400.copyWith(
                  color: Color(0xFF888888),
                ),
              ),

              UIHelper.verticalSpace(32.h),

              // Email Address
              Text(
                "Email Address",
                style: TextFontStyle.headLine16c141414InterW400,
              ),
              UIHelper.verticalSpace(4.h),
              CustomTextField(
                controller: _email,
                filled: true,
                validator: emailValidation,
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: CustomButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              forgetPasswordRxObj
                  .forgetPasswordRx(email: _email.text)
                  .waitingForFuture()
                  .then((success) {
                    if (success) {
                      ToastUtil.showShortToast(
                        "Otp sent successfully. Please check your email.",
                      );
                      NavigationService.navigateToWithArgs(
                        Routes.otpVerifiedScreen,
                        {"email": _email.text},
                      );
                    }
                  });
            }
          },
          text: "Contine",
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

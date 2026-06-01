import 'package:artneidich_app/helpers/all_routes.dart';
import 'package:artneidich_app/helpers/loading_helper.dart';
import 'package:artneidich_app/helpers/navigation_service.dart';
import 'package:artneidich_app/helpers/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../common_widget/auth_custom_app_bar.dart';
import '../../../common_widget/custom_button.dart';
import '../../../common_widget/custom_text_field.dart';
import '../../../constants/text_font_style.dart';
import '../../../constants/validation.dart';
import '../../../gen/assets.gen.dart';
import '../../../helpers/ui_helpers.dart';
import '../../../networks/api_acess.dart';
import '../../../provider/reset_password_provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthCustomAppBar(titleText: 'Reset Password'),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SafeArea(
          child: Form(
            autovalidateMode: AutovalidateMode.onUnfocus,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Password",
                  style: TextFontStyle.headLine16c141414InterW400,
                ),
                UIHelper.verticalSpace(4.h),
                Consumer<ResetPasswordProvider>(
                  builder: (context, provider, child) {
                    return CustomTextField(
                      obscureText: !provider.passwordVisible,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(
                        onPressed: provider.togglePasswordVisibility,
                        icon: SvgPicture.asset(
                          provider.passwordVisible
                              ? Assets.icons.eyeOn
                              : Assets.icons.eyeOff,
                          width: 20.w,
                          height: 20.h,
                          fit: BoxFit.none,
                          colorFilter: ColorFilter.mode(
                            Color(0xFFA1A1AA),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                      controller: _passwordController,
                      hintText: "Password",
                      validator: passwordValidation,
                    );
                  },
                ),

                UIHelper.verticalSpace(16.h),

                Text(
                  "Confirm Password",
                  style: TextFontStyle.headLine16c141414InterW400,
                ),
                UIHelper.verticalSpace(4.h),

                Consumer<ResetPasswordProvider>(
                  builder: (context, provider, child) {
                    return CustomTextField(
                      obscureText: !provider.confirmPasswordVisible,
                      keyboardType: TextInputType.visiblePassword,
                      controller: _confirmPasswordController,
                      hintText: "Confirm Password",
                      validator: (value) => confirmPasswordValidation(
                        value,
                        _passwordController.text,
                      ),
                      suffixIcon: IconButton(
                        onPressed: provider.toggleConfirmPasswordVisibility,
                        icon: SvgPicture.asset(
                          colorFilter: ColorFilter.mode(
                            Color(0xFFA1A1AA),
                            BlendMode.srcIn,
                          ),
                          provider.confirmPasswordVisible
                              ? Assets.icons.eyeOn
                              : Assets.icons.eyeOff,
                          width: 20.w,
                          height: 20.h,
                          fit: BoxFit.none,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: CustomButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              resetPasswordRxObj
                  .resetPasswordRx(
                    email: widget.email,
                    password: _passwordController.text,
                    otp: widget.otp,
                  )
                  .waitingForFuture()
                  .then((success) {
                    ToastUtil.showShortToast("Password Reset Successfully");
                    if (success) {
                      NavigationService.navigateToReplacement(
                        Routes.signinScreen,
                      );
                    }
                  });
            }
          },
          text: "Reset Password",
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:timer_button/timer_button.dart';

import '../../../common_widget/auth_custom_app_bar.dart';
import '../../../common_widget/custom_button.dart';
import '../../../constants/text_font_style.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/loading_helper.dart';
import '../../../helpers/navigation_service.dart';
import '../../../helpers/toast.dart';
import '../../../helpers/ui_helpers.dart';
import '../../../networks/api_acess.dart';
import '../../../provider/otp_provider.dart';
import '../widgets/pinput_theme.dart';

class OtpVerifiedScreen extends StatefulWidget {
  final String email;
  const OtpVerifiedScreen({super.key, required this.email});

  @override
  State<OtpVerifiedScreen> createState() => _OtpVerifiedScreenState();
}

class _OtpVerifiedScreenState extends State<OtpVerifiedScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthCustomAppBar(titleText: 'Otp Verificaton'),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter the code we sent to your email address ${widget.email}",
                style: TextFontStyle.headLine16c141414InterW400.copyWith(
                  color: Color(0xFF888888),
                ),
              ),

              UIHelper.verticalSpace(32.h),

              /// Pinput Form Field
              Consumer<OtpProvider>(
                builder: (context, provider, child) {
                  return Align(
                    alignment: Alignment.center,
                    child: Form(
                      key: _formKey,
                      child: Pinput(
                        controller: _otpController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                        forceErrorState: provider.isOtpInvalid,
                        isCursorAnimationEnabled: true,
                        keyboardType: TextInputType.number,
                        pinAnimationType: PinAnimationType.rotation,
                        cursor: Container(
                          width: 2.w,
                          height: 20.h,
                          color: Colors.red,
                        ),
                        animationCurve: Curves.fastEaseInToSlowEaseOut,
                        textInputAction: TextInputAction.done,
                        length: 6,
                        defaultPinTheme: PinputThemeWidget.defaultTheme(
                          context,
                        ),
                        focusedPinTheme: PinputThemeWidget.focusedTheme(
                          context,
                        ),
                        submittedPinTheme: provider.isOtpInvalid
                            ? PinputThemeWidget.errorTheme(context)
                            : PinputThemeWidget.submittedTheme(context),
                        errorPinTheme: PinputThemeWidget.errorTheme(context),
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onChanged: (pin) {
                          provider.validateOtp(pin);
                        },
                        onCompleted: (pin) {
                          provider.updateOtp(pin);
                        },
                        validator: (pin) {
                          if (pin == null || pin.isEmpty) {
                            provider.setOtpInvalid(true);
                            return 'Please enter the OTP';
                          } else if (pin.length != 6) {
                            provider.setOtpInvalid(true);
                            return 'The OTP must be 6 digits.';
                          }
                          provider.setOtpInvalid(false);
                          return null;
                        },
                      ),
                    ),
                  );
                },
              ),

              UIHelper.verticalSpace(24.h),

              Align(
                alignment: Alignment.center,
                child: Text(
                  "Didn't receive a code?",
                  style: TextFontStyle.headLine16c141414InterW400.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w100,
                    color: Color(0xFF78a1cc),
                  ),
                ),
              ),
              UIHelper.verticalSpace(16.h),

              Align(
                alignment: Alignment.center,
                child: TimerButton.builder(
                  builder: (context, timeLeft) {
                    return Text(
                      timeLeft == 0
                          ? "Send code again"
                          : "Send code again in ${timeLeft}s",
                      style: TextFontStyle.headLine16c141414InterW400.copyWith(
                        decoration: TextDecoration.underline,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w100,
                        color: Color(0xFF78a1cc),
                      ),
                    );
                  },
                  onPressed: () {
                    forgetPasswordRxObj
                        .forgetPasswordRx(email: widget.email)
                        .waitingForFuture()
                        .then((success) {
                          if (success) {
                            ToastUtil.showShortToast(
                              "Otp sent successfully. Please check your email.",
                            );
                          }
                        });
                  },
                  timeOutInSeconds: 30,
                ),
              ),

              UIHelper.verticalSpaceMediumLarge,
            ],
          ),
        ),
      ),

      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: CustomButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              otpVerifyRxObj
                  .otpVerifyApi(
                    email: widget.email,
                    otp: context.read<OtpProvider>().enteredOtp,
                  )
                  .waitingForFuture()
                  .then((success) {
                    if (success) {
                      NavigationService.navigateToWithArgs(
                        Routes.resetPasswordScreen,
                        {
                          "otp": context.read<OtpProvider>().enteredOtp,
                          "email": widget.email,
                        },
                      );
                    }
                    ToastUtil.showShortToast("Otp Verified successfully");
                  });
            }
          },
          text: "Verify",
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

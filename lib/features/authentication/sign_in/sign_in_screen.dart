import 'dart:developer';
import 'dart:io';

import 'package:artneidich_app/common_widget/custom_text_field.dart';
import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:artneidich_app/helpers/loading_helper.dart';
import 'package:artneidich_app/helpers/ui_helpers.dart';
import 'package:artneidich_app/provider/role_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../common_widget/auth_custom_app_bar.dart';
import '../../../common_widget/custom_button.dart';
import '../../../constants/validation.dart';
import '../../../gen/assets.gen.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/navigation_service.dart';
import '../../../networks/api_acess.dart';
import '../../../provider/signup_provider.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _email.dispose();
    _password.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthCustomAppBar(
        titleText: 'Sign In',
        automaticallyImplyLeading: false,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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

              // Password
              UIHelper.verticalSpace(16.h),
              Text("Password", style: TextFontStyle.headLine16c141414InterW400),
              UIHelper.verticalSpace(4.h),

              Consumer<SignupProvider>(
                builder: (context, provider, child) {
                  return CustomTextField(
                    //  prefixIcon: Assets.icons.vector3,
                    obscureText: !provider.passwordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      onPressed: provider.togglePasswordVisibility,
                      icon: SvgPicture.asset(
                        provider.passwordVisible
                            ? Assets.icons.eyeOff
                            : Assets.icons.eyeOn,
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
                    controller: _password,
                    filled: true,
                    //  validator: passwordValidation,
                  );
                },
              ),

              // Forget password
              UIHelper.verticalSpace(16.h),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    NavigationService.navigateTo(Routes.forgetPasswordScreen);
                  },
                  child: Text(
                    "Forget Password?",
                    style: TextFontStyle.headLine16c141414InterW400,
                  ),
                ),
              ),

              UIHelper.verticalSpace(24.h),
              CustomButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  // Get device info once
                  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                  String deviceName = "";
                  String deviceId = "";

                  if (Platform.isAndroid) {
                    final androidInfo = await deviceInfo.androidInfo;
                    deviceName =
                        androidInfo.model; // Changed from 'name' to 'model'
                    deviceId = androidInfo.id;
                  } else if (Platform.isIOS) {
                    final iosInfo = await deviceInfo.iosInfo;
                    deviceName = iosInfo.name;
                    deviceId = iosInfo.identifierForVendor ?? "";
                  }

                  // Get FCM token
                  String? token = await FirebaseMessaging.instance.getToken();

                  if (token == null) {
                    // Handle case where FCM token couldn't be retrieved
                    log("Failed to get FCM token");
                    return;
                  }

                  log("FCM Token ======================== $token");
                  log(
                    "platform ======================== ${Platform.isIOS ? "ios" : "android"}",
                  );
                  log("deviceName ======================== $deviceName");
                  log("deviceId ======================== $deviceId");

                  // Attempt login
                  final loginSuccess = await signinRxObj
                      .signinRx(
                        email: _email.text,
                        password: _password.text,
                        deviceId: deviceId,
                        token: token,
                        platform: Platform.isAndroid ? "android" : "ios",
                      )
                      .waitingForFuture();

                  if (loginSuccess) {
                    // Save role AFTER successful login
                    context.read<RoleProvider>().setUserRole(
                      signinRxObj.role ?? "",
                    );

                    // Navigate to home
                    NavigationService.navigateToReplacement(
                      Routes.navigationScreen,
                    );
                  }
                },

                text: "Sign In",
              ),

              UIHelper.verticalSpace(24.h),

              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextFontStyle.headLine16c141414InterW400,
                    children: [
                      TextSpan(text: "Create an account? "),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            NavigationService.navigateToReplacement(
                              Routes.signUpScreen,
                            );
                          },
                        text: "Signup",
                        style: TextFontStyle.headLine16c141414InterW400
                            .copyWith(color: Colors.blue),
                      ),
                    ],
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

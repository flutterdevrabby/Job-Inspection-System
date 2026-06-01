import 'package:artneidich_app/common_widget/header_widget.dart';
import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:artneidich_app/helpers/loading_helper.dart';
import 'package:artneidich_app/helpers/navigation_service.dart';
import 'package:artneidich_app/helpers/toast.dart';
import 'package:artneidich_app/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../common_widget/custom_button.dart';
import '../../constants/text_font_style.dart';
import '../../helpers/ui_helpers.dart';
import '../../networks/api_acess.dart';
import 'widgets/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    _firstNameController.text = provider.data?.firstName ?? "";
    _lastNameController.text = provider.data?.lastName ?? "";
    _emailontroller.text = provider.data?.email ?? "";
  }

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(
              title: "Settings",
              icon: Assets.icons.profile.path,
              subtitle: "Profile",
            ),

            UIHelper.verticalSpace(20.h),

            ProfileWidget(
              firstName: _firstNameController,
              lastName: _lastNameController,
              email: _emailontroller,
              formkey: _formKey,
            ),

            UIHelper.verticalSpace(20.h),

            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      updateProfileRxObj
                          .updateProfileRx(
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                          )
                          .waitingForFuture()
                          .then((success) {
                            if (success) {
                              context.read<ProfileProvider>().fetchProfile();
                              ToastUtil.showShortToast(
                                "Profile updated successfully",
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
                        "Save",
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
    );
  }
}

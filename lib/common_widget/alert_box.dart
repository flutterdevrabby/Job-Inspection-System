import 'package:artneidich_app/common_widget/custom_button.dart';
import 'package:artneidich_app/helpers/all_routes.dart';
import 'package:artneidich_app/helpers/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_constants.dart';
import '../constants/text_font_style.dart';
import '../helpers/navigation_service.dart';
import '../helpers/toast.dart';
import '../helpers/ui_helpers.dart';
import '../networks/api_acess.dart';
import 'custom_text_field.dart';

class DeleteAlertBox extends StatefulWidget {
  const DeleteAlertBox({super.key});

  @override
  State<DeleteAlertBox> createState() => _DeleteAlertBoxState();
}

class _DeleteAlertBoxState extends State<DeleteAlertBox> {
  bool _isConfirmed = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController txtController = TextEditingController();

  @override
  void dispose() {
    txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _isConfirmed
              ? Align(
                  alignment: .centerEnd,
                  child: IconButton.filled(
                    icon: Icon(Icons.cancel),
                    color: Colors.red,
                    iconSize: 30.sp,
                    onPressed: () {
                      NavigationService.goBack;
                    },
                  ),
                )
              : SizedBox.shrink(),

          Icon(Icons.delete, size: 100.sp, color: Colors.red),

          UIHelper.verticalSpace(10.h),

          Text(
            "This action will permanently delete your account. "
            "All associated data, including your profile, content, and settings, "
            "will be permanently removed and cannot be recovered.",
            textAlign: TextAlign.justify,
            style: TextFontStyle.headLine14c323539InterW400.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          UIHelper.verticalSpace(20.h),

          if (_isConfirmed) ...[
            Text(
              "To confirm, type 'delete' in the box below.",
              textAlign: TextAlign.justify,
              style: TextFontStyle.headLine14c323539InterW400.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            UIHelper.verticalSpace(10.h),

            CustomTextField(
              controller: txtController,
              hintText: "Type deletion",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please type 'delete' to confirm";
                }
                return null;
              },
            ),

            UIHelper.verticalSpace(10.h),

            CustomButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (txtController.text.trim() == "delete") {
                    NavigationService.goBack;

                    bool success = await deleteUserAccountRxObj
                        .deleteUserAccountRx(
                          id: appData.read(kKeyUserID) ?? "",
                        );
                    if (success) {
                      NavigationService.navigateToUntilReplacement(
                        Routes.signUpScreen,
                      );
                      ToastUtil.showShortToast(
                        "Account has been permanently deleted successfully",
                      );
                      appData.write(kKeyAccessToken, '');
                      appData.write(kKeyIsLoggedIn, false);
                    }
                  } else {
                    ToastUtil.showErrorLongToast("Type 'deletion' correctly");
                  }
                }
              },
              color: Colors.white,
              borderSide: const BorderSide(color: Colors.red, width: 2),
              style: TextFontStyle.headLine14c323539InterW400.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              text: "Confirm delete account",
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      setState(() {
                        _isConfirmed = true;
                      });
                    },
                    text: "YES",
                    color: Colors.red,
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      NavigationService.goBack; // FIXED
                    },
                    text: "NO",
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

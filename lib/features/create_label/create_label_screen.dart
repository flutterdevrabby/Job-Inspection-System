import 'package:artneidich_app/common_widget/custom_button.dart';
import 'package:artneidich_app/common_widget/custom_text_field.dart';
import 'package:artneidich_app/common_widget/header_widget.dart';
import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:artneidich_app/helpers/loading_helper.dart';
import 'package:artneidich_app/helpers/navigation_service.dart';
import 'package:artneidich_app/helpers/toast.dart';
import 'package:artneidich_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/text_font_style.dart';
import '../../networks/api_acess.dart';
import '../../provider/label_provider.dart';

class CreateLabelScreen extends StatefulWidget {
  const CreateLabelScreen({super.key});

  @override
  State<CreateLabelScreen> createState() => _CreateLabelScreenState();
}

class _CreateLabelScreenState extends State<CreateLabelScreen> {
  final _formKey = GlobalKey<FormState>();

  final labelnameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    labelnameController.dispose();
  }

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
              HeaderWidget(
                title: "Labels",
                icon: Assets.icons.label.path,
                subtitle: "Create New Label",
              ),

              UIHelper.verticalSpace(30.h),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),

                child: Text(
                  "Label Name",
                  style: TextFontStyle.headLine14c323539InterW400,
                ),
              ),
              UIHelper.verticalSpace(10.h),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
                child: CustomTextField(
                  maxLines: 10,
                  controller: labelnameController,
                  style: TextFontStyle.headLine14c323539InterW400.copyWith(
                    color: Color(0xFF71717A),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Label is required";
                    }
                    return null;
                  },
                ),
              ),

              UIHelper.verticalSpace(20.h),

              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
                  child: CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        createLabelRxObj
                            .createLabelRx(label: labelnameController.text)
                            .waitingForFuture()
                            .then((success) {
                              if (success) {

                                // ignore: use_build_context_synchronously
                                Provider.of<LabelProvider>(context, listen: false).refreshAllLabel();
                                //  context.read<LabelProvider>().fetchAllLabel();
                                NavigationService.goBack;

                                ToastUtil.showShortToast(
                                  "Label Created Successfully",
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
                          "Create",
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

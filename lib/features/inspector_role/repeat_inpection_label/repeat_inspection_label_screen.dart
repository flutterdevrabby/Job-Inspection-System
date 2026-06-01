import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common_widget/custom_button.dart';
import '../../../common_widget/custom_drop_down_widget.dart';
import '../../../common_widget/header_widget.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../helpers/ui_helpers.dart';

class RepeatInspectionLabelScreen extends StatefulWidget {
  const RepeatInspectionLabelScreen({super.key});

  @override
  State<RepeatInspectionLabelScreen> createState() =>
      _RepeatInspectionLabelScreenState();
}

class _RepeatInspectionLabelScreenState
    extends State<RepeatInspectionLabelScreen> {
  //Inspector List
  int selectedInspectorLabel = -1;

  List<String> inspectorLabelList = ["BedRoom 1", "BedRoom 2", "BedRoom 3"];

  String labelName = "";

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header AppBar Widget
              HeaderWidget(
                title: "Jobs",
                icon: Assets.images.jobsIcon.path,
                subtitle: 'Select Label',
              ),

              UIHelper.verticalSpace(20.h),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
                child: Text(
                  "Label",
                  style: TextFontStyle.headLine14c323539InterW400,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
                child: CustomDropDownWidget(
                  hintText: "Select Label",
                  items: inspectorLabelList,
                  value: selectedInspectorLabel == -1
                      ? null
                      : selectedInspectorLabel,

                  validator: (value) {
                    if (value == null) return "Label is required";
                    return null;
                  },

                  onChanged: (value) {
                    setState(() {
                      selectedInspectorLabel = value!;

                      labelName = inspectorLabelList[selectedInspectorLabel];
                    });
                  },
                ),
              ),
              UIHelper.verticalSpace(20.h),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
                child: Align(
                  alignment: Alignment.topRight,
                  child: CustomButton(
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      //   // Added Level
                      //   context.read<InspectorProgressProvider>().addLabel(
                      //     labelName,
                      //   );
                      //   NavigationService.navigateToWithArgs(
                      //     Routes.inspectionProgressScreen,
                      //     {"labelName": labelName},
                      //   );
                      //   log(labelName);
                      // }
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

import 'package:artneidich_app/common_widget/custom_button.dart';
import 'package:artneidich_app/common_widget/custom_text_field.dart';
import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:artneidich_app/helpers/navigation_service.dart';
import 'package:artneidich_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../helpers/toast.dart';
import '../../../provider/inspection_provider.dart';

class ShowSearchBottomWidget extends StatelessWidget {
  final TextEditingController search;

  final InspectionProvider provider;
  const ShowSearchBottomWidget({
    super.key,
    required this.search,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      height: 0.28.sh,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),

      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Search Inspection ID, Address Or Submission Date",
              style: TextFontStyle.headLine16c141414InterW400.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 13.sp,
                color: Color(0xFF000000),
              ),
            ),

            UIHelper.verticalSpace(10.h),

            CustomTextField(
              controller: search,
              hintText: "Search Jobs",

              prefixIcon: Assets.icons.frame,

              suffixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: IconButton(
                  onPressed: () {
                    search.clear();
                  },
                  icon: Icon(Icons.close, color: Colors.black),
                ),
              ),
            ),

            UIHelper.verticalSpace(30.h),

            CustomButton(
              onPressed: () {
                if (search.text.isEmpty) {
                  ToastUtil.showShortToast("Please type your job name");
                } else {
                  provider.onSearchChanged(search.text);

                  NavigationService.goBack;
                  search.clear();
                }
                //       NavigationService.goBack;
              },
              text: "Apply",
            ),
          ],
        ),
      ),
    );
  }
}

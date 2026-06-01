import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common_widget/create_job.dart';
import '../../../common_widget/custom_button.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/navigation_service.dart';
import '../../../helpers/toast.dart';
import '../../../helpers/ui_helpers.dart';
import '../../../provider/inspection_provider.dart';
import '../models/drop_down_model.dart';
import 'search_bottom_widget.dart';

class BottomSheetWidget extends StatelessWidget {
  final InspectionProvider provider;
  final TextEditingController searchController;
  const BottomSheetWidget({
    super.key,
    required this.provider,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: Row(
        children: [
          // LEFT ICONS
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 32.w),
                child: InkWell(
                  onTap: () async {
                    await showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        ),
                      ),
                      context: context,
                      builder: (_) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            //      vertical: 8.h,
                          ),
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
                                UIHelper.verticalSpace(12.h),
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      10.r,
                                    ),
                                    child: Container(
                                      width: 100.w,
                                      height: 4.h,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),

                                UIHelper.verticalSpace(12.h),
                                Text(
                                  "Filter",
                                  style: TextFontStyle
                                      .headLine16c141414InterW400
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13.sp,
                                        color: Color(0xFF000000),
                                      ),
                                ),

                                UIHelper.verticalSpace(10.h),

                                DropdownButtonFormField2<DropDownModel>(
                                  isExpanded: true,
                                  hint: Text(
                                    "Selected Filter",
                                    style: TextFontStyle
                                        .headLine16c888888InterBold
                                        .copyWith(fontWeight: FontWeight.w400),
                                  ),
                                  items: provider.filterList
                                      .map(
                                        (item) =>
                                            DropdownMenuItem<DropDownModel>(
                                              value: item,
                                              child: Text(
                                                item.title ?? "",
                                                style: TextFontStyle
                                                    .headLine16c888888InterBold,
                                              ),
                                            ),
                                      )
                                      .toList(),
                                  value:
                                      provider.selectedFilterTitle, // ← Fixed
                                  validator: (value) {
                                    if (value == null) {
                                      return "Filter is required";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    if (value != null) {
                                      provider.filterToggle(value);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFEFEFF1),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: BorderSide.none,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1.5.w,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),

                                UIHelper.verticalSpace(30.h),

                                CustomButton(
                                  onPressed: () {
                                    if (provider.selectedFilterTitle == null) {
                                      ToastUtil.showShortToast(
                                        "Please select an Item",
                                      );
                                    } else {
                                      NavigationService.goBack;
                                    }
                                  },
                                  text: "Apply",
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Image.asset(
                    Assets.icons.filter.path,
                    width: 32.w,
                    height: 32.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              UIHelper.horizontalSpace(16.w),

              // Search
              InkWell(
                onTap: () async {
                  await showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                      ),
                    ),
                    context: context,
                    builder: (_) {
                      return ShowSearchBottomWidget(
                        search: searchController,
                        provider: provider,
                      );
                    },
                  );
                },
                child: Image.asset(
                  Assets.icons.search.path,
                  width: 32.w,
                  height: 32.h,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),

          Spacer(),

          // RIGHT FAB
          CreateJob(
            heroTag: "inpection_screen_tag",
            title: 'Create New Job',
            onpressed: () {
              NavigationService.navigateTo(Routes.createJobScreen);
            },
          ),
        ],
      ),
    );
  }
}

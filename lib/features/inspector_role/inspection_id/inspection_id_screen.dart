import 'package:artneidich_app/common_widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../common_widget/custom_button.dart';
import '../../../../common_widget/header_widget.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../helpers/ui_helpers.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/navigation_service.dart';
import '../../../provider/inspection_id_provider.dart';

class InspectionIdScreen extends StatefulWidget {
  const InspectionIdScreen({super.key});

  @override
  State<InspectionIdScreen> createState() => _InspectionIdScreenState();
}

class _InspectionIdScreenState extends State<InspectionIdScreen> {
  final orderId = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    orderId.dispose();
  }

  String selectedorderID = "";

  String selectedFHACASEID = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header AppBar Widget
            HeaderWidget(
              title: "Jobs",
              icon: Assets.images.jobsIcon.path,
              subtitle: 'Inspections',
            ),

            UIHelper.verticalSpace(20.h),

            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
              child: Text(
                "Address", //Inspection ID
                style: TextFontStyle.headLine14c323539InterW400,
              ),
            ),
            UIHelper.verticalSpace(8.h),

            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
              child: Form(
                key: _formKey,
                child: CustomTextField(
                  controller: orderId,
                  hintText: "Please Select an Address ",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select an Address";
                    }
                    return null;
                  },

                  readOnly: true,
                  hintStyle: TextFontStyle.headLine14c323539InterW400.copyWith(
                    color: Color(0xFF71717A).withValues(alpha: 0.7),
                  ),
                  suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.black),

                  onTap: () async {
                    await showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                      context: context,
                      builder: (_) {
                        return Consumer<InspectionIdProvider>(
                          builder: (context, provider, child) {
                            return ListView.builder(
                              controller: provider.scrollController,
                              itemCount: provider.data.length + 1,
                              itemBuilder: (_, index) {
                                if (index < provider.data.length) {
                                  return GestureDetector(
                                    onTap: () {
                                      final selectedAddress =
                                          provider.data[index];

                                      provider.updateOrder(selectedAddress);

                                      // Set text to controller
                                      orderId.text =
                                          selectedAddress.orderId ?? "";

                                      // fha case

                                      selectedFHACASEID =
                                          selectedAddress.fhaCaseDetailsNo ??
                                          "";

                                      selectedorderID = selectedAddress.id
                                          .toString();

                                      bool status =
                                          selectedAddress.reportStatus ==
                                          "rejected";

                                      // status
                                      provider.updateStatus(status);

                                      // Close bottom sheet
                                      Navigator.pop(context);
                                    },
                                    child: ListTile(
                                      title: Text(
                                        provider.data[index].streetAddress ??
                                            "",
                                      ),
                                    ),
                                  );
                                }
                                //  Loading indicator at bottom
                                return provider.isLoading
                                    ? const Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: Color(0xFF2D8D7C),
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink();
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            UIHelper.verticalSpace(20.h),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
              child: Align(
                alignment: Alignment.topRight,
                child: CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      NavigationService.navigateToWithArgs(
                        Routes.inspectionCaseScreen,
                        {
                          //  bool status =
                          // item.reportStatus == "rejected";
                          "resubmitStatus": context
                              .read<InspectionIdProvider>()
                              .status,
                          "fhaCaseID": selectedFHACASEID,
                          "datum": context
                              .read<InspectionIdProvider>()
                              .selectedOrderId,
                        },
                      );
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
    );
  }
}

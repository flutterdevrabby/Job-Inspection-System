import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants/text_font_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/navigation_service.dart';
import '../../../helpers/ui_helpers.dart';
import '../../../provider/inspection_provider.dart';
import '../widgets/bottom_sheet_widget.dart';
import '../widgets/popup_filter_widget.dart';

class InspectionScreen extends StatefulWidget {
  const InspectionScreen({super.key});

  @override
  State<InspectionScreen> createState() => _InspectionScreenState();
}

class _InspectionScreenState extends State<InspectionScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InspectionProvider>().ferchAllJOBData();

      _scrollController.addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
          context.read<InspectionProvider>().ferchAllJOBData();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InspectionProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                // Top bar menu
                Container(
                  width: 1.sw,
                  height: 180.h,
                  color: Color(0xFF2D8D7C),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SafeArea(
                      child: Column(
                        spacing: 30.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Popup Filter Widget
                          PopupFilterWidget(provider: provider),

                          Row(
                            spacing: 10.w,
                            children: [
                              Image.asset(
                                Assets.images.jobsIcon.path,
                                width: 40.w,
                                height: 40.h,
                                fit: BoxFit.cover,
                              ),

                              Text(
                                "Manage Jobs",
                                style: TextFontStyle.headLine28c3D3D3DInterW700
                                    .copyWith(
                                      fontSize: 18.sp,
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// Table Data
                SizedBox(
                  height: 0.55.sh,
                  child: provider.datum.isEmpty
                      ? Center(
                          child: Text(
                            "No Job Found",
                            style: TextFontStyle.headLine16c141414InterW400,
                          ),
                        )
                      : DataTable2(
                          fixedTopRows: 0,
                          fixedLeftColumns: 0,
                          headingRowColor: WidgetStateProperty.all(
                            Color(0xFFFAF7F8),
                          ),
                          dataRowColor: WidgetStateProperty.resolveWith(
                            (states) => Colors.white,
                          ),
                          //  empty: Center(child: Text("No Data Found")),
                          border: TableBorder.all(color: Color(0xFFEFEFF1)),

                          scrollController: _scrollController,
                          columnSpacing: 20,
                          horizontalMargin: 16,
                          dataRowHeight: 56,
                          headingRowHeight: 56,
                          minWidth: 1600,
                          columns: provider.dataColumeList
                              .map(
                                (e) => DataColumn2(
                                  tooltip: e,
                                  size: ColumnSize.L,
                                  label: Text(
                                    textAlign: TextAlign.center,
                                    e,
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    style: TextFontStyle
                                        .headLine16c141414InterW400,
                                  ),
                                ),
                              )
                              .toList(),
                          rows: List.generate(
                            provider.datum.length +
                                (provider.isLoading ? 1 : 0),
                            (index) {
                              //  Loader Row
                              if (index == provider.datum.length) {
                                return DataRow2(
                                  cells: List.generate(
                                    provider.dataColumeList.length,
                                    (i) => i == 0
                                        ? DataCell(
                                            Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.r),
                                                child:
                                                    CircularProgressIndicator(
                                                      color: Color(0xFF2D8D7C),
                                                    ),
                                              ),
                                            ),
                                          )
                                        : const DataCell(SizedBox()),
                                  ),
                                );
                              }

                              final item = provider.datum[index];
                              return DataRow(
                                cells: [
                                  DataCell(Text(item.fhaCaseDetailsNo ?? "-")),
                                  DataCell(Text(item.orderId ?? "-")),
                                  DataCell(Text(item.streetAddress ?? "-")),
                                  DataCell(
                                    Text(
                                      "${item.inspector?.firstName ?? "-"} ${item.inspector?.lastName ?? "-"}",
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.dueDate != null
                                          ? DateFormat(
                                              'dd-MM-yyyy',
                                            ).format((item.dueDate!).toLocal())
                                          : '-',
                                    ),
                                  ),

                                  DataCell(
                                    Text(
                                      item.dueDate != null
                                          ? DateFormat('dd-MM-yyyy').format(
                                              (item.updatedAt!).toLocal(),
                                            )
                                          : '-',
                                    ),
                                  ),

                                  DataCell(
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 6.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: item.reportStatus == "submitted"
                                            ? Color(0xFFECFFEB)
                                            : item.reportStatus == "in_progress"
                                            ? Color(0xFFFDF3D7)
                                            : item.reportStatus == "completed"
                                            ? Color(0xFFEBECFF)
                                            : Color(0xFFFFEBEB),

                                        borderRadius: BorderRadius.circular(
                                          6.r,
                                        ),
                                      ),
                                      child: Text(
                                        item.reportStatus == "submitted"
                                            ? "Submitted"
                                            : item.reportStatus == "in_progress"
                                            ? "In Progress"
                                            : item.reportStatus == "completed"
                                            ? "Completed"
                                            : "Rejected",

                                        style: TextFontStyle
                                            .headLine14c323539InterW400
                                            .copyWith(
                                              color:
                                                  item.reportStatus ==
                                                      "submitted"
                                                  ? Color(0xFF00B21A)
                                                  : item.reportStatus ==
                                                        "in_progress"
                                                  ? Color(0xFF83750C)
                                                  : item.reportStatus ==
                                                        "completed"
                                                  ? Color(0xFF2600B2)
                                                  : Color(0xFFCA4139),
                                            ),
                                      ),
                                    ),
                                  ),

                                  DataCell(
                                    InkWell(
                                      onTap: () {
                                        NavigationService.navigateToWithArgs(
                                          Routes.jobDetailsScreen,
                                          {"id": item.id},
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(6.r),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 6.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.withValues(
                                            alpha: 0.1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            6.r,
                                          ),
                                        ),
                                        child: Row(
                                          spacing: 4.w,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "View Details",
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),

                                            Image.asset(
                                              Assets.icons.arrowRightIcon.path,
                                              width: 16.w,
                                              height: 16.h,
                                              color: Colors.blue,
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                ),

                UIHelper.verticalSpace(40.h),

                Divider(color: Color(0xFFEFEFF1), thickness: 1.5),
              ],
            ),
          ),

          // Float
          floatingActionButton: BottomSheetWidget(
            provider: provider,
            searchController: provider.searchController,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
}

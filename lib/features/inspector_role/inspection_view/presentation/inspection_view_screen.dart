import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:artneidich_app/helpers/ui_helpers.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../common_widget/create_job.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../provider/assign_inspector_provider.dart';
import '../widgets/inspection_header_widget.dart';
import '../widgets/inspection_viewsearch_bottom_widget.dart';

class InspectionViewScreen extends StatefulWidget {
  const InspectionViewScreen({super.key});

  @override
  State<InspectionViewScreen> createState() => _InspectionViewScreenState();
}

class _InspectionViewScreenState extends State<InspectionViewScreen> {
  final _searchController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AssignInspectorProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: Column(
            children: [
              // Header AppBar Widget
              InspectionHeaderWidget(title: "Assigned Inspections"),

              Consumer<AssignInspectorProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF2D8D7C),
                        ),
                      ),
                    );
                  } else if (provider.datum.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Job is not available now.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () {
                                provider.refreshData();
                              },
                              icon: Icon(Icons.refresh),
                              label: Text("Refresh"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF2D8D7C),
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await provider.refreshData();
                        },
                        child: DataTable2(
                          fixedTopRows: 0,
                          fixedLeftColumns: 0,

                          scrollController: provider.scrollController,

                          headingRowColor: WidgetStateProperty.all(
                            const Color(0xFFFAF7F8),
                          ),
                          dataRowColor: WidgetStateProperty.resolveWith(
                            (states) => Colors.white,
                          ),
                          border: TableBorder.all(
                            color: const Color(0xFFEFEFF1),
                          ),
                          columnSpacing: 20,
                          horizontalMargin: 16,
                          dataRowHeight: 56,

                          headingRowHeight: 56,
                          minWidth: 1200,
                          columns: provider.dataColumeList
                              .map(
                                (e) => DataColumn2(
                                  tooltip: e,
                                  size: ColumnSize.L,
                                  label: Text(
                                    e,
                                    textAlign: TextAlign.center,
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
                                (provider.isMoreLoading ? 1 : 0),
                            (index) {
                              // Bottom Loader Row logic
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
                                                    const CircularProgressIndicator(
                                                      strokeWidth: 2,
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
                                  DataCell(Text(item.streetAddress ?? "-")),
                                  DataCell(Text(item.developmentName ?? "-")),
                                  DataCell(
                                    Text(
                                      item.dueDate != null
                                          ? DateFormat(
                                              'MM-dd-yyyy',
                                            ).format(item.dueDate!.toLocal())
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
                                        color:
                                            item.reportStatusLabel ==
                                                "Submitted"
                                            ? const Color(0xFFECFFEB)
                                            : item.reportStatusLabel ==
                                                  "In Progress"
                                            ? const Color(0xFFFDF3D7)
                                            : item.reportStatusLabel ==
                                                  "Completed"
                                            ? const Color(0xFFEBECFF)
                                            : item.reportStatusLabel ==
                                                  "Rejected"
                                            ? const Color(0xFFFFEBEB)
                                            : Color(0xFFEAEAEA),
                                        // color:
                                        //     item.reportStatusLabel ==
                                        //         "Submitted"
                                        //     ? const Color(0xFFECFFEB)
                                        //     : item.reportStatusLabel ==
                                        //           "In Progress"
                                        //     ? const Color(0xFFFDF3D7)
                                        //     : item.reportStatusLabel ==
                                        //           "Completed"
                                        //     ? const Color(0xFFEBECFF)
                                        //     : const Color(0xFFFFEBEB),
                                        borderRadius: BorderRadius.circular(
                                          6.r,
                                        ),
                                      ),
                                      child: Text(
                                        item.reportStatusLabel == "In Progress"
                                            ? "Start"
                                            : item.reportStatusLabel ?? "",

                                        style: TextFontStyle
                                            .headLine14c323539InterW400
                                            .copyWith(
                                              color:
                                                  item.reportStatusLabel ==
                                                      "Submitted"
                                                  ? const Color(0xFF00B21A)
                                                  : item.reportStatusLabel ==
                                                        "In Progress"
                                                  ? const Color(0xFF83750C)
                                                  : item.reportStatusLabel ==
                                                        "Completed"
                                                  ? const Color(0xFF2600B2)
                                                  : item.reportStatusLabel ==
                                                        "Rejected"
                                                  ? const Color(0xFFCA4139)
                                                  : const Color(0xFF666666),
                                              // item.reportStatusLabel ==
                                              //     "Submitted"
                                              // ? const Color(0xFF00B21A)
                                              // : item.reportStatusLabel ==
                                              //       "In Progress"
                                              // ? const Color(0xFF83750C)
                                              // : item.reportStatusLabel ==
                                              //       "Completed"
                                              // ? const Color(0xFF2600B2)
                                              // : const Color(0xFFCA4139),
                                            ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    InkWell(
                                      onTap: () {
                                        if (item.reportStatusLabel ==
                                                "Submitted" ||
                                            item.reportStatusLabel ==
                                                "Completed" ||
                                            item.reportStatusLabel ==
                                                "Resubmit") {
                                          return;
                                        } else {
                                          bool status =
                                              item.reportStatus == "rejected";

                                          NavigationService.navigateToWithArgs(
                                            Routes.inspectionLabelScreen,
                                            {
                                              "datum": item,
                                              "resubmitStatus": status,
                                              "reportID": item.reportId,
                                            },
                                          );
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(6.r),
                                      child: Row(
                                        spacing: 4.w,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.reportStatusLabel == "Resubmit"
                                                ? "Resubmit Job"
                                                : "Start Inspector",
                                            style: TextStyle(
                                              color:
                                                  item.reportStatusLabel ==
                                                          "Submitted" ||
                                                      item.reportStatusLabel ==
                                                          "Completed" ||
                                                      item.reportStatusLabel ==
                                                          "Resubmit"
                                                  ? Colors.grey[300]
                                                  : item.reportStatusLabel ==
                                                        "Resubmit"
                                                  ? Color(0xFF83750C)
                                                  : const Color(0xFF0097B2),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Image.asset(
                                            Assets.icons.arrowRightIcon.path,
                                            width: 16.w,
                                            height: 16.h,
                                            color:
                                                item.reportStatusLabel ==
                                                        "Submitted" ||
                                                    item.reportStatusLabel ==
                                                        "Completed" ||
                                                    item.reportStatusLabel ==
                                                        "Resubmit"
                                                ? Colors.grey[300]
                                                : item.reportStatusLabel ==
                                                      "Resubmit"
                                                ? Color(0xFF83750C)
                                                : const Color(0xFF0097B2),
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    InkWell(
                                      onTap: () {
                                        NavigationService.navigateToWithArgs(
                                          Routes.inspectionSummaryScreen,
                                          {"datum": item},
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(6.r),
                                      child: Row(
                                        spacing: 4.w,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "View Details",
                                            style: TextStyle(
                                              color: Color(0xFFFF7F60),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Image.asset(
                                            Assets.icons.arrowRightIcon.path,
                                            width: 16.w,
                                            height: 16.h,
                                            color: const Color(0xFFFF7F60),
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),

              UIHelper.verticalSpace(20.h),

              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: InkWell(
                      onTap: () async {
                        await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          useSafeArea: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.r),
                              topRight: Radius.circular(16.r),
                            ),
                          ),
                          builder: (_) {
                            return InspectionViewShowSearchBottomWidget(
                              search: _searchController,
                              provider: provider,
                              dateController: _dateController,
                            );
                          },
                        );
                      },
                      child: Image.asset(
                        Assets.icons.search.path,
                        width: 32.w,
                        height: 32.h,
                      ),
                    ),
                  ),
                  const Spacer(),
                  CreateJob(
                    heroTag: "inpectionview_screen_tag",
                    title: 'Start Inspection',
                    onpressed: () {
                      NavigationService.navigateTo(Routes.inspectionIdScreen);
                    },
                  ),
                ],
              ),
              UIHelper.verticalSpace(30.h),
            ],
          ),
        );
      },
    );
  }
}

import 'dart:developer';

import 'package:artneidich_app/common_widget/custom_button.dart';
import 'package:artneidich_app/helpers/loading_helper.dart';
import 'package:artneidich_app/helpers/toast.dart';
import 'package:artneidich_app/helpers/ui_helpers.dart';
import 'package:artneidich_app/networks/api_acess.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../common_widget/header_widget.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/navigation_service.dart';
import '../../../provider/archive_list_provider.dart';

class ArchiveListScreen extends StatefulWidget {
  const ArchiveListScreen({super.key});

  @override
  State<ArchiveListScreen> createState() => _ArchiveListScreenState();
}

class _ArchiveListScreenState extends State<ArchiveListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ArchiveListProvider>().ferchAllJOBData();

      _scrollController.addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
          context.read<ArchiveListProvider>().ferchAllJOBData();
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ArchiveListProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(
                title: "Settings",
                icon: Assets.images.jobsIcon.path,
                subtitle: "Archive List",
              ),

              UIHelper.verticalSpace(30.h),

              /// TABLE
              ///
              Expanded(
                child: provider.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF2D8D7C),
                        ),
                      )
                    : provider.datum.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Archive Job is not available.",
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
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          await provider.refreshData();
                        },
                        child: DataTable2(
                          scrollController: _scrollController,
                          border: TableBorder.all(color: Color(0xFFEFEFF1)),
                          columnSpacing: 20,
                          horizontalMargin: 16,
                          dataRowHeight: 56,
                          headingRowHeight: 56,
                          minWidth: 1600,
                          fixedTopRows: 0,
                          fixedLeftColumns: 0,

                          headingRowColor: MaterialStateProperty.all(
                            Color(0xFFFAF7F8),
                          ),

                          dataRowColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.white,
                          ),

                          /// COLUMNS
                          columns: [
                            DataColumn2(
                              size: ColumnSize.S,
                              label: Checkbox(
                                activeColor: Color(0xFF2D8D7C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    2.r,
                                  ),
                                ),
                                value: provider.isAllSelected,
                                onChanged: (value) {
                                  provider.toggleSelectAll(value ?? false);
                                },
                              ),
                            ),

                            ...provider.dataColumeList.map(
                              (e) => DataColumn2(
                                tooltip: e,
                                size: ColumnSize.L,
                                label: Text(
                                  e,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      TextFontStyle.headLine16c141414InterW400,
                                ),
                              ),
                            ),
                          ],

                          /// ROWS
                          rows: List.generate(
                            provider.datum.length +
                                (provider.isLoading ? 1 : 0),
                            (index) {
                              /// Loader row
                              if (index == provider.datum.length) {
                                return DataRow2(
                                  cells: List.generate(
                                    provider.dataColumeList.length + 1,
                                    (i) => i == 0
                                        ? DataCell(
                                            Center(
                                              child: CircularProgressIndicator(
                                                color: Color(0xFF2D8D7C),
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
                                  DataCell(
                                    Checkbox(
                                      activeColor: Color(0xFF2D8D7C),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusGeometry.circular(2.r),
                                      ),
                                      value: provider.isChecked(
                                        (item.id ?? "").toString(),
                                      ),
                                      onChanged: (value) {
                                        provider.toggleChecked(
                                          (item.id ?? "").toString(),
                                          value ?? false,
                                        );

                                        log(
                                          "Selected: ${provider.selectedIds}",
                                        );
                                      },
                                    ),
                                  ),

                                  DataCell(
                                    Text(item.job!.fhaCaseDetailsNo ?? "-"),
                                  ),
                                  DataCell(Text(item.job!.orderId ?? "-")),
                                  DataCell(
                                    Text(item.job!.streetAddress ?? "-"),
                                  ),

                                  DataCell(
                                    Text(
                                      "${item.job?.inspector?.firstName ?? "-"} ${item.job?.inspector?.lastName ?? "-"}",
                                    ),
                                  ),

                                  DataCell(
                                    Text(
                                      item.job?.dueDate != null
                                          ? DateFormat('dd-MM-yyyy').format(
                                              item.job!.dueDate!.toLocal(),
                                            )
                                          : '-',
                                    ),
                                  ),

                                  DataCell(
                                    Text(
                                      item.job?.updatedAt != null
                                          ? DateFormat('dd-MM-yyyy').format(
                                              item.job!.updatedAt!.toLocal(),
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
                                        color:
                                            item.job!.reportStatus ==
                                                "submitted"
                                            ? Color(0xFFECFFEB)
                                            : item.job!.reportStatus ==
                                                  "in_progress"
                                            ? Color(0xFFFDF3D7)
                                            : item.job!.reportStatus ==
                                                  "completed"
                                            ? Color(0xFFEBECFF)
                                            : Color(0xFFFFEBEB),
                                        borderRadius: BorderRadius.circular(
                                          6.r,
                                        ),
                                      ),
                                      child: Text(
                                        item.job!.reportStatus ?? "-",
                                      ),
                                    ),
                                  ),

                                  DataCell(
                                    InkWell(
                                      onTap: () {
                                        NavigationService.navigateToWithArgs(
                                          Routes.jobDetailsScreen,
                                          {"id": item.job!.id!},
                                        );
                                      },
                                      child: Text(
                                        "View Details",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
              ),

              Divider(),

              UIHelper.verticalSpace(20.h),

              provider.datum.isEmpty
                  ? SizedBox.shrink()
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              onPressed: () {
                                log(
                                  "Selected IDs :--------------------------:> ${provider.selectedIds}",
                                );

                                archiveListRestoreRxObj
                                    .archiveListRestoreRx(
                                      reportIds: provider.selectedIds,
                                    )
                                    .waitingForFuture()
                                    .then((success) async {
                                      if (success) {
                                        await provider.refreshData();
                                        ToastUtil.showLongToast(
                                          "Job Restore Successfully",
                                        );
                                      }
                                      NavigationService.goBack;
                                    });
                              },
                              color: Color(0xFFF4F4F5),
                              child: Text("Restore"),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: CustomButton(
                              onPressed: () {
                                log(
                                  "Selected IDs :--------------------------:> ${provider.selectedIds}",
                                );

                                archiveListDeleteRxObj
                                    .archiveListDeleteRx(
                                      reportIds: provider.selectedIds,
                                    )
                                    .waitingForFuture()
                                    .then((success) async {
                                      if (success) {
                                        await provider.refreshData();
                                        ToastUtil.showLongToast(
                                          "Job has Permanently Delete Successfully",
                                        );
                                      }
                                      NavigationService.goBack;
                                    });
                              },
                              color: Color(0xFFC8322B),
                              child: Text(
                                "Delete",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

              UIHelper.verticalSpaceSemiLarge,
            ],
          ),
        );
      },
    );
  }
}

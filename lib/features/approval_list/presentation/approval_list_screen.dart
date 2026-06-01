import 'package:artneidich_app/common_widget/header_widget.dart';
import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constants/text_font_style.dart';
import '../../../helpers/ui_helpers.dart';
import '../../../provider/inspector_list_provider.dart';

class ApprovalListScreen extends StatefulWidget {
  const ApprovalListScreen({super.key});

  @override
  State<ApprovalListScreen> createState() => _ApprovalListScreenState();
}

class _ApprovalListScreenState extends State<ApprovalListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InspectorListProvider>().fetchInspectorListData(
        isApproved: false,
      );
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        context.read<InspectorListProvider>().fetchInspectorListData(
          isApproved: false,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(
              title: "Settings",
              icon: Assets.icons.profile.path,
              subtitle: "Approval List",
            ),

            //
            Consumer<InspectorListProvider>(
              builder: (context, provider, child) {
                ///  Center loading
                if (provider.isLoadingInitial && provider.data.isEmpty) {
                  return SizedBox(
                    height: 0.60.sh,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF2D8D7C),
                      ),
                    ),
                  );
                }

                /// 2Empty state
                if (provider.data.isEmpty) {
                  return SizedBox(
                    height: 0.60.sh,
                    child: const Center(child: Text("No Data Found")),
                  );
                }

                ///  DataTable
                return Column(
                  children: [
                    SizedBox(
                      height: 0.70.sh,
                      child: DataTable2(
                        fixedTopRows: 0,
                        fixedLeftColumns: 0,
                        scrollController: _scrollController,
                        headingRowColor: WidgetStateProperty.all(
                          const Color(0xFFFAF7F8),
                        ),
                        headingTextStyle:
                            TextFontStyle.headLine16c141414InterW400,
                        dataRowColor: WidgetStateProperty.all(Colors.white),
                        border: TableBorder.all(color: const Color(0xFFEFEFF1)),
                        columnSpacing: 20,
                        horizontalMargin: 16,
                        dataRowHeight: 56,
                        headingRowHeight: 56,
                        minWidth: 600,

                        columns: const [
                          DataColumn2(label: Text("Name"), size: ColumnSize.L),
                          DataColumn2(label: Text("Email"), size: ColumnSize.L),
                          DataColumn2(
                            label: Text("Action"),
                            size: ColumnSize.S,
                          ),
                        ],

                        rows: List.generate(provider.data.length, (index) {
                          final user = provider.data[index];

                          return DataRow2(
                            cells: [
                              DataCell(
                                Text(
                                  "${user.firstName} ${user.lastName}",
                                  style:
                                      TextFontStyle.headLine14c323539InterW400,
                                ),
                              ),
                              DataCell(
                                Text(
                                  user.email ?? "-",
                                  style:
                                      TextFontStyle.headLine14c323539InterW400,
                                ),
                              ),
                              DataCell(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  spacing: 8.w,
                                  children: [
                                    Text(
                                      "Approved",
                                      style: TextFontStyle
                                          .headLine14c323539InterW400
                                          .copyWith(color: Color(0xFF2D8D7C)),
                                    ),
                                    Image.asset(
                                      Assets.icons.frame7.path,
                                      width: 16.w,
                                      height: 16.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),

                    /// Pagination loader outside table
                    if (provider.isLoadingMore)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF2D8D7C),
                          ),
                        ),
                      ),

                    /// No more data outside table
                    if (provider.showNoMoreData)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            "No more data",
                            style: TextFontStyle.headLine14c323539InterW400
                                .copyWith(color: Colors.grey),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            UIHelper.verticalSpaceExtraLarge,
          ],
        ),
      ),
    );
  }
}

import 'package:artneidich_app/common_widget/header_widget.dart';
import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../common_widget/custom_button.dart';
import '../../../constants/text_font_style.dart';
import '../../../helpers/loading_helper.dart';
import '../../../helpers/ui_helpers.dart';
import '../../../networks/api_acess.dart';
import '../../../provider/inspector_list_provider.dart';

class InspectorListScreen extends StatefulWidget {
  const InspectorListScreen({super.key});

  @override
  State<InspectorListScreen> createState() => _InspectorListScreenState();
}

class _InspectorListScreenState extends State<InspectorListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InspectorListProvider>().fetchInspectorListData(
        isApproved: true,
      );
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        context.read<InspectorListProvider>().fetchInspectorListData(
          isApproved: true,
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
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(
              title: "Settings",
              icon: Assets.icons.profile.path,
              subtitle: "Inspector List",
            ),

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

                /// Empty state
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
                                InkWell(
                                  onTap: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return AlertDialog(
                                          title: Text(
                                            "Confirmation",
                                            style: TextFontStyle
                                                .headLine16c2D8D7CInterW700
                                                .copyWith(color: Colors.black),
                                          ),
                                          content: Text(
                                            "Are you sure you want to continue?",
                                          ),

                                          actions: [
                                            CustomButton(
                                              onPressed: () {
                                                Navigator.pop(dialogContext);
                                              },
                                              style: TextFontStyle
                                                  .headLine14c323539InterW400,

                                              text: "Cancel",
                                              color: Colors.white,
                                              borderSide: BorderSide(
                                                color: Colors.blueGrey,
                                              ),
                                            ),

                                            UIHelper.verticalSpace(10.h),
                                            CustomButton(
                                              onPressed: () {
                                                // suspendUser
                                                Navigator.pop(dialogContext);

                                                (user.isSuspended ?? false)
                                                    ? unSuspendRxObj
                                                          .unSuspendRx(
                                                            id: user.id!,
                                                          )
                                                          .waitingForFuture()
                                                          .then((success) {
                                                            if (success) {
                                                              context
                                                                  .read<
                                                                    InspectorListProvider
                                                                  >()
                                                                  .refresh(
                                                                    isApproved:
                                                                        true,
                                                                  );
                                                            }
                                                          })
                                                    : suspendRxObj
                                                          .suspendRx(
                                                            id: user.id!,
                                                          )
                                                          .waitingForFuture()
                                                          .then((success) {
                                                            if (success) {
                                                              context
                                                                  .read<
                                                                    InspectorListProvider
                                                                  >()
                                                                  .refresh(
                                                                    isApproved:
                                                                        true,
                                                                  );
                                                            }
                                                          });
                                              },
                                              color: Colors.red,
                                              text: (user.isSuspended ?? false)
                                                  ? "UnSuspend"
                                                  : "Suspend",
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    (user.isSuspended ?? false)
                                        ? "UnSuspend"
                                        : "Suspend",

                                    style: TextFontStyle
                                        .headLine14c323539InterW400
                                        .copyWith(color: Color(0xFFC8322B)),
                                  ),
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

import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:artneidich_app/helpers/all_routes.dart';
import 'package:artneidich_app/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/data_model.dart';

class DataTableWidget extends StatefulWidget {
  const DataTableWidget({super.key});

  @override
  State<DataTableWidget> createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  final List<String> setTableName = [
    "FHA Case Details",
    "Order ID",
    "Address",
    "Inspector",
    "Date Due",
    "Date Submitted",
    "Status",
    "Action",
  ];
  final List<TableRowData> tableData = [
    TableRowData(
      caseDetails: "Case-001",
      orderId: "ORD-123",
      address: "New York",
      inspector: "Alex",
      dateDue: "10 Jan 2026",
      dateSubmitted: "08 Jan 2026",
      status: "Completed",
    ),
    TableRowData(
      caseDetails: "Case-002",
      orderId: "ORD-456",
      address: "California",
      inspector: "John",
      dateDue: "12 Jan 2026",
      dateSubmitted: "11 Jan 2026",
      status: "Pending",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: TableBorder.all(color: Color(0xFFEFEFF1)),
        headingRowColor: WidgetStateColor.resolveWith((_) {
          return Color(0xFFFAF7F8);
        }),
        headingTextStyle: TextFontStyle.headLine16c141414InterW400,
        columns: setTableName
            .map((element) => DataColumn(label: Text(element)))
            .toList(),
        rows: tableData.map((item) {
          return DataRow(
            cells: [
              DataCell(Text(item.caseDetails)),
              DataCell(Text(item.orderId)),
              DataCell(Text(item.address)),
              DataCell(Text(item.inspector)),
              DataCell(Text(item.dateDue)),
              DataCell(Text(item.dateSubmitted)),
              DataCell(
                Text(
                  item.status,
                  style: TextStyle(
                    color: item.status == "Completed"
                        ? Colors.green
                        : Colors.orange,
                  ),
                ),
              ),

              /// ACTION CELL
              DataCell(
                InkWell(
                  onTap: () {
                    NavigationService.navigateTo(Routes.jobDetailsScreen);
                  },
                  borderRadius: BorderRadius.circular(6.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(
                      spacing: 4.w,
                      mainAxisAlignment: MainAxisAlignment.start,
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
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

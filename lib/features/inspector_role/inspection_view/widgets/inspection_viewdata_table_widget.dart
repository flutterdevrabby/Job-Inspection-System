// import 'package:artneidich_app/constants/text_font_style.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../../gen/assets.gen.dart';
// import '../../../../helpers/all_routes.dart';
// import '../../../../helpers/navigation_service.dart';
// import '../models/inspection_viewdata_model.dart';

// class InspectionViewDataTableWidget extends StatefulWidget {
//   const InspectionViewDataTableWidget({super.key});

//   @override
//   State<InspectionViewDataTableWidget> createState() =>
//       _InspectionViewDataTableWidgetState();
// }

// class _InspectionViewDataTableWidgetState
//     extends State<InspectionViewDataTableWidget> {
//   final List<String> setTableName = [
//     "FHA Case Details",
//     "Address",
//     "Assignee",
//     "Date Due",
//     "Date Created",
//     "Action",
//     "",
//   ];
//   final List<InspectionViewTableRowData> tableData = [
//     InspectionViewTableRowData(
//       caseDetails: "Case-001",
//       address: "New York",
//       assigned: "Fajla Rabby",
//       dateDue: "29 Jan 2026",
//       dateCreate: "22 Jan 2026",

//       action: 'Start Inspection',
//       detatils: '08 Jan 2026',
//     ),
//     InspectionViewTableRowData(
//       caseDetails: "Case-001",
//       address: "New York",
//       assigned: "Fajla Rabby",
//       dateDue: "29 Jan 2026",
//       dateCreate: "22 Jan 2026",

//       action: 'Start Inspection',
//       detatils: '08 Jan 2026',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: DataTable(
//         border: TableBorder.all(color: Color(0xFFEFEFF1)),
//         headingRowColor: WidgetStateColor.resolveWith((_) {
//           return Color(0xFFFAF7F8);
//         }),
//         headingTextStyle: TextFontStyle.headLine16c141414InterW400,
//         columns: setTableName
//             .map((element) => DataColumn(label: Text(element)))
//             .toList(),
//         rows: tableData.map((item) {
//           return DataRow(
//             cells: [
//               DataCell(Text(item.caseDetails)),
//               DataCell(Text(item.address)),
//               DataCell(Text(item.assigned)),
//               DataCell(Text(item.dateCreate)),
//               DataCell(Text(item.dateDue)),

//               // Actions
//               DataCell(
//                 InkWell(
//                   onTap: () {
//                     NavigationService.navigateTo(Routes.inspectionIdScreen);
//                   },
//                   borderRadius: BorderRadius.circular(6.r),
//                   child: Row(
//                     spacing: 4.w,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         item.action,
//                         style: TextStyle(
//                           color: Color(0xFF0097B2),
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),

//                       Image.asset(
//                         Assets.icons.arrowRightIcon.path,
//                         width: 16.w,
//                         height: 16.h,
//                         fit: BoxFit.cover,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // ACTION CELL
//               DataCell(
//                 InkWell(
//                   onTap: () {
//                     NavigationService.navigateTo(
//                       Routes.inspectionSummaryScreen,
//                     );
//                   },
//                   borderRadius: BorderRadius.circular(6.r),
//                   child: Container(
//                     padding: EdgeInsets.symmetric(
//                       // horizontal: 12.w,
//                       vertical: 6.h,
//                     ),

//                     child: Row(
//                       spacing: 4.w,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Details",
//                           style: TextStyle(
//                             color: Color(0xFFFF7F60),
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),

//                         Image.asset(
//                           Assets.icons.arrowRightIcon.path,
//                           width: 16.w,
//                           height: 16.h,
//                           color: Color(0xFFFF7F60),
//                           fit: BoxFit.cover,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

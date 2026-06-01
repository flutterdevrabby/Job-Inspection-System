// import 'package:artneidich_app/constants/text_font_style.dart';
// import 'package:artneidich_app/gen/assets.gen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../model/approval_list_model.dart';

// class ApprovalListDataTableWidget extends StatefulWidget {
//   const ApprovalListDataTableWidget({super.key});

//   @override
//   State<ApprovalListDataTableWidget> createState() =>
//       _ApprovalListDataTableWidgetState();
// }

// class _ApprovalListDataTableWidgetState
//     extends State<ApprovalListDataTableWidget> {
//   final List<ApprovalTableRowData> tableData = [
//     ApprovalTableRowData(
//       name: "Jon",
//       email: "jon@gmail.com",
//       action: 'Approve',
//     ),
//     ApprovalTableRowData(
//       name: "Jon Doe",
//       email: "doe@gmail.com",
//       action: 'Approve',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: DataTable(
//         border: TableBorder.all(color: Color(0xFFEFEFF1)),
//         dataRowMinHeight: 36,

//         headingRowColor: WidgetStateColor.resolveWith((_) {
//           return Color(0xFFFAF7F8);
//         }),
//         headingTextStyle: TextFontStyle.headLine16c141414InterW400,

//         columns: [
//           DataColumn(
//             label: Text(
//               "Name",
//               style: TextFontStyle.headLine14c323539InterW400,
//             ),
//           ),
//           DataColumn(
//             label: Text(
//               "Email",
//               style: TextFontStyle.headLine14c323539InterW400,
//             ),
//           ),
//           DataColumn(
//             label: Text(
//               "Action",
//               style: TextFontStyle.headLine14c323539InterW400,
//             ),
//           ),
//         ],

//         rows: tableData.map((item) {
//           return DataRow(
//             cells: [
//               DataCell(
//                 Text(
//                   item.name,
//                   style: TextFontStyle.headLine14c323539InterW400,
//                 ),
//               ),
//               DataCell(
//                 Text(
//                   item.email,
//                   style: TextFontStyle.headLine14c323539InterW400,
//                 ),
//               ),
//               DataCell(
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   spacing: 8.w,
//                   children: [
//                     Text(
//                       item.action,
//                       style: TextFontStyle.headLine14c323539InterW400.copyWith(
//                         color: Color(0xFF2D8D7C),
//                       ),
//                     ),
//                     Image.asset(
//                       Assets.icons.frame7.path,
//                       width: 16.w,
//                       height: 16.h,
//                       fit: BoxFit.cover,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

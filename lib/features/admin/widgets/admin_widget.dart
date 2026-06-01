// import 'package:artneidich_app/constants/text_font_style.dart';
// import 'package:flutter/material.dart';

// import '../model/table_model.dart';

// class AdminDataTableWidget extends StatefulWidget {
//   const AdminDataTableWidget({super.key});

//   @override
//   State<AdminDataTableWidget> createState() => _AdminDataTableWidgetState();
// }

// class _AdminDataTableWidgetState extends State<AdminDataTableWidget> {
//   final List<AdminTableRowData> tableData = [
//     AdminTableRowData(name: "Jon", email: "jon@gmail.com"),
//     AdminTableRowData(name: "Jon Doe", email: "doe@gmail.com"),
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

//         columns: const [
//           DataColumn(label: Text("Name")),
//           DataColumn(label: Text("Email")),
//         ],

//         rows: tableData.map((item) {
//           return DataRow(
//             cells: [DataCell(Text(item.name)), DataCell(Text(item.email))],
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

// import 'package:data_table_2/data_table_2.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../provider/inspection_provider.dart';

// class DataTableScreen extends StatefulWidget {
//   const DataTableScreen({super.key});

//   @override
//   State<DataTableScreen> createState() => _DataTableScreenState();
// }

// class _DataTableScreenState extends State<DataTableScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<InspectionProvider>(
//       builder: (context, provider, child) {
//         //  Initial loading (center)
//         if (provider.datum.isEmpty && provider.isLoading) {
//           return const Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(color: Color(0xFF2D8D7C)),
//             ),
//           );
//         }

//         return Scaffold(
//           appBar: AppBar(
//             title: const Text("Jobs"),
//             backgroundColor: Colors.white,
//             elevation: 0,
//           ),
//           body: DataTable2(
//             scrollController: provider.scrollController,
//          //   minWidth: 400,
//             columns: provider.dataColumeList
//                 .map((e) => DataColumn(label: Text(e)))
//                 .toList(),
//             rows: List.generate(
//               provider.datum.length +
//                   (provider.isLoading || !provider.hasMore ? 1 : 0),
//               (index) {
//                 // Bottom Loader
//                 if (index == provider.datum.length &&
//                     provider.isLoading &&
//                     provider.hasMore) {
//                   return _bottomLoader(provider);
//                 }

//                 //  No more data
//                 if (index == provider.datum.length && !provider.hasMore) {
//                   return _noMoreData(provider);
//                 }

//                 final item = provider.datum[index];
//                 return DataRow(
//                   cells: [
//                     DataCell(Text(item.feeStatus ?? "-")),
//                     DataCell(Text(item.developmentName ?? "-")),
//                   ],
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // Loader Row
//   DataRow _bottomLoader(InspectionProvider provider) {
//     return DataRow(
//       cells: List.generate(
//         provider.dataColumeList.length,
//         (i) => i == 0
//             ? const DataCell(
//                 Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(8),
//                     child: CircularProgressIndicator(color: Color(0xFF2D8D7C)),
//                   ),
//                 ),
//               )
//             : const DataCell(SizedBox()),
//       ),
//     );
//   }

//   // No more data Row
//   DataRow _noMoreData(InspectionProvider provider) {
//     return DataRow(
//       cells: List.generate(
//         provider.dataColumeList.length,
//         (i) => i == 0
//             ? const DataCell(
//                 Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(12),
//                     child: Text(
//                       "No more data available",
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             : const DataCell(SizedBox()),
//       ),
//     );
//   }
// }
















import 'package:flutter/material.dart';

class PdfScreen extends StatelessWidget {
  const PdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            //  final provider = context.read<PdfProvider>();

            // await Printing.layoutPdf(
            //   onLayout: (format) async => provider.generateSamplePdf(
            //     images: [],
            //     fhaFormId: '92051',
            //     inspectionType: 'JHUD-FHA 92051 Compliance - FINAL',
            //     inspectionDate: '09/06/2025',
            //     subjectProperty: '15024 Baikal Drive, Dallas, TX, 75253',
            //     caseNumber: '# 511-3746727',
            //   ),
            // );
          },
          child: const Text('Generate PDF'),
        ),
      ),
    );
  }
}

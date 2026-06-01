import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:artneidich_app/gen/colors.gen.dart';
import 'package:artneidich_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../../../constants/text_font_style.dart';
import '../../../provider/pdf_provider.dart';
import '../data/rx_get_report/model/job_report_response.dart';

class ReportWidget extends StatelessWidget {
  final ReportData reportData;

  const ReportWidget({super.key, required this.reportData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            "Report",
            style: TextFontStyle.headLine16c141414InterW400.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 18.sp,
            ),
          ),
        ),

        UIHelper.verticalSpace(20.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Download",
                style: TextFontStyle.headLine16c141414InterW400.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),

              Text(
                ":",
                style: TextFontStyle.headLine16c141414InterW400.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),

              InkWell(
                // Handle download action
                onTap: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.allPrimaryColor,
                      ),
                    ),
                  );

                  try {
                    final provider = context.read<PdfProvider>();

                    final pdfBytes = await provider.generateSamplePdf(
                      images: reportData.images ?? [],
                      inspectionType: reportData.job?.formType ?? "",
                      inspectionDate: DateFormat(
                        'MM-dd-yyyy',
                      ).format(reportData.createdAt ?? DateTime.now()),
                      subjectProperty: reportData.job?.streetAddress ?? "",
                      fhaCaseID: reportData.job?.fhaCaseDetailsNo ?? "",
                    );

                    final fileName =
                        "${reportData.job?.streetAddress ?? 'Inspection_report'}.pdf";

                    Navigator.pop(context); // close loader

                    await Printing.sharePdf(
                      bytes: pdfBytes,
                      filename: fileName,
                    );
                  } catch (e) {
                    Navigator.pop(context); // close loader

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Failed: $e")));
                  }
                },
                child: Image.asset(
                  Assets.icons.download.path,
                  width: 20.w,
                  height: 20.h,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

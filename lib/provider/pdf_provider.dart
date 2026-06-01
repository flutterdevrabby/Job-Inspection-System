import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:artneidich_app/helpers/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../features/job_details/data/rx_get_report/model/job_report_response.dart';

//import '../features/job_details/data/rx_get_report/model/job_report_response.dart';

class PdfProvider extends ChangeNotifier {
  final Dio _dio = Dio();

  //   function
  Future<pw.ImageProvider?> fetchNetworkImage(String url) async {
    try {
      final response = await _dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes, // Important!
          followRedirects: true,
        ),
      );

      if (response.statusCode == 200) {
        final Uint8List imageBytes = Uint8List.fromList(response.data);
        return pw.MemoryImage(imageBytes);
      }
      return null;
    } catch (e) {
      ToastUtil.showShortToast('Error loading image from $url: $e');
      return null;
    }
  }

  Future<Uint8List> generateSamplePdf({
    required String inspectionType,
    required String inspectionDate,
    required String subjectProperty,
    required String fhaCaseID,
    required List<ImageElement> images,
  }) async {
    final pdf = pw.Document();

    // Logo and footer images
    final imageBytes = await rootBundle.load(Assets.icons.logo.path);
    final image = pw.MemoryImage(imageBytes.buffer.asUint8List());

    // Footer Image
    final footerImageLeftBytes = await rootBundle.load(
      Assets.icons.attachmentLeft.path,
    );
    final footerImageRightBytes = await rootBundle.load(
      Assets.icons.attachmentRight.path,
    );

    final footerLeftImage = pw.MemoryImage(
      footerImageLeftBytes.buffer.asUint8List(),
    );
    final footerRightImage = pw.MemoryImage(
      footerImageRightBytes.buffer.asUint8List(),
    );

    final List<Map<String, dynamic>> processedImages = [];

    for (var dataImage in images) {
      final label = dataImage.imageLabel ?? "";
      final List<pw.ImageProvider?> loadedImages = [];

      if (dataImage.image != null) {
        final img = dataImage.image;

        if (img!.url != null && img.url!.isNotEmpty) {
          final netImg = await fetchNetworkImage(img.url!);
          loadedImages.add(netImg);
        }
      }

      processedImages.add({'label': label, 'images': loadedImages});
    }

    // final List<Map<String, dynamic>> processedImages = [];

    // for (var dataImage in images) {
    //   final label = dataImage.imageLabel ?? "";
    //   final List<pw.ImageProvider?> loadedImages = [];

    //   if (dataImage.image != null ) {
    //     for (var img in dataImage) {
    //       if (img.url != null && img.url!.isNotEmpty) {
    //         // fetchNetworkImage Use it
    //         final netImg = await fetchNetworkImage(img.url!);
    //         loadedImages.add(netImg);
    //       }
    //     }
    //   }

    //   processedImages.add({'label': label, 'images': loadedImages});
    // }

    pdf.addPage(
      pw.MultiPage(
        header: (context) {
          return pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Image(image, width: 100, height: 50, fit: pw.BoxFit.contain),

              pw.Text(
                "www.fhainspection.com / www.artneidich.com",
                style: pw.TextStyle(
                  fontSize: 10,
                  color: PdfColor.fromHex('#474747'),
                ),
              ),
              pw.Text(
                "A Division of Lone Star Building Inspection, Inc.",
                style: pw.TextStyle(
                  fontSize: 12,
                  color: PdfColor.fromHex('#474747'),
                ),
              ),

              pw.Text(
                "Attachment to HUD/FHA Form 92051",
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColor.fromHex('#474747'),
                ),
              ),
              pw.SizedBox(height: 10),

              pw.Divider(color: PdfColor.fromHex('#f1f1f3')),
              pw.SizedBox(height: 10),

              // data
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 2,
                    child: pw.RichText(
                      text: pw.TextSpan(
                        children: [
                          pw.TextSpan(
                            text: "Date of Inspection: ",
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.TextSpan(
                            text: inspectionDate,
                            style: pw.TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),

                  pw.RichText(
                    text: pw.TextSpan(
                      children: [
                        pw.TextSpan(
                          text: "FHA Case # ",
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.TextSpan(
                          text: fhaCaseID,
                          style: pw.TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              pw.SizedBox(height: 10),

              // Type is inspection
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.RichText(
                    text: pw.TextSpan(
                      children: [
                        pw.TextSpan(
                          text: "Type of Inspection: ",
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.TextSpan(
                          text: inspectionType,
                          style: pw.TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              pw.SizedBox(height: 10),

              //Subject property
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.RichText(
                    text: pw.TextSpan(
                      children: [
                        pw.TextSpan(
                          text: "Subject Property: ",
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.TextSpan(
                          text: subjectProperty,
                          style: pw.TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              pw.SizedBox(height: 20),
            ],
          );
        },
        margin: pw.EdgeInsets.fromLTRB(36, 10, 36, 10),
        pageFormat: PdfPageFormat.a4,
        footer: (context) {
          return pw.Column(
            children: [
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Image(
                    footerRightImage,
                    width: 76,
                    height: 50,
                    fit: pw.BoxFit.contain,
                  ),
                  pw.SizedBox(width: 16),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text(
                          "All Utilities On At Time of Inspection, Unless Otherwise Noted",
                          style: pw.TextStyle(
                            fontSize: 8,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('#353333'),
                          ),
                        ),
                        pw.Text(
                          "T.R.E.C Lic. # 10546  |  TSBPE Lic. # I-3836 Texas Code Enforcement Officer Lic. # 7055",
                          style: pw.TextStyle(
                            fontSize: 8,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('#000000'),
                          ),
                        ),
                        pw.Text(
                          "Certified ICC Professionals  |  Residential Combination Inspector",
                          style: pw.TextStyle(
                            fontSize: 8,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('#000000'),
                          ),
                        ),
                        pw.SizedBox(height: 20),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Text(
                              '${context.pageNumber} | ',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromHex('#000000'),
                              ),
                            ),
                            pw.Text(
                              'Page',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromHex('#7f7f7f'),
                              ),
                            ),
                            // pw.Text(
                            //   'Page ${context.pageNumber} of ${context.pagesCount}',
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 16),
                  pw.Image(
                    footerLeftImage,
                    width: 76,
                    height: 50,
                    fit: pw.BoxFit.contain,
                  ),
                ],
              ),
            ],
          );
        },

        build: (pw.Context context) {
          final chunks = <List<Map<String, dynamic>>>[];

          for (int i = 0; i < processedImages.length; i += 2) {
            chunks.add(
              processedImages.sublist(
                i,
                i + 2 > processedImages.length ? processedImages.length : i + 2,
              ),
            );
          }

          return chunks.map((pair) {
            return pw.Column(
              children: pair.map((data) {
                final label = data['label'] as String;
                final imageList = data['images'] as List<pw.ImageProvider?>;

                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      label,
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 10),

                    if (imageList.isNotEmpty && imageList.first != null)
                      pw.Center(
                        child: pw.Image(
                          imageList.first!,
                          height: 200,

                          fit: pw.BoxFit.contain,
                        ),
                      )
                    else
                      pw.Center(child: pw.Text('No image')),

                    pw.SizedBox(height: 20),
                  ],
                );
              }).toList(),
            );
          }).toList();
        },
      ),
    );

    return pdf.save();
  }
}


        // build: (pw.Context context) => [
        //   pw.ListView.builder(
        //     itemCount: processedImages.length,
        //     itemBuilder: (_, index) {
        //       final data = processedImages[index];
        //       final label = data['label'] as String;
        //       final imageList = data['images'] as List<pw.ImageProvider?>;

        //       return pw.Column(
        //         crossAxisAlignment: pw.CrossAxisAlignment.start,
        //         children: [
        //           pw.Text(
        //             label,
        //             style: pw.TextStyle(
        //               fontSize: 16,
        //               fontWeight: pw.FontWeight.bold,
        //             ),
        //           ),
        //           pw.SizedBox(height: 10),

        //           if (imageList.isNotEmpty && imageList.first != null)
        //             pw.Center(
        //               child: pw.Image(
        //                 imageList.first!,
        //                 height: 220,
        //                 fit: pw.BoxFit.contain,
        //               ),
        //             )
        //           else
        //             pw.Center(child: pw.Text('No image available')),

        //           pw.SizedBox(height: 16),
        //         ],
        //       );

        //       // return pw.Column(
        //       //   crossAxisAlignment: pw.CrossAxisAlignment.start,
        //       //   children: [
        //       //     pw.Text(
        //       //       label,
        //       //       style: pw.TextStyle(
        //       //         fontSize: 16,
        //       //         fontWeight: pw.FontWeight.bold,
        //       //       ),
        //       //     ),
        //       //     pw.SizedBox(height: 10),

        //       //     // Images in 2 columns
        //       //     if (imageList.isNotEmpty)
        //       //       ...List.generate((imageList.length / 2).ceil(), (rowIndex) {
        //       //         final firstIndex = rowIndex * 2;
        //       //         final secondIndex = firstIndex + 1;

        //       //         return pw.Padding(
        //       //           padding: pw.EdgeInsets.only(bottom: 16),
        //       //           child: pw.Row(
        //       //             children: [
        //       //               pw.Expanded(
        //       //                 flex: 1,
        //       //                 child: imageList[firstIndex] != null
        //       //                     ? pw.Image(
        //       //                         imageList[firstIndex]!,
        //       //                         height: 200,
        //       //                         fit: pw.BoxFit.fitWidth,
        //       //                       )
        //       //                     : pw.Container(
        //       //                         height: 200,
        //       //                         alignment: pw.Alignment.center,
        //       //                         decoration: pw.BoxDecoration(
        //       //                           border: pw.Border.all(
        //       //                             color: PdfColors.grey300,
        //       //                           ),
        //       //                         ),
        //       //                         child: pw.Text('Image not available'),
        //       //                       ),
        //       //               ),
        //       //               pw.SizedBox(width: 16),
        //       //               pw.Expanded(
        //       //                 flex: 1,
        //       //                 child: secondIndex < imageList.length
        //       //                     ? (imageList[secondIndex] != null
        //       //                           ? pw.Image(
        //       //                               imageList[secondIndex]!,
        //       //                               height: 200,
        //       //                               fit: pw.BoxFit.fitWidth,
        //       //                             )
        //       //                           : pw.Container(
        //       //                               height: 200,
        //       //                               alignment: pw.Alignment.center,
        //       //                               decoration: pw.BoxDecoration(
        //       //                                 border: pw.Border.all(
        //       //                                   color: PdfColors.grey300,
        //       //                                 ),
        //       //                               ),
        //       //                               child: pw.Text(
        //       //                                 'Image not available',
        //       //                               ),
        //       //                             ))
        //       //                     : pw.Container(),
        //       //               ),
        //       //             ],
        //       //           ),
        //       //         );
        //       //       })
        //       //     else
        //       //       pw.Text('No images available'),

        //       //     pw.SizedBox(height: 16),
        //       //   ],
        //       // );
        //     },
        //   ),
        // ],

// my raw Code:
// import 'package:artneidich_app/gen/assets.gen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// import '../features/job_details/data/rx_get_report/model/job_report_response.dart';

// class PdfProvider extends ChangeNotifier {
//   // Future<pw.ImageProvider> imagePath() async {
//   //   final netImage = await networkImage('https://www.nfet.net/nfet.jpg');

//   //   return netImage;
//   // }

//   Future<Uint8List> generateSamplePdf({
//     required String fhaFormId,
//     required String inspectionType,
//     required String inspectionDate,
//     required String subjectProperty,
//     required String caseNumber,
//     required List<DataImage> images,
//   }) async {
//     final pdf = pw.Document();

//     // Logo Image
//     final imageBytes = await rootBundle.load(Assets.icons.logo.path);
//     final image = pw.MemoryImage(imageBytes.buffer.asUint8List());

//     // footer image
//     final footerImageBytes = await rootBundle.load(
//       Assets.icons.attachment.path,
//     );
//     final footerImage = pw.MemoryImage(footerImageBytes.buffer.asUint8List());

//     // Images
//     final imageBytes1 = await rootBundle.load(Assets.images.image1.path);
//     final image1 = pw.MemoryImage(imageBytes1.buffer.asUint8List());

//     final imageBytes2 = await rootBundle.load(Assets.images.image2.path);
//     final image2 = pw.MemoryImage(imageBytes2.buffer.asUint8List());

//     pdf.addPage(
//       pw.MultiPage(
//         header: (context) {
//           return pw.Column(
//             mainAxisSize: pw.MainAxisSize.min,
//             crossAxisAlignment: pw.CrossAxisAlignment.center,
//             mainAxisAlignment: pw.MainAxisAlignment.center,
//             children: [
//               // Logo Image
//               pw.Image(image, width: 100, height: 50, fit: pw.BoxFit.contain),

//               pw.Text(
//                 "A Div. of Lone Star Building Inspection, Inc.",
//                 style: pw.TextStyle(
//                   fontSize: 8,
//                   color: PdfColor.fromHex('#474747'),
//                 ),
//               ),

//               pw.Text(
//                 "Inspection Report",
//                 style: pw.TextStyle(
//                   fontSize: 20,
//                   fontWeight: pw.FontWeight.bold,
//                   color: PdfColor.fromHex('#2D8D7C'),
//                 ),
//               ),

//               pw.SizedBox(height: 5),

//               pw.Text(
//                 "Attachment to FHA form # $fhaFormId",
//                 style: pw.TextStyle(
//                   fontSize: 13,
//                   color: PdfColor.fromHex('#474747'),
//                 ),
//               ),

//               pw.SizedBox(height: 30),

//               /// Header Details
//               ///
//               pw.Row(
//                 children: [
//                   pw.Expanded(
//                     flex: 2,
//                     child: pw.RichText(
//                       text: pw.TextSpan(
//                         children: [
//                           pw.TextSpan(
//                             text: "Type of Inspection: ",
//                             style: pw.TextStyle(
//                               fontSize: 12,
//                               fontWeight: pw.FontWeight.bold,
//                             ),
//                           ),
//                           pw.TextSpan(
//                             text: inspectionType,
//                             style: pw.TextStyle(fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   pw.Expanded(
//                     flex: 1,
//                     child: pw.RichText(
//                       text: pw.TextSpan(
//                         children: [
//                           pw.TextSpan(
//                             text: "Date of Inspection: ",
//                             style: pw.TextStyle(
//                               fontSize: 12,
//                               fontWeight: pw.FontWeight.bold,
//                             ),
//                           ),
//                           pw.TextSpan(
//                             text: inspectionDate,
//                             style: pw.TextStyle(fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               pw.SizedBox(height: 10),

//               /// Header Details => 2
//               pw.Row(
//                 children: [
//                   pw.Expanded(
//                     flex: 2,
//                     child: pw.RichText(
//                       text: pw.TextSpan(
//                         children: [
//                           pw.TextSpan(
//                             text: "Subject Property: ",
//                             style: pw.TextStyle(
//                               fontSize: 12,
//                               fontWeight: pw.FontWeight.bold,
//                             ),
//                           ),
//                           pw.TextSpan(
//                             text: subjectProperty,
//                             style: pw.TextStyle(fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   pw.Expanded(
//                     flex: 1,
//                     child: pw.RichText(
//                       text: pw.TextSpan(
//                         children: [
//                           pw.TextSpan(
//                             text: "Case: ",
//                             style: pw.TextStyle(
//                               fontSize: 12,
//                               fontWeight: pw.FontWeight.bold,
//                             ),
//                           ),
//                           pw.TextSpan(
//                             text: caseNumber,
//                             style: pw.TextStyle(fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               pw.SizedBox(height: 20),
//             ],
//           );
//         },

//         margin: pw.EdgeInsets.fromLTRB(36, 10, 36, 10),
//         pageFormat: PdfPageFormat.a4,
//         footer: (context) {
//           return pw.Row(
//             mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//             crossAxisAlignment: pw.CrossAxisAlignment.start,

//             children: [
//               // footer left image
//               pw.Image(
//                 footerImage,
//                 width: 76,
//                 height: 50,
//                 fit: pw.BoxFit.contain,
//               ),

//               pw.SizedBox(width: 30),

//               // footer center text
//               pw.Expanded(
//                 child: pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.center,
//                   mainAxisAlignment: pw.MainAxisAlignment.center,

//                   children: [
//                     pw.Text(
//                       "All utilities are on and tested unless otherwise noted",
//                       style: pw.TextStyle(
//                         fontSize: 12,
//                         color: PdfColor.fromHex('#353333'),
//                       ),
//                     ),
//                     pw.Text(
//                       "TREC Lic. # 10546 | TSBPE Lic. # I-3836 | Code Enforcement Lic. # 7055 | HUD-FHA Fee Reg.# D683 & 203K - D0931",
//                       style: pw.TextStyle(
//                         fontSize: 12,
//                         color: PdfColor.fromHex('#000000'),
//                       ),
//                     ),

//                     pw.SizedBox(height: 20),
//                     // Page count
//                     pw.Text(
//                       'Page ${context.pageNumber} of ${context.pagesCount}',
//                     ),
//                   ],
//                 ),
//               ),

//               pw.SizedBox(width: 30),
//               // footer right image
//               pw.Image(
//                 footerImage,
//                 width: 76,
//                 height: 50,
//                 fit: pw.BoxFit.contain,
//               ),
//             ],
//           );
//         },
//         build: (pw.Context context) => [
//           pw.ListView.builder(
//             itemCount: images.length,
//             itemBuilder: (_, index) {
//               final datum = images[index];

//               return pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text(
//                     datum.imageLabel ?? "",
//                     style: pw.TextStyle(
//                       fontSize: 16,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                   ),

//                   pw.SizedBox(height: 10),

//                   pw.Row(
//                     children: [
//                       // Image 1
//                       pw.Expanded(
//                         flex: 1,
//                         child: pw.Image(
//                           image1,
//                           height: 200,
//                           fit: pw.BoxFit.fitWidth,
//                         ),
//                       ),

//                       pw.SizedBox(width: 16),

//                       pw.Expanded(
//                         flex: 1,
//                         child: pw.Image(
//                           image2,
//                           height: 200,
//                           fit: pw.BoxFit.fitWidth,
//                         ),
//                       ),
//                     ],
//                   ),

//                   pw.SizedBox(height: 16),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//     );

//     return pdf.save(); // THIS IS REQUIRED
//   }
// }
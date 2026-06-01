import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../../../../../provider/inspector_progress_provider.dart';

final class InspectionResubmitJobApi {
  static final InspectionResubmitJobApi _singleton = InspectionResubmitJobApi._internal();
  InspectionResubmitJobApi._internal();
  static InspectionResubmitJobApi get instance => _singleton;

  Future<Map> inspectionResubmitJobApi({
    required String reportID,
    required InspectorProgressProvider provider,
    required String noteToAdmin,
  }) async {
    try {
      FormData formData = FormData();

      /// job
     // formData.fields.add(MapEntry("job", id));

      // noteAdmin
      formData.fields.add(MapEntry("noteForAdmin", noteToAdmin));

      /// 1) images JSON (text) - শুধু non-null image count করবে
      final List<Map<String, dynamic>> imagesJson = [];

      for (final label in provider.inspectorList) {
        // Count how many non-null images exist
        int imageCount = label.images!.where((img) => img != null).length;

        imagesJson.add({
          "imageLabel": label.labelID,
          "images": List.generate(imageCount, (_) => {}),
        });
      }

      formData.fields.add(MapEntry("images", jsonEncode(imagesJson)));

      /// 2) images files - শুধু non-null images add করবে
      for (final label in provider.inspectorList) {
        for (final img in label.images!) {
          if (img != null) {
            // শুধু non-null images
            formData.files.add(
              MapEntry(
                "images",
                await MultipartFile.fromFile(
                  img.path,
                  filename: img.path.split('/').last,
                ),
              ),
            );
          }
        }
      }

      final Response response = await patchHttp(
        Endpoints.resubmitJobInspector(id: reportID),
        formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(json.encode(response.data));

        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}

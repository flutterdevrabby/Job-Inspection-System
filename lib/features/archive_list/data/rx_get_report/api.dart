import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../../networks/dio/dio.dart';
import '../../../../../../../networks/endpoints.dart';
import '../../../../../../../networks/exception_handler/data_source.dart';
import '../model/archive_response.dart';

final class ArchiveListApi {
  static final ArchiveListApi _singleton = ArchiveListApi._internal();
  ArchiveListApi._internal();

  static ArchiveListApi get instance => _singleton;

  Future<ArchiveReportResponse> archiveListApi({
    required int page,
    required int limit,
  }) async {
    try {
      Response response = await getHttp(
        Endpoints.getArchiveReport(page: page, limit: limit),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        ArchiveReportResponse data = ArchiveReportResponse.fromRawJson(
          json.encode(response.data),
        );
        return data;
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      rethrow;
    }
  }
}

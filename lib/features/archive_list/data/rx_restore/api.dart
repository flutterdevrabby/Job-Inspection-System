import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../../networks/dio/dio.dart';
import '../../../../../../../networks/endpoints.dart';
import '../../../../../../../networks/exception_handler/data_source.dart';

final class ArchiveListRestoreApi {
  static final ArchiveListRestoreApi _singleton =
      ArchiveListRestoreApi._internal();
  ArchiveListRestoreApi._internal();

  static ArchiveListRestoreApi get instance => _singleton;

  Future<Map> archiveListRestoreApi({required List<String> reportIds}) async {
    try {
      Map data = {"reportIds": reportIds};
      Response response = await postHttp(
        Endpoints.restoreArchiveReport(),
        data,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(json.encode(response.data));
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

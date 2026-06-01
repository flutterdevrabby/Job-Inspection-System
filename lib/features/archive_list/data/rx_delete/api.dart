import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../../networks/dio/dio.dart';
import '../../../../../../../networks/endpoints.dart';
import '../../../../../../../networks/exception_handler/data_source.dart';

final class ArchiveListDeleteApi {
  static final ArchiveListDeleteApi _singleton =
      ArchiveListDeleteApi._internal();
  ArchiveListDeleteApi._internal();

  static ArchiveListDeleteApi get instance => _singleton;

  Future<Map> archiveListDeleteApi({required List<String> reportIds}) async {
    try {
      Map data = {"reportIds": reportIds};
      Response response = await deleteHttp(
        Endpoints.deleteArchiveReport(),
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

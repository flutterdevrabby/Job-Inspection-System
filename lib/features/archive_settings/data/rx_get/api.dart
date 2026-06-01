import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
import '../model/archive_setting_response.dart';

final class ArchiveSettingFetchApi {
  static final ArchiveSettingFetchApi _singleton =
      ArchiveSettingFetchApi._internal();
  ArchiveSettingFetchApi._internal();

  static ArchiveSettingFetchApi get instance => _singleton;

  Future<ArchiveSettingFetchResponse> archiveSettingFetchApi() async {
    try {
      Response response = await getHttp(Endpoints.archiveSettingFetch());
      if (response.statusCode == 200 || response.statusCode == 201) {
        ArchiveSettingFetchResponse data =
            ArchiveSettingFetchResponse.fromRawJson(json.encode(response.data));
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

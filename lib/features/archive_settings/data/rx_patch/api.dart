import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class ArchiveSettingUpdateApi {
  static final ArchiveSettingUpdateApi _singleton =
      ArchiveSettingUpdateApi._internal();
  ArchiveSettingUpdateApi._internal();

  static ArchiveSettingUpdateApi get instance => _singleton;

  Future<Map> archiveSettingUpdateApi({required int autoArchiveDays}) async {
    try {
      Map data = {"autoArchiveDays": autoArchiveDays};

      Response response = await putHttp(
        Endpoints.archiveSettingUpdate(),
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

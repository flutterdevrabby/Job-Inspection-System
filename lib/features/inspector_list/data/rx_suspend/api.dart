import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class SuspendApi {
  static final SuspendApi _singleton = SuspendApi._internal();
  SuspendApi._internal();

  static SuspendApi get instance => _singleton;

  Future<Map> suspendApi({required String id}) async {
    try {
      Response response = await patchHttp(Endpoints.suspend(id: id));
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

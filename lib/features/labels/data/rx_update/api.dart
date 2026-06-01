import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class UpdateLabelApi {
  static final UpdateLabelApi _singleton = UpdateLabelApi._internal();
  UpdateLabelApi._internal();

  static UpdateLabelApi get instance => _singleton;

  Future<Map> updateLabelApi({required String label, required String id,
  }) async {
    try {
      Map data = {"label": label};

      Response response = await putHttp(Endpoints.updateLabel(id: id), data);
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

import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class CreateLabelApi {
  static final CreateLabelApi _singleton = CreateLabelApi._internal();
  CreateLabelApi._internal();

  static CreateLabelApi get instance => _singleton;

  Future<Map> createLabelApi({required String label}) async {
    try {
      Map data = {"label": label};

      Response response = await postHttp(Endpoints.createLabel(), data);
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

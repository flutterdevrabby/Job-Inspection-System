import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class UpdateProfileApi {
  static final UpdateProfileApi _singleton = UpdateProfileApi._internal();
  UpdateProfileApi._internal();

  static UpdateProfileApi get instance => _singleton;

  Future<Map> updateProfileApi({
    required String firstName,
    required String lastName,
  }) async {
    try {
      Map data = {"firstName": firstName, "lastName": lastName};

      Response response = await putHttp(Endpoints.updateProfiles(), data);
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

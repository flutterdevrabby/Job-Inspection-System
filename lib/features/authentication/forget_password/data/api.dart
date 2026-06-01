import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class ForgetPasswordApi {
  static final ForgetPasswordApi _singleton = ForgetPasswordApi._internal();
  ForgetPasswordApi._internal();

  static ForgetPasswordApi get instance => _singleton;

  Future<Map> forgetPasswordApi({required String email}) async {
    try {
      Map data = {"email": email, "mobileRequest": true};

      Response response = await postHttp(Endpoints.forgetPassword(), data);
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

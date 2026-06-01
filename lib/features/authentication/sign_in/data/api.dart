import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class SigninApi {
  static final SigninApi _singleton = SigninApi._internal();
  SigninApi._internal();

  static SigninApi get instance => _singleton;

  Future<Map> signupApi({
    required String email,
    required String password,
    required String deviceId,
    required String token,
    required String platform,
  }) async {
    try {
      Map data = {
        "email": email,
        "password": password,
        "deviceId": deviceId,
        "platform": platform,
        "token": token,
      };

      Response response = await postHttp(Endpoints.signin(), data);
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

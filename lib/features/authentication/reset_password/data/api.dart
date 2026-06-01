import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class ResetPasswordApi {
  static final ResetPasswordApi _singleton = ResetPasswordApi._internal();
  ResetPasswordApi._internal();

  static ResetPasswordApi get instance => _singleton;

  Future<Map> resetPasswordApi({
    required String email,
    required String password,
    required String otp,
  }) async {
    try {
      Map data = {"email": email, "newPassword": password, "otp": otp};

      // log("EMail $email === password : $password === otp : $otp");
      // log("Data $data");

      Response response = await postHttp(Endpoints.resetPassword(), data);
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

import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class OtpVerifyApi {
  static final OtpVerifyApi _singleton = OtpVerifyApi._internal();
  OtpVerifyApi._internal();

  static OtpVerifyApi get instance => _singleton;

  Future<Map> otpVerifyApi({required String email, required String otp}) async {
    try {
      Map data = {"email": email, "otp": otp};

      Response response = await postHttp(Endpoints.otpVerify(), data);
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

import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class RegistrationTokenApi {
  static final RegistrationTokenApi _singleton =
      RegistrationTokenApi._internal();
  RegistrationTokenApi._internal();

  static RegistrationTokenApi get instance => _singleton;

  Future<Map> registrationTokenApi({
    required String token,
    required String platform,
    required String deviceName,
    required String deviceId,
  }) async {
    try {
      Map data = {
        "token": token,
        "platform": platform,
        "deviceName": deviceName, // optional
        "deviceId": deviceId,
      };

      Response response = await postHttp(Endpoints.registrationToken(), data);
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

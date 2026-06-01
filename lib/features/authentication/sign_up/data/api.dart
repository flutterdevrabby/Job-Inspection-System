import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class SignupApi {
  static final SignupApi _singleton = SignupApi._internal();
  SignupApi._internal();

  static SignupApi get instance => _singleton;

  Future<Map> signupApi({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required int role,
  }) async {
    try {
      Map data = {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "role": role,
      };

      Response response = await postHttp(Endpoints.signUp(), data);
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

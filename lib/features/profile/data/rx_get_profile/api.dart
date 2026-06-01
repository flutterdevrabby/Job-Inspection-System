import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
import 'model/profile_response_model.dart';

final class ProfileApi {
  static final ProfileApi _singleton = ProfileApi._internal();
  ProfileApi._internal();

  static ProfileApi get instance => _singleton;

  Future<ProfileResponse> profileApi() async {
    try {
      Response response = await getHttp(Endpoints.getProfiles());
      if (response.statusCode == 200 || response.statusCode == 201) {
        ProfileResponse data = ProfileResponse.fromRawJson(
          json.encode(response.data),
        );
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

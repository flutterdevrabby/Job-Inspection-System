import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
import 'model/all_user_response.dart';

final class AllUserApi {
  static final AllUserApi _singleton = AllUserApi._internal();
  AllUserApi._internal();

  static AllUserApi get instance => _singleton;

  Future<AllUserResponse> allUserApi({
    int? page,
    int? limit,
    String? search,
    int? role,
    bool? isSuspended,
    bool? isApproved,
  }) async {
    try {
      Response response = await getHttp(
        Endpoints.getAllUser(
          isApproved: isApproved,
          isSuspended: isSuspended,
          limit: limit,
          page: page,
          role: role,
          search: search,
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        AllUserResponse data = AllUserResponse.fromRawJson(
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

import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../../networks/dio/dio.dart';
import '../../../../../../../networks/endpoints.dart';
import '../../../../../../../networks/exception_handler/data_source.dart';
import 'model/admin_overview_response.dart';

final class AdminOverviewApi {
  static final AdminOverviewApi _singleton = AdminOverviewApi._internal();
  AdminOverviewApi._internal();

  static AdminOverviewApi get instance => _singleton;

  Future<AdminOverviewResponse> adminOverviewApi() async {
    try {
      Response response = await getHttp(Endpoints.adminOverVIew());
      if (response.statusCode == 200 || response.statusCode == 201) {
        AdminOverviewResponse data = AdminOverviewResponse.fromRawJson(
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

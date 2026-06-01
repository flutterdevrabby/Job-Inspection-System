import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
import '../model/all_job_response.dart';

final class AllJobApi {
  static final AllJobApi _singleton = AllJobApi._internal();
  AllJobApi._internal();

  static AllJobApi get instance => _singleton;

  Future<AllJobResponse> allJobApi({
    int? page,
    int? limit,
    String? search,
    String? status,
    String? dateType,
    String? customDate,
  }) async {
    try {
      Response response = await getHttp(
        Endpoints.getAllJob(
          limit: limit,
          page: page,
          status: status,
          search: search,
          dateType: dateType,
          customDate: customDate,
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        AllJobResponse data = AllJobResponse.fromRawJson(
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

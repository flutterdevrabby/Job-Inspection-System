import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
import 'model/summary_response.dart';

final class SummaryApi {
  static final SummaryApi _singleton = SummaryApi._internal();
  SummaryApi._internal();

  static SummaryApi get instance => _singleton;

  Future<SummaryResponse> summaryApi({required String id}) async {
    try {
      Response response = await getHttp(Endpoints.getJob(id: id));
      if (response.statusCode == 200 || response.statusCode == 201) {
        SummaryResponse data = SummaryResponse.fromRawJson(
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

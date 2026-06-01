import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
import 'model/inspection_response.dart';

final class InspectionApi {
  static final InspectionApi _singleton = InspectionApi._internal();
  InspectionApi._internal();

  static InspectionApi get instance => _singleton;

  Future<InspectionResponse> inspectionApi({
    int? page,
    int? limit,
    String? search,
    String? dueDateFrom,
    String? dueDateTo,
  }) async {
    try {
      Response response = await getHttp(
        Endpoints.getMyJob(
          limit: limit,
          page: page,
          search: search,
          dueDateFrom: dueDateFrom,
          dueDateTo: dueDateTo,
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        InspectionResponse data = InspectionResponse.fromRawJson(
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

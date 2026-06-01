import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../../networks/dio/dio.dart';
import '../../../../../../../networks/endpoints.dart';
import '../../../../../../../networks/exception_handler/data_source.dart';
import 'model/inspector_overview_response.dart';

final class InspectorOverviewApi {
  static final InspectorOverviewApi _singleton =
      InspectorOverviewApi._internal();
  InspectorOverviewApi._internal();

  static InspectorOverviewApi get instance => _singleton;

  Future<InspectorOverviewResponse> inspectorOverviewApi() async {
    try {
      Response response = await getHttp(Endpoints.inspectorOverVIew());
      if (response.statusCode == 200 || response.statusCode == 201) {
        InspectorOverviewResponse data = InspectorOverviewResponse.fromRawJson(
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

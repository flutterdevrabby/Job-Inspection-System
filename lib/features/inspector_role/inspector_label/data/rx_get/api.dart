import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
import 'model/inspector_label_response.dart';

final class InspectorLabelApi {
  static final InspectorLabelApi _singleton = InspectorLabelApi._internal();
  InspectorLabelApi._internal();

  static InspectorLabelApi get instance => _singleton;

  Future<LabelInspectorResponse> inspectorLabelApi({
    int? page,
    int? limit,
    String? search,



  }) async {
    try {
      Response response = await getHttp(
        Endpoints.getLabel(
          limit: limit,
          page: page,
          search: search,
        
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        LabelInspectorResponse data = LabelInspectorResponse.fromRawJson(
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

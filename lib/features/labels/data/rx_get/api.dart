import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../../networks/dio/dio.dart';
import '../../../../../../../networks/endpoints.dart';
import '../../../../../../../networks/exception_handler/data_source.dart';
import 'model/label_response.dart';

final class AllLabelAPi {
  static final AllLabelAPi _singleton = AllLabelAPi._internal();
  AllLabelAPi._internal();

  static AllLabelAPi get instance => _singleton;

  Future<GetLabelResponse> allLabelAPi({
    int? page,
    int? limit,
    String? search,
  }) async {
    try {
      Response response = await getHttp(
        Endpoints.getAllLabel(limit: limit, page: page, search: search),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        GetLabelResponse data = GetLabelResponse.fromRawJson(
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

import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
import 'model/all_notification_response.dart';

final class GetAllNotificationApi {
  static final GetAllNotificationApi _singleton =
      GetAllNotificationApi._internal();
  GetAllNotificationApi._internal();

  static GetAllNotificationApi get instance => _singleton;

  Future<GetAllNotificationResponse> getAllNotificationApi({
    int? page,
    int? limit,
  }) async {
    try {
      Response response = await getHttp(
        Endpoints.getAllNotification(page: page, limit: limit),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        GetAllNotificationResponse data =
            GetAllNotificationResponse.fromRawJson(json.encode(response.data));
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

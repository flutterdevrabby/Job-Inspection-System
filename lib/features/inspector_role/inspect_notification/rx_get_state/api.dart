import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import 'model/notification_state_response.dart';

final class NotificationStateApi {
  static final NotificationStateApi _singleton =
      NotificationStateApi._internal();
  NotificationStateApi._internal();

  static NotificationStateApi get instance => _singleton;

  Future<NotificationStateResponse> notificationStateApi({
    required String deviceId,
  }) async {
    try {
      Response response = await getHttp(
        Endpoints.notificationState(deviceId: deviceId),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        NotificationStateResponse data = NotificationStateResponse.fromRawJson(
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

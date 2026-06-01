import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';
import '../rx_get_state/model/notification_state_response.dart';

final class NotificationOnOffApi {
  static final NotificationOnOffApi _singleton =
      NotificationOnOffApi._internal();
  NotificationOnOffApi._internal();

  static NotificationOnOffApi get instance => _singleton;

  Future<NotificationStateResponse> notificationOnOffApi({
    required String deviceId,
  }) async {
    try {
      Response response = await putHttp(
        Endpoints.toggleNotification(deviceId: deviceId),
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

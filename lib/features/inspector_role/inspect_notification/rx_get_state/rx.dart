import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../networks/stream_cleaner.dart';
import 'api.dart';
import 'model/notification_state_response.dart';

final class NotificationStateRX
    extends RxResponseInt<NotificationStateResponse> {
  final api = NotificationStateApi.instance;

  NotificationStateRX({required super.empty, required super.dataFetcher});

  ValueStream<NotificationStateResponse> get notificationStateRXStream =>
      dataFetcher.stream;

  Future<NotificationStateResponse> notificationStateRX({
    required String deviceId,
  }) async {
    try {
      NotificationStateResponse data = await api.notificationStateApi(
        deviceId: deviceId,
      );
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(NotificationStateResponse data) {
    dataFetcher.sink.add(data);
    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        ToastUtil.showErrorLongToast(error.response!.data["message"]);
      } else {
        if (error.response!.statusCode == 401) {
          ToastUtil.showErrorLongToast(error.response!.data["message"]);
          totalDataClean();
          NavigationService.navigateToReplacement(Routes.signinScreen);
        } else {
          ToastUtil.showErrorLongToast(error.response!.data["message"]);
        }
      }
      log(error.toString());
      dataFetcher.sink.addError(error);
      return false;
    }
  }
}

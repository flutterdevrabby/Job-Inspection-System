import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../networks/stream_cleaner.dart';
import '../rx_get_state/model/notification_state_response.dart';
import 'api.dart';

final class NotificationOnOffRx
    extends RxResponseInt<NotificationStateResponse> {
  final api = NotificationOnOffApi.instance;

  NotificationOnOffRx({required super.empty, required super.dataFetcher});

  ValueStream<NotificationStateResponse> get notificationOnOffRxStream =>
      dataFetcher.stream;

  Future<NotificationStateResponse> notificationOnOffRx({
    required String deviceId,
  }) async {
    try {
      final data = await api.notificationOnOffApi(deviceId: deviceId);
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

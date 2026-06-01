import 'dart:developer';

import 'package:artneidich_app/constants/app_constants.dart';
import 'package:artneidich_app/helpers/di.dart';
import 'package:artneidich_app/networks/dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../networks/stream_cleaner.dart';
import 'api.dart';

final class LogoutRx extends RxResponseInt<Map> {
  final api = LogoutApi.instance;

  LogoutRx({required super.empty, required super.dataFetcher});

  ValueStream<Map> get signinApiStream => dataFetcher.stream;

  Future<bool> logoutRx({required String deviceId}) async {
    try {
      final data = await api.logoutApi(deviceId: deviceId);
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map data) {
    appData.write(kKeyAccessToken, "");
    appData.write(kKeyIsLoggedIn, false);
    DioSingleton.instance.update(appData.read(kKeyAccessToken));
    dataFetcher.sink.add(data);
    return true;
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

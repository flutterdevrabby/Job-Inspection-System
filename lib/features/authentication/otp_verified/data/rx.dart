import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../networks/stream_cleaner.dart';
import 'api.dart';

final class OtpVerifyRx extends RxResponseInt<Map> {
  final api = OtpVerifyApi.instance;

  OtpVerifyRx({required super.empty, required super.dataFetcher});

  ValueStream<Map> get otpVerifyApiStream => dataFetcher.stream;

  Future<bool> otpVerifyApi({
    required String email,
    required String otp,
  }) async {
    try {
      final data = await api.otpVerifyApi(email: email, otp: otp);
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map data) {
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
//  [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: type 'String' is not a subtype of type 'int' of 'index'
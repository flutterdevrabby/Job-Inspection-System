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

final class SigninRx extends RxResponseInt<Map> {
  String? role;
  final api = SigninApi.instance;

  SigninRx({required super.empty, required super.dataFetcher});

  ValueStream<Map> get signinApiStream => dataFetcher.stream;

  Future<bool> signinRx({
    required String email,
    required String password,
    required String deviceId,
    required String token,
    required String platform,
  }) async {
    try {
      final data = await api.signupApi(
        email: email,
        password: password,
        deviceId: deviceId,
        platform: platform,
        token: token,
      );
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map data) {
    appData.write(kKeyAccessToken, data["token"]);
    // User Info
    appData.write(kKeyFirstName, data["user"]["firstName"]);
    appData.write(kKeyLastName, data["user"]["lastName"]);
    appData.write(kKeyUserID, data["user"]["id"]);

    log("First Name ========================${appData.read(kKeyFirstName)}");
    log("Last Name ========================${appData.read(kKeyLastName)}");
    log("EMail  ========================${appData.read(kKeyEMail)}");
    appData.write(kKeyEMail, data["user"]["email"]);
    appData.write(kKeyRole, data["user"]["role"]);
    role = data["user"]["role"];
    appData.write(kKeyIsLoggedIn, true);
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

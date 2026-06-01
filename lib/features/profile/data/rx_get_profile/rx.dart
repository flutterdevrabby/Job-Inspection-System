import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../helpers/toast.dart';
import '../../../../../../networks/rx_base.dart';
import '../../../../../helpers/all_routes.dart';
import '../../../../../helpers/navigation_service.dart';
import '../../../../../networks/stream_cleaner.dart';
import '../../../../constants/app_constants.dart';
import '../../../../helpers/di.dart';
import 'api.dart';
import 'model/profile_response_model.dart';

final class ProfileRx extends RxResponseInt<ProfileResponse> {
  final api = ProfileApi.instance;

  ProfileRx({required super.empty, required super.dataFetcher});

  ValueStream<ProfileResponse> get profileRxStream => dataFetcher.stream;

  Future<ProfileResponse> profileRx() async {
    try {
      ProfileResponse data = await api.profileApi();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(ProfileResponse data) {
    // User Info
    appData.write(kKeyFirstName, data.data?.firstName ?? "");
    appData.write(kKeyLastName, data.data?.lastName ?? "");
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

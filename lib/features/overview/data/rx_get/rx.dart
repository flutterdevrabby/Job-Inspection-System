import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../../helpers/toast.dart';
import '../../../../../../../networks/rx_base.dart';
import '../../../../../../helpers/all_routes.dart';
import '../../../../../../helpers/navigation_service.dart';
import '../../../../../../networks/stream_cleaner.dart';
import 'api.dart';
import 'model/admin_overview_response.dart';

final class AdminOverviewRx extends RxResponseInt<AdminOverviewResponse> {
  final api = AdminOverviewApi.instance;

  AdminOverviewRx({required super.empty, required super.dataFetcher});

  ValueStream<AdminOverviewResponse> get adminOverviewRxStream =>
      dataFetcher.stream;

  Future<AdminOverviewResponse> adminOverviewRx() async {
    try {
      AdminOverviewResponse data = await api.adminOverviewApi();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(AdminOverviewResponse data) {
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

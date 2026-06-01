import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../../helpers/toast.dart';
import '../../../../../../../networks/rx_base.dart';
import '../../../../../../helpers/all_routes.dart';
import '../../../../../../helpers/navigation_service.dart';
import '../../../../../../networks/stream_cleaner.dart';
import 'api.dart';
import 'model/inspector_overview_response.dart';

final class InspectorOverviewRx extends RxResponseInt<InspectorOverviewResponse> {
  final api = InspectorOverviewApi.instance;

  InspectorOverviewRx({required super.empty, required super.dataFetcher});

  ValueStream<InspectorOverviewResponse> get inspectorOverviewRxStream =>
      dataFetcher.stream;

  Future<InspectorOverviewResponse> inspectorOverviewRx() async {
    try {
      InspectorOverviewResponse data = await api.inspectorOverviewApi();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(InspectorOverviewResponse data) {
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

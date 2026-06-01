import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../helpers/toast.dart';
import '../../../../../../networks/rx_base.dart';
import '../../../../../helpers/all_routes.dart';
import '../../../../../helpers/navigation_service.dart';
import '../../../../../networks/stream_cleaner.dart';

import 'model/inspector_label_response.dart';
import 'api.dart';

final class InspectorLabelRx extends RxResponseInt<LabelInspectorResponse> {
  final api = InspectorLabelApi.instance;

  InspectorLabelRx({required super.empty, required super.dataFetcher});

  ValueStream<LabelInspectorResponse> get inspectorLabelRxStream =>
      dataFetcher.stream;

  Future<LabelInspectorResponse> inspectorLabelRx({
    int? page,
    int? limit,
    String? search,
  }) async {
    try {
      LabelInspectorResponse data = await api.inspectorLabelApi(
        limit: limit,
        page: page,

        search: search,
      );
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(LabelInspectorResponse data) {
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

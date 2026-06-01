import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../helpers/toast.dart';
import '../../../../../../networks/rx_base.dart';
import '../../../../../helpers/all_routes.dart';
import '../../../../../helpers/navigation_service.dart';
import '../../../../../networks/stream_cleaner.dart';
import 'api.dart';
import 'model/inspection_response.dart';

final class InspectionRx extends RxResponseInt<InspectionResponse> {
  final api = InspectionApi.instance;

  InspectionRx({required super.empty, required super.dataFetcher});

  ValueStream<InspectionResponse> get inspectionRxStream => dataFetcher.stream;

  Future<InspectionResponse> inspectionRx({
    int? page,
    int? limit,
    String? search,
    String? dueDateFrom,
    String? dueDateTo,
  }) async {
    try {
      InspectionResponse data = await api.inspectionApi(
        limit: limit,
        page: page,
        search: search,
        dueDateTo: dueDateTo,
        dueDateFrom: dueDateFrom,
      );
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(InspectionResponse data) {
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

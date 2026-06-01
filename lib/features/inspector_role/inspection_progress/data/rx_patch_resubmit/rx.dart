import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../../helpers/toast.dart';
import '../../../../../../../networks/rx_base.dart';
import '../../../../../../helpers/all_routes.dart';
import '../../../../../../helpers/navigation_service.dart';
import '../../../../../../networks/stream_cleaner.dart';
import '../../../../../provider/inspector_progress_provider.dart';
import 'api.dart';

final class InspectionResubmitJobRX extends RxResponseInt<Map> {
  final api = InspectionResubmitJobApi.instance;

  InspectionResubmitJobRX({required super.empty, required super.dataFetcher});

  ValueStream<Map> get createReportRxStream => dataFetcher.stream;

  Future<bool> inspectionResubmitJobRX({
    required String reportID,
    required InspectorProgressProvider provider,
    required String noteToAdmin,
  }) async {
    try {
      final data = await api.inspectionResubmitJobApi(
        reportID: reportID,
        provider: provider,
        noteToAdmin: noteToAdmin,
      );
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

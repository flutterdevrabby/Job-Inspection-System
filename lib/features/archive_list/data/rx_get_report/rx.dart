import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../../helpers/toast.dart';
import '../../../../../../../networks/rx_base.dart';
import '../../../../../../helpers/all_routes.dart';
import '../../../../../../helpers/navigation_service.dart';
import '../../../../../../networks/stream_cleaner.dart';
import '../model/archive_response.dart';
import 'api.dart';

final class ArchiveListRx extends RxResponseInt<ArchiveReportResponse> {
  final api = ArchiveListApi.instance;

  ArchiveListRx({required super.empty, required super.dataFetcher});

  ValueStream<ArchiveReportResponse> get archiveListRxStream =>
      dataFetcher.stream;

  Future<ArchiveReportResponse> archiveListRx({
    required int page,
    required int limit,
  }) async {
    try {
      ArchiveReportResponse data = await api.archiveListApi(
        page: page,
        limit: limit,
      );
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(ArchiveReportResponse data) {
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
      return ArchiveReportResponse();
    }
  }
}

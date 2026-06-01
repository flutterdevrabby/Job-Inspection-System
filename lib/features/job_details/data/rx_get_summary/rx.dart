import 'dart:developer';

import 'package:artneidich_app/constants/app_constants.dart';
import 'package:artneidich_app/helpers/di.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../helpers/toast.dart';
import '../../../../../../networks/rx_base.dart';
import '../../../../../helpers/all_routes.dart';
import '../../../../../helpers/navigation_service.dart';
import '../../../../../networks/stream_cleaner.dart';
import 'api.dart';
import 'model/summary_response.dart';

final class SummaryRx extends RxResponseInt<SummaryResponse> {
  final api = SummaryApi.instance;

  SummaryRx({required super.empty, required super.dataFetcher});

  ValueStream<SummaryResponse> get summaryRxStream => dataFetcher.stream;

  Future<SummaryResponse> summaryRx({required String id}) async {
    try {
      SummaryResponse data = await api.summaryApi(id: id);
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(SummaryResponse data) {
    appData.write(kKeyReportId, data.data?.reportId ?? "");
    appData.write(kKeyHasReport, data.data?.hasReport ?? false);

    log(
      "kKeyReportId=======================================>${appData.read(kKeyReportId)}",
    );
    log(
      "kKeyHasReport=======================================>${appData.read(kKeyHasReport)}",
    );
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

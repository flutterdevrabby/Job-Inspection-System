import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../helpers/toast.dart';
import '../../../../../../networks/rx_base.dart';
import '../../../../../helpers/all_routes.dart';
import '../../../../../helpers/navigation_service.dart';
import '../../../../../networks/stream_cleaner.dart';
import '../model/archive_setting_response.dart';
import 'api.dart';

final class ArchiveSettingFetchRx
    extends RxResponseInt<ArchiveSettingFetchResponse> {
  final api = ArchiveSettingFetchApi.instance;

  ArchiveSettingFetchRx({required super.empty, required super.dataFetcher});

  ValueStream<ArchiveSettingFetchResponse>
  get archiveSettingFetchResponseStream => dataFetcher.stream;

  Future<ArchiveSettingFetchResponse> archiveSettingFetchRx() async {
    try {
      ArchiveSettingFetchResponse data = await api.archiveSettingFetchApi();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(ArchiveSettingFetchResponse data) {
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

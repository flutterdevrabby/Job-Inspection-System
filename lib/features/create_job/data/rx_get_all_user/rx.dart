import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../helpers/toast.dart';
import '../../../../../../networks/rx_base.dart';
import '../../../../../helpers/all_routes.dart';
import '../../../../../helpers/navigation_service.dart';
import '../../../../../networks/stream_cleaner.dart';
import 'api.dart';
import 'model/all_user_response.dart';

final class AllUserRx extends RxResponseInt<AllUserResponse> {
  final api = AllUserApi.instance;

  AllUserRx({required super.empty, required super.dataFetcher});

  ValueStream<AllUserResponse> get allUserRxStream => dataFetcher.stream;

  Future<AllUserResponse> allUserRx({
    int? page,
    int? limit,
    String? search,
    int? role,
    bool? isSuspended,
    bool? isApproved,
  }) async {
    try {
      AllUserResponse data = await api.allUserApi(
        isApproved: isApproved,
        isSuspended: isSuspended,
        limit: limit,
        page: page,
        role: role,
        search: search,
      );
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(AllUserResponse data) {
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

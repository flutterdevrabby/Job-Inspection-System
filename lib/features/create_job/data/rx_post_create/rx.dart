import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../helpers/toast.dart';
import '../../../../../../networks/rx_base.dart';
import '../../../../../helpers/all_routes.dart';
import '../../../../../helpers/navigation_service.dart';
import '../../../../../networks/stream_cleaner.dart';
import 'api.dart';

final class CreateJobRx extends RxResponseInt<Map> {
  final api = CreateJobApi.instance;

  CreateJobRx({required super.empty, required super.dataFetcher});

  ValueStream<Map> get signinApiStream => dataFetcher.stream;

  Future<bool> createJobRx({
    required String inspector,
    required String formType,
    required String feeStatus,
    required int agreedFee,
    required String fhaCaseDetailsNo,
    required String orderId,
    required String streetAddress,
    required String developmentName,
    required String siteContactName,
    required String siteContactPhone,
    required String siteContactEmail,
    required String dueDate,
    required String specialNotesForInspector,
  }) async {
    try {
      final data = await api.createJobApi(
        inspector: inspector,
        formType: formType,
        feeStatus: feeStatus,
        agreedFee: agreedFee,
        fhaCaseDetailsNo: fhaCaseDetailsNo,
        orderId: orderId,
        developmentName: developmentName,
        siteContactName: siteContactName,
        siteContactPhone: siteContactPhone,
        siteContactEmail: siteContactEmail,
        dueDate: dueDate,
        specialNotesForInspector: specialNotesForInspector,
        streetAddress: streetAddress,
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

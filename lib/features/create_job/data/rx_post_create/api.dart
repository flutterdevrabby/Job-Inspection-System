import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class CreateJobApi {
  static final CreateJobApi _singleton = CreateJobApi._internal();
  CreateJobApi._internal();

  static CreateJobApi get instance => _singleton;

  Future<Map> createJobApi({
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
      Map data = {
        "inspector": inspector,
        "formType": formType,
        "feeStatus": feeStatus,
        "agreedFee": agreedFee,
        "fhaCaseDetailsNo": fhaCaseDetailsNo,
        "orderId": orderId,
        "streetAddress": streetAddress,
        "developmentName": developmentName,
        "siteContactName": siteContactName,
        "siteContactPhone": siteContactPhone,
        "siteContactEmail": siteContactEmail,
        "dueDate": dueDate,
        "specialNotesForInspector": specialNotesForInspector,
      };

      Response response = await postHttp(Endpoints.createJob(), data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(json.encode(response.data));
        return data;
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      rethrow;
    }
  }
}

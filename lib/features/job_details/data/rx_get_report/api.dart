import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
import 'model/job_report_response.dart';

final class JobReportApi {
  static final JobReportApi _singleton = JobReportApi._internal();
  JobReportApi._internal();

  static JobReportApi get instance => _singleton;

  Future<ReportResponse> jobReportApi({required String id}) async {
    try {
      Response response = await getHttp(Endpoints.getReportJob(id: id));
      if (response.statusCode == 200 || response.statusCode == 201) {
        ReportResponse data = ReportResponse.fromRawJson(
          json.encode(response.data),
        );
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

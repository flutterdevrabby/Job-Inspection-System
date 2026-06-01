import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class EmailSupportApi {
  static final EmailSupportApi _singleton = EmailSupportApi._internal();
  EmailSupportApi._internal();

  static EmailSupportApi get instance => _singleton;

  Future<Map> emailSupportApi({required String message}) async {
    try {
      Map data = {"message": message};

      Response response = await postHttp(Endpoints.emailSupport(), data);
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

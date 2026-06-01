import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../../networks/dio/dio.dart';
import '../../../../../../../networks/endpoints.dart';
import '../../../../../../../networks/exception_handler/data_source.dart';

final class DeleteLabelAPi {
  static final DeleteLabelAPi _singleton = DeleteLabelAPi._internal();
  DeleteLabelAPi._internal();

  static DeleteLabelAPi get instance => _singleton;

  Future<Map> deleteLabelAPi({required String id}) async {
    try {
      Response response = await deleteHttp(Endpoints.deleteLabel(id: id));
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

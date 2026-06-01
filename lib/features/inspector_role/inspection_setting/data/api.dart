import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class DeleteUserAccountApi {
  static final DeleteUserAccountApi _singleton =
      DeleteUserAccountApi._internal();
  DeleteUserAccountApi._internal();

  static DeleteUserAccountApi get instance => _singleton;

  Future<Map> deleteUserAccountApi({required String id}) async {
    try {
      Response response = await deleteHttp(Endpoints.deleteUserId(id: id));
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

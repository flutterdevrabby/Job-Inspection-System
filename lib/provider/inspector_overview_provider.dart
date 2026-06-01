import 'package:flutter/material.dart';

import '../features/inspector_role/inspector_overview/data/rx_get/model/inspector_overview_response.dart';
import '../networks/api_acess.dart';

class InspectorOverviewProvider extends ChangeNotifier {
  InspectorOverviewProvider() {
    fetchInspectorOverviewData();
  }
  InspectorOverviewResponse? _data;

  InspectorOverviewResponse? get data => _data;

  Future<void> fetchInspectorOverviewData() async {
    final response = await inspectorOverviewRxObj.inspectorOverviewRx();
    _data = response;
    notifyListeners();
  }
}

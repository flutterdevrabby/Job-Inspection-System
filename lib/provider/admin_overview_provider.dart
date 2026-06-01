import 'package:flutter/material.dart';

import '../features/overview/data/rx_get/model/admin_overview_response.dart';
import '../networks/api_acess.dart';

class AdminOverviewProvider extends ChangeNotifier {
  AdminOverviewProvider() {
    fetchAdminOverviewData();
  }
  AdminOverviewResponse? _data;

  AdminOverviewResponse? get data => _data;

  Future<void> fetchAdminOverviewData() async {
    final response = await adminOverviewRxObj.adminOverviewRx();
    _data = response;
    notifyListeners();
  }
}

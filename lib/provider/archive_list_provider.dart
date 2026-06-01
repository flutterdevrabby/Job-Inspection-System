import 'package:artneidich_app/features/archive_list/data/model/archive_response.dart';
import 'package:flutter/material.dart';

import '../networks/api_acess.dart';

class ArchiveListProvider extends ChangeNotifier {
  // Pagination
  final int _limit = 10;
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  List<Datum> _datum = [];

  String? _errorMessage;

  // Getters Method
  List<Datum> get datum => _datum;
  List<String> get dataColumeList => _dataColumeList;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  String? get errorMessage => _errorMessage;

  final List<String> _dataColumeList = [
    "FHA Case Details", //orderId1
    "Order ID", // ORD123
    "Address", // 123 Main St
    "Inspector", // Admin A
    "Date Due", //2026-04-10T00:00:00.000Z
    "Date Submitted", //"2026-04-13T06:22:46.112Z",
    "Status",
    //"reportStatus": "archived",
    //"reportStatusLabel": "In Progress"
    "Action",
  ];

  Future<void> ferchAllJOBData() async {
    if (_isLoading || !hasMore) return;

    _isLoading = true;
    notifyListeners();

    // Fetch All Data From API
    final response = await archiveListRxObj.archiveListRx(
      page: _page,
      limit: _limit,
    );

    final data = response.data ?? [];

    if (data.isEmpty) {
      if (_page == 1) {
        _errorMessage = "No Data Found";
      }
      _hasMore = false;
    } else {
      _datum.addAll(data);

      _page++;
    }
    _isLoading = false;
    notifyListeners();
  }

  ///
  ///
  ///

  List<String> selectedIds = [];

  bool isChecked(String id) => selectedIds.contains(id);

  void toggleChecked(String id, bool value) {
    if (value) {
      selectedIds.add(id);
    } else {
      selectedIds.remove(id);
    }
    notifyListeners();
  }

  bool get isAllSelected =>
      datum.isNotEmpty && selectedIds.length == datum.length;

  void toggleSelectAll(bool value) {
    if (value) {
      selectedIds = datum.map((e) => (e.id ?? "").toString()).toList();
    } else {
      selectedIds.clear();
    }
    notifyListeners();
  }


 void clearSelection() {
    selectedIds.clear();
    notifyListeners();
  }

  Future<void> refreshData() async {
    _page = 1;
    _hasMore = true;
    _datum.clear();
    clearSelection(); 
    await ferchAllJOBData();
  }
}

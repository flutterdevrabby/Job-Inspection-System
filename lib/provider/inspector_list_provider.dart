import 'package:flutter/material.dart';

import '../features/create_job/data/rx_get_all_user/model/all_user_response.dart';
import '../networks/api_acess.dart';

class InspectorListProvider extends ChangeNotifier {
  int _page = 1;
  final int _limit = 20;

  bool _isLoadingInitial = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  bool _showNoMoreData = false;

  final List<Datum> _data = [];

  // Getters
  bool get isLoadingInitial => _isLoadingInitial;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;
  bool get showNoMoreData => _showNoMoreData;
  List<Datum> get data => _data;

  Future<void> fetchInspectorListData({required bool isApproved}) async {
    if (_isLoadingMore || !_hasMore) return;

    if (_page == 1) {
      _isLoadingInitial = true;
      _showNoMoreData = false;
    } else {
      _isLoadingMore = true;
    }
    notifyListeners();

    final response = await allUserRxObj.allUserRx(
      page: _page,
      limit: _limit,
      role: 2,
      isApproved: isApproved,
    );

    final newData = response.data ?? [];

    if (newData.isEmpty) {
      _hasMore = false;
      _showNoMoreData = true;
    } else {
      _page++;
      _data.addAll(newData);
    }

    _isLoadingInitial = false;
    _isLoadingMore = false;
    notifyListeners();
  }

  void refresh({required bool isApproved}) {
    _page = 1;
    _hasMore = true;
    _showNoMoreData = false;
    _data.clear();
    fetchInspectorListData(isApproved: isApproved);
  }
}

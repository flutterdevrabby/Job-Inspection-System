import 'package:artneidich_app/features/notification/data/rx_get_all/model/all_notification_response.dart';
import 'package:flutter/material.dart';

import '../networks/api_acess.dart';

class NotificationProvider extends ChangeNotifier {
  int _page = 1;
  final int _limit = 10;
  bool _isLoading = false;
  bool _hasMore = true;
  final List<Datum> _data = [];

  bool _enablePagination = true;

  // Getter
  List<Datum> get data => _data;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  void setPagination(bool value) {
    _enablePagination = value;
  }

  Future<void> fetchNotificationData() async {
    if (_isLoading) return;

    //  pagination disabled হলে শুধু first page call হবে
    if (!_enablePagination && _data.isNotEmpty) return;

    //  pagination enabled কিন্তু আর data নাই
    if (_enablePagination && !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    final response = await getAllNotificationRXObj.getAllNotificationRX(
      page: _page,
      limit: _limit,
    );

    final newData = response.data ?? [];

    if (_enablePagination) {
      if (newData.isEmpty) {
        _hasMore = false;
      } else {
        _page++;
        _data.addAll(newData);
      }
    } else {
      // non-pagination screen
      _data
        ..clear()
        ..addAll(newData);
      _hasMore = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _page = 1;
    _hasMore = true;
    _data.clear();
  }
}


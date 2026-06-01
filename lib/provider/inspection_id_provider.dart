import 'package:flutter/material.dart';

import '../features/inspector_role/inspection_view/data/rx_get/model/inspection_response.dart';
import '../networks/api_acess.dart';

class InspectionIdProvider extends ChangeNotifier {
  InspectionIdProvider() {
    fetchLabel();
    _scrollController.addListener(onScroll);
  }

  Datum? _selectedOrderId;

  Datum? get selectedOrderId => _selectedOrderId;

  void updateOrder(Datum? index) {
    _selectedOrderId = index;
    notifyListeners();
  }

  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  final List<Datum> _data = [];
  final int _limit = 10;

  bool _isLoading = false;
  bool _hasMore = true;

  // Getter
  int get page => _page;
  List<Datum> get data => _data;
  int get limit => _limit;
  bool get isLoading => _isLoading;

  ScrollController get scrollController => _scrollController;

  Future<void> fetchLabel() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    final response = await inspectionRxObj.inspectionRx(
      page: _page,
      limit: _limit,
    );

    final newData = response.data ?? [];

    if (newData.isEmpty) {
      _hasMore = false;
    } else {
      _page++;
      _data.addAll(newData);
    }

    _isLoading = false;
    notifyListeners();
  }

  // Scroll listener
  void onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      fetchLabel();
    }
  }

  // DISPOSE CALLED HERE
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

bool _status = false;

  bool get status => _status;

  void updateStatus(bool value) {

    notifyListeners();
  }
}

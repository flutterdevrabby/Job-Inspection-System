import 'package:flutter/material.dart';

import '../features/inspector_role/inspection_view/data/rx_get/model/inspection_response.dart';
import '../networks/api_acess.dart';

class AssignInspectorProvider extends ChangeNotifier {
  final ScrollController _scrollController = ScrollController();

  final int _limit = 10;
  int _page = 1;
  bool _isLoading = false; // for first loading
  bool _isMoreLoading =
      false; // when user scrolling the list and fetching more data
  bool _hasMore = true;
  String? _searchJob;

  String? _dueDateFrom;
  String? _dueDateTo;

  final List<Datum> _datum = [];
  final List<String> _dataColumeList = [
    "Address",
    "Development",
    "Date Due",
    "Status",
    "Action",
    "",
  ];

  // Getters
  ScrollController get scrollController => _scrollController;
  List<Datum> get datum => _datum;
  List<String> get dataColumeList => _dataColumeList;
  bool get isLoading => _isLoading;
  bool get isMoreLoading => _isMoreLoading;
  bool get hasMore => _hasMore;

  String? get searchJob => _searchJob;

  String? get dueDateFrom => _dueDateFrom;
  String? get dueDateTo => _dueDateTo;

  void updateRangeDatePicker({
    required String? dueDateFrom,
    required String? dueDateTo,
  }) {
    _dueDateFrom = dueDateFrom;
    _dueDateTo = dueDateTo;
    notifyListeners();
  }

  AssignInspectorProvider() {
    fetchAllJob();
    _scrollListener();
  }

  void _scrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading &&
          _hasMore) {
        fetchAllJob();
      }
    });
  }

  Future<void> fetchAllJob() async {
    if (_isLoading || _isMoreLoading || !_hasMore) return;

    if (_datum.isEmpty) {
      _isLoading = true;
    } else {
      _isMoreLoading = true;
    }

    notifyListeners();

    try {
      final response = await inspectionRxObj.inspectionRx(
        limit: _limit,
        page: _page,
        search: _searchJob,
        dueDateFrom: _dueDateFrom,
        dueDateTo: _dueDateTo,
      );

      if (response.data != null && response.data!.isNotEmpty) {
        _datum.addAll(response.data!);
        _page++;

        if (response.data!.length < _limit) {
          _hasMore = false;
        }
      } else {
        _hasMore = false;
      }
    } catch (e) {
      _hasMore = false;
    } finally {
      _isLoading = false;
      _isMoreLoading = false;
      notifyListeners();
    }
  }

  void searchJobUpdate(
    String value,
    String? dueDateFrom,
    String? dueDateTo,
  ) async {
    _searchJob = value;
    _dueDateFrom = dueDateFrom;
    _dueDateTo = dueDateTo;

    //  RESET pagination + data
    _datum.clear();
    _page = 1;
    _hasMore = true;
    notifyListeners();
    // fetch with new filter
    fetchAllJob();
  }

  Future<void> refreshData() async {
    _searchJob = null;
    _dueDateFrom = null;
    _dueDateTo = null;
    _datum.clear();
    _page = 1;
    _hasMore = true;

    await fetchAllJob(); // fetch fresh data
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

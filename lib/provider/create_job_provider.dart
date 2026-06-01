import 'package:flutter/material.dart';

import '../features/create_job/data/rx_get_all_user/model/all_user_response.dart';
import '../networks/api_acess.dart';

class CreateJobProvider extends ChangeNotifier {
  final List<Datum> _users = [];
  List<Datum> get users => _users;

  final ScrollController scrollController = ScrollController();

  int _page = 1;
  final int _limit = 10;
  int _totalPages = 1;

  String? _selectedUserId;
  String? get selectedUserId => _selectedUserId;

  void setSelectedUser(String? id) {
    _selectedUserId = id;
    notifyListeners();
  }

  bool _isLoading = false; // first load
  bool _isLoadMore = false; // bottom pagination load

  bool get isLoading => _isLoading;
  bool get isLoadMore => _isLoadMore;

  CreateJobProvider() {
    fetchUsers();

    scrollController.addListener(() {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 100) {
        loadMore();
      }
    });
  }

  bool get hasMore => _page < _totalPages;

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await allUserRxObj.allUserRx(
        isApproved: true,
        role: 2,
        page: _page,
        isSuspended: false,
        limit: _limit,
      );

      _totalPages = response.metaData?.totalPage ?? 1;

      final newList = (response.data ?? []).where(
        (item) => !_users.any((old) => old.id == item.id),
      );

      _users.addAll(newList);
    } catch (e) {
      debugPrint("Error fetching users: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (_isLoadMore) return;
    if (!hasMore) return;

    _isLoadMore = true;
    _page++;
    notifyListeners();

    try {
      final response = await allUserRxObj.allUserRx(
        isApproved: true,
        role: 2,
        page: _page,
        isSuspended: false,
        limit: _limit,
      );

      final newList = (response.data ?? []).where(
        (item) => !_users.any((old) => old.id == item.id),
      );

      _users.addAll(newList);
    } catch (e) {
      debugPrint("Error loading more users: $e");
    }

    _isLoadMore = false;
    notifyListeners();
  }

  void reset() {
    _users.clear();
    _page = 1;
    _totalPages = 1;
    fetchUsers();
  }
}

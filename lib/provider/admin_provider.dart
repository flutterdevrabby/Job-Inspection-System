import 'package:flutter/material.dart';

import '../features/create_job/data/rx_get_all_user/model/all_user_response.dart';
import '../networks/api_acess.dart';

class AdminProvider extends ChangeNotifier {
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

  Future<void> fetchAdminListData() async {
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
      role: 1,
      isApproved: true,
      isSuspended: false,
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
    fetchAdminListData();
  }

  // /// DATA
  // final List<Datum> users = [];
  // final ScrollController scrollController = ScrollController();

  // int page = 1;
  // final int limit = 20;
  // int totalPages = 1;

  // bool isLoading = false;
  // bool isLoadMore = false;

  // ///  DYNAMIC FILTERS
  // bool? isApproved;
  // int? role;
  // bool? isSuspended;

  // AdminProvider() {
  //   scrollController.addListener(() {
  //     if (scrollController.position.pixels >=
  //         scrollController.position.maxScrollExtent - 400) {
  //       loadMore();
  //     }
  //   });
  // }

  // bool get hasMore => page < totalPages;

  // /// =========================
  // /// SET FILTERS FROM SCREEN
  // /// =========================
  // void setFilters({bool? approved, int? userRole, bool? suspended}) {
  //   isApproved = approved;
  //   role = userRole;
  //   isSuspended = suspended;

  //   resetAndFetch();
  // }

  // /// =========================
  // /// RESET + FIRST LOAD
  // /// =========================
  // Future<void> resetAndFetch() async {
  //   page = 1;
  //   totalPages = 1;
  //   users.clear();
  //   await fetchUsers();
  // }

  // /// =========================
  // /// FIRST LOAD
  // /// =========================
  // Future<void> fetchUsers() async {
  //   isLoading = true;
  //   notifyListeners();

  //   try {
  //     final response = await allUserRxObj.allUserRx(
  //       isApproved: isApproved,
  //       role: role,
  //       isSuspended: isSuspended,
  //       page: page,
  //       limit: limit,
  //     );

  //     totalPages = response.metaData?.totalPage ?? 1;
  //     users.addAll(response.data ?? []);
  //   } catch (e) {
  //     debugPrint("Fetch users error: $e");
  //   }

  //   isLoading = false;
  //   notifyListeners();
  // }

  // /// =========================
  // /// PAGINATION
  // /// =========================
  // Future<void> loadMore() async {
  //   if (isLoadMore || !hasMore) return;

  //   isLoadMore = true;
  //   page++;
  //   notifyListeners();

  //   try {
  //     final response = await allUserRxObj.allUserRx(
  //       isApproved: isApproved,
  //       role: role,
  //       isSuspended: isSuspended,
  //       page: page,
  //       limit: limit,
  //     );

  //     users.addAll(response.data ?? []);
  //   } catch (e) {
  //     debugPrint("Load more users error: $e");
  //   }

  //   isLoadMore = false;
  //   notifyListeners();
  // }

  // @override
  // void dispose() {
  //   scrollController.dispose();
  //   super.dispose();
  // }
}

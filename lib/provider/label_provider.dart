import 'package:flutter/material.dart';

import '../features/labels/data/rx_get/model/label_response.dart';
import '../networks/api_acess.dart';

class LabelProvider extends ChangeNotifier {
  int _page = 1;
  final int _limit = 30;

  bool _isLoading = false;
  bool _hasMore = true;

  final List<Datum> _data = [];
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  List<Datum> get data => _data;
  String? get errorMessage => _errorMessage;

  LabelProvider() {
    fetchAllLabel();
  }

  Future<void> refreshAllLabel() async {
    _page = 1;
    _data.clear();
    _hasMore = true;
    _errorMessage = null;
    await fetchAllLabel();
  }

  Future<void> fetchAllLabel() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await allLabelRxObj.allLabelRx(
        limit: _limit,
        page: _page,
      );

      final newData = response.data ?? [];

      if (newData.isEmpty) {
        _hasMore = false;
        return;
      }

      _data.addAll(newData);
      _page++;

      if (newData.length < _limit) {
        _hasMore = false;
      }
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}




// import 'package:flutter/material.dart';

// import '../features/labels/data/rx_get/model/label_response.dart';
// import '../networks/api_acess.dart';

// class LabelProvider extends ChangeNotifier {
//   final ScrollController scrollController = ScrollController();

//   int _page = 1;
//   final int _limit = 30;

//   bool _isLoading = false;
//   bool _hasMore = true;

//   final List<Datum> _data = [];
//   String? _errorMessage;

//   // getters
//   bool get isLoading => _isLoading;
//   bool get hasMore => _hasMore;
//   List<Datum> get data => _data;
//   String? get errorMessage => _errorMessage;

//   LabelProvider() {
//     fetchAllLabel();
//     scrollController.addListener(_scrollListener);
//   }

//   void _scrollListener() {
//     if (scrollController.position.pixels >=
//             scrollController.position.maxScrollExtent - 200 &&
//         !_isLoading &&
//         _hasMore) {
//       fetchAllLabel();
//     }
//   }

//   //  New refresh method - reset করে data load করবে
//   Future<void> refreshAllLabel() async {
//     _page = 1;
//     _data.clear();
//     _hasMore = true;
//     _errorMessage = null;
//     await fetchAllLabel();
//   }

//   Future<void> fetchAllLabel() async {
//     if (_isLoading || !_hasMore) return;

//     _isLoading = true;
//     notifyListeners();

//     try {
//       final response = await allLabelRxObj.allLabelRx(
//         limit: _limit,
//         page: _page,
//       );

//       final List<Datum> newData = response.data ?? [];

//       // API returned no data
//       if (newData.isEmpty) {
//         _hasMore = false;
//         _isLoading = false;
//         notifyListeners();
//         return;
//       }

//       // append data
//       _data.addAll(newData);
//       _page++;

//       // last page detected
//       if (newData.length < _limit) {
//         _hasMore = false;
//       }
//     } catch (e) {
//       _errorMessage = e.toString();
//     }

//     _isLoading = false;
//     notifyListeners();
//   }






// }

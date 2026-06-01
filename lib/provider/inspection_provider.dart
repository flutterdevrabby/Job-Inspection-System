import 'dart:developer';

import 'package:flutter/material.dart';

import '../features/inspection/data/model/all_job_response.dart';
import '../features/inspection/models/drop_down_model.dart';
import '../networks/api_acess.dart';

class InspectionProvider extends ChangeNotifier {
  // Pagination
  final int _limit = 10;
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  List<Datum> _datum = [];
  // Popup selection
  String? _selectedDateType;
  String? _customDate;

  // Search
  final _searchController = TextEditingController();
  // Filter Bottom Sheet
  DropDownModel? _selectedFilterTitle;
  String? _errorMessage;

  // Getters Method
  List<Datum> get datum => _datum;
  List<String> get dataColumeList => _dataColumeList;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  // Getter Method -> popup selection
  String? get selectedDateType => _selectedDateType;
  String? get customDate => _customDate;
  // Getter Method -> search controler
  TextEditingController get searchController => _searchController;
  // getter ->  Filter Bottom Sheet
  DropDownModel? get selectedFilterTitle => _selectedFilterTitle;

  String? get errorMessage => _errorMessage;

  // Filter dropdown
  final List<DropDownModel> filterList = [
    DropDownModel(title: "All", value: "all"),
    DropDownModel(title: "In Progress", value: "in_progress"),
    DropDownModel(title: "Submitted", value: "submitted"),
    DropDownModel(title: "Completed", value: "completed"),
    DropDownModel(title: "Rejected", value: "rejected"),
  ];

  void filterToggle(DropDownModel value) {
    _selectedFilterTitle = value;
    log("Select Filter ===========> ${_selectedFilterTitle!.value}");
    if (selectedFilterTitle!.value == "all") {
      _searchController.text = "";
      _customDate = null;
      _selectedDateType = null;
    }
    _page = 1;
    _hasMore = true;
    _datum.clear();
    notifyListeners();
    ferchAllJOBData();
  }

  // toggleDateFilter
  void toggleDateFilter({required String dateType, String? customDate}) {
    _selectedDateType = dateType;
    _customDate = customDate;
    log("DateType ===================> $_selectedDateType ");
    log("Custom Date ===================> $_customDate ");
    _page = 1;
    _hasMore = true;
    _datum.clear();
    notifyListeners();
    ferchAllJOBData();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  final List<String> _dataColumeList = [
    "FHA Case Details",
    "Order ID",
    "Address",
    "Inspector",
    "Date Due",
    "Date Submitted",
    "Status",
    "Action",
  ];

  Future<void> ferchAllJOBData() async {
    if (_isLoading || !hasMore) return;

    _isLoading = true;
    notifyListeners();

    // Fetch All Data From API
    final response = await allJobRxObj.allJobRx(
      page: _page,
      limit: _limit,
      search: _searchController.text.isEmpty ? null : _searchController.text,
      dateType: (_selectedDateType == null || _selectedDateType!.isEmpty)
          ? null
          : _selectedDateType,
      customDate: (_customDate == null || _customDate!.isEmpty)
          ? null
          : _customDate,

      status:
          (_selectedFilterTitle?.value == null ||
              _selectedFilterTitle!.value!.isEmpty)
          ? null
          : _selectedFilterTitle!.value == "all"
          ? null
          : _selectedFilterTitle!.value,
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

  // Searching Function
  void onSearchChanged(String value) {
    _searchController.text = value;
    _page = 1;
    _hasMore = true;
    _datum.clear();
    notifyListeners();
    ferchAllJOBData();
  }

void refresh() async {
    _datum.clear();
    _page = 1;
    _hasMore = true;
    _errorMessage = null;
    notifyListeners();
    await ferchAllJOBData();
  }
}

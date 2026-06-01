import 'package:artneidich_app/features/archive_settings/data/model/archive_setting_response.dart';
import 'package:flutter/material.dart';

import '../networks/api_acess.dart';

class ArchiveSettingsProvider extends ChangeNotifier {
  ArchiveSettingsProvider() {
    fetchArchiveSettings();
  }
  int _initialValue = 7; // Default to 7 days
  int get initialValue => _initialValue;

  void updateSelectedOption(int? newValue) {
    _initialValue = newValue ?? 7;

    notifyListeners();
  }

  List<Map<String, dynamic>> archiveList = [
    {'title': 'After 7 days', 'value': 7},
    {'title': 'After 15 days', 'value': 15},
    {'title': 'After 30 days', 'value': 30},
    {'title': 'After 60 days', 'value': 60},
    {'title': 'After 120 days', 'value': 120},
  ];

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Data? _data;
  Data? get data => _data;
  Future<void> fetchArchiveSettings() async {
    try {
      var response = await archiveSettingFetchRxObj.archiveSettingFetchRx();
      _data = response.data;
      _initialValue = _data?.autoArchiveDays ?? 7;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

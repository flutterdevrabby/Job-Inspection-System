import 'package:flutter/material.dart';

class PrivacyPolicyProvider extends ChangeNotifier {
  PrivacyPolicyProvider() {
    fetchPolicy();
  }
  bool _isloading = true;
  String _errorMessage = "";
  String _data = "";

  // Getter
  bool get isloading => _isloading;
  String get errorMessage => _errorMessage;
  String get data => _data;

  Future<void> fetchPolicy() async {
    try {} catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }
}

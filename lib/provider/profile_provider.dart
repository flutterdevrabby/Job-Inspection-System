import 'package:flutter/material.dart';

import '../features/profile/data/rx_get_profile/model/profile_response_model.dart';
import '../networks/api_acess.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider() {
    fetchProfile();
  }

  Data? data;

  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProfile() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await profileRxObj.profileRx();
      data = response.data;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

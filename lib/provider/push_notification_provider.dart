import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

import '../features/inspector_role/inspect_notification/rx_get_state/model/notification_state_response.dart';
import '../networks/api_acess.dart';

class PushNotificationProvider extends ChangeNotifier {
  Data? data;
  final pushController = ValueNotifier<bool>(false);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Track if we've already fetched initial state
  bool _hasInitialized = false;
  bool get hasInitialized => _hasInitialized;

  // Extract device ID logic to avoid duplication
  Future<String> _getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? "";
    }

    return "";
  }

  Future<void> updatePushStatus(bool value) async {
    if (_isLoading) return;

    // Store previous value for rollback
    final previousValue = pushController.value;

    log("User toggled switch to: $value (previous: $previousValue)");

    // Optimistic update - UI responds immediately
    pushController.value = value;

    _isLoading = true;
    notifyListeners();

    try {
      final deviceId = await _getDeviceId();

      log("Calling API to toggle notification - Device ID: $deviceId");

      final response = await notificationOnOffRxObj.notificationOnOffRx(
        deviceId: deviceId,
      );

      log("API Response: ${response.data?.notificationActive}");

      // Update from API response (should match optimistic update)
      data = response.data;
      final apiValue = data?.notificationActive ?? previousValue;

      pushController.value = apiValue;

      log("Switch updated to API value: $apiValue");
    } catch (e) {
      // Rollback to previous value if API fails
      pushController.value = previousValue;

      log('Failed to update notification status: $e');
      debugPrint('Failed to update notification status: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch only if not already initialized, or force refresh
  Future<void> fetchNotificationState({bool forceRefresh = false}) async {
    // Skip if already initialized and not forcing refresh
    if (_hasInitialized && !forceRefresh) {
      log(
        "Already initialized, skipping fetch. Current value: ${pushController.value}",
      );
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final deviceId = await _getDeviceId();

      log("Fetching notification state - Device ID: $deviceId");

      final response = await notificationStateRXObj.notificationStateRX(
        deviceId: deviceId,
      );

      log("API Response Data: ${response.data}");

      data = response.data;
      final apiValue = data?.notificationActive ?? false;

      log("Setting switch value from API: $apiValue");

      pushController.value = apiValue;
      _hasInitialized = true;

      log("Switch controller value is now: ${pushController.value}");
    } catch (e) {
      log('Failed to fetch notification state: $e');
      debugPrint('Failed to fetch notification state: $e');
      pushController.value = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method to refresh state (call this when you need fresh data)
  Future<void> refreshNotificationState() async {
    log("Force refreshing notification state...");
    await fetchNotificationState(forceRefresh: true);
  }

  // Reset initialization flag (useful if you want to force fetch next time)
  void resetInitialization() {
    _hasInitialized = false;
    log("Initialization flag reset");
  }
  

  @override
  void dispose() {
    pushController.dispose();
    super.dispose();
  }
}

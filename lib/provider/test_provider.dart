import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

import '../networks/api_acess.dart';

class TestProvider extends ChangeNotifier {
  TestProvider() {
    _getDeviceId();
    updatePushStatus();
  }
  Future<String> _getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      log("device Android ID... $androidInfo");
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      log("device IOS ID... ${iosInfo.identifierForVendor}");
      return iosInfo.identifierForVendor ?? "";
    }
    return "";
  }

  bool _isSwitch = false;

  bool get isSwitch => _isSwitch;

  void toggleSwitch() {
    _isSwitch = !_isSwitch;
    notifyListeners();
  }

  bool _isSwitchApi = false;
  bool get isSwitchApi => _isSwitchApi;

  Future<void> getNotificationStatus() async {
    final deviceId = await _getDeviceId();
    //  log("User toggled switch to: $value");
    // Here you would call your API to update the push notification status
    // For example:
    // await ApiService.updatePushStatus(value);

    final response = await notificationStateRXObj.notificationStateRX(
      deviceId: deviceId,
    );
    _isSwitchApi = response.data?.notificationActive ?? false;

    notifyListeners();

    log("API Response: ${response.data}");
  }

  Future<void> updatePushStatus() async {
    final deviceId = await _getDeviceId();

    final response = await notificationOnOffRxObj.notificationOnOffRx(
      deviceId: deviceId,
    );
    log("Update API Response: ${response.data}");
  }
}

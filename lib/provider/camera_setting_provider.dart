import 'package:flutter/material.dart';

class CameraSettingProvider extends ChangeNotifier {
  final controller = ValueNotifier<bool>(false);

  bool isCamera = false;

  void toggleUpdateCamera(bool value) {
    controller.value = value;
    isCamera = value;
    notifyListeners();
  }

  // Notification

  final pushController = ValueNotifier<bool>(false);

  bool isPush = false;

  void toggleUpdatePush(bool value) {
    pushController.value = value;
    isPush = value;
    notifyListeners();
  }
}

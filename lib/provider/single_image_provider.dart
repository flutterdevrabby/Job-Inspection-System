import 'dart:io';

import 'package:artneidich_app/helpers/toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SingleImageProvider extends ChangeNotifier {
  File? _file;

  File? get file => _file;

  final _imagePicker = ImagePicker();

  Future<void> singleImagePicked() async {
    XFile? pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      _file = File(pickedImage.path);
      debugPrint("SingleImagePATH ==========================> $_file");
    } else {
      ToastUtil.showShortToast("You havn't any selected Image");
    }
    notifyListeners();
  }
}

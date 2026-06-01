import 'dart:io';

import 'package:artneidich_app/helpers/toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaProvider extends ChangeNotifier {
  File? _file;

  File? get file => _file;

  final image = ImagePicker();

  Future<void> getImagePicker({required ImageSource source}) async {
    XFile? imageFile = await image.pickImage(source: source);
    if (imageFile != null) {
      _file = File(imageFile.path);
    } else {
      ToastUtil.showErrorLongToast("You havn't selected any images");
    }
    notifyListeners();
  }
}

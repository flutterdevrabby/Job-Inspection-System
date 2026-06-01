import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MultipleImageProvider extends ChangeNotifier {
  final List<File> _fileList = [];
  final ImagePicker _imagePicker = ImagePicker();

  List<File> get fileList => _fileList;

  File? get latestFile => _fileList.isNotEmpty ? _fileList.last : null;

  Future<void> pickedIMage({required ImageSource imageSource}) async {
    final XFile? pickedFile = await _imagePicker.pickImage(source: imageSource);

    if (pickedFile != null) {
      _fileList.add(File(pickedFile.path));
      notifyListeners();
    }
  }
}

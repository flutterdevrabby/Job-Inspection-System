import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CameraProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  final List<XFile> _images = [];
  bool _isLoading = false;

  List<XFile> get images => _images;
  bool get isLoading => _isLoading;

  // Camera (Landscape)
  Future<void> addImageFromCamera() async {
    _isLoading = true;
    notifyListeners();

    try {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);

      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image != null) {
        _images.add(image); // list এ add
      }
    } catch (e) {
      debugPrint("Camera error: $e");
    } finally {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      _isLoading = false;
      notifyListeners();
    }
  }

  /// Remove image
  void removeImage(int index) {
    _images.removeAt(index);
    notifyListeners();
  }

  ///  Clear all
  void clearImages() {
    _images.clear();
    notifyListeners();
  }
}

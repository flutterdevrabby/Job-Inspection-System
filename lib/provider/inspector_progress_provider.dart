import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../features/inspector_role/inspection_progress/model/inspector_label_model.dart';
import '../helpers/toast.dart';

class InspectorProgressProvider extends ChangeNotifier {
  List<InspectorLabelModel> inspectorList = [];

  /// Create label with 2 empty image slots
  void createLabel({required String labelID, required String labelName}) {
    inspectorList.add(
      InspectorLabelModel(
        labelID: labelID,
        labelName: labelName,
        images: List<File?>.filled(1, null),
      ),
    );
    notifyListeners();
  }

  // Pick image for specific label & slot
  Future<void> pickedImage({
    required int labelIndex,
    required int imageIndex,
    required ImageSource imageSource,
  }) async {
    final ImagePicker imagePicker = ImagePicker();

    XFile? img = await imagePicker.pickImage(source: imageSource);

    if (img != null) {
      inspectorList[labelIndex].images![imageIndex] = File(img.path);
    } else {
      ToastUtil.showShortToast("You haven't selected any image");
    }

    notifyListeners();
  }

  /// Remove image
  void removeImage(int labelIndex, int imageIndex) {
    inspectorList[labelIndex].images![imageIndex] = null;
    notifyListeners();
  }

  /// Remove label
  void removeLabel(int index) {
    inspectorList.removeAt(index);
    notifyListeners();
  }

  bool hasAnyImage() {
    return inspectorList.any(
      (label) =>
          label.images != null && label.images!.any((img) => img != null),
    );
  }

  bool allLabelsEmpty() {
    return inspectorList.isNotEmpty &&
        inspectorList.every(
          (label) =>
              label.images == null || label.images!.every((img) => img == null),
        );
  }

  /// Check if every label has at least one image
  bool everyLabelHasAtLeastOneImage() {
    if (inspectorList.isEmpty) return false;

    return inspectorList.every(
      (label) =>
          label.images != null && label.images!.any((img) => img != null),
    );
  }

  // Clear all
  void clearAllData() {
    inspectorList.clear();
    notifyListeners();
  }
}

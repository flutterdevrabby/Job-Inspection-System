import 'package:artneidich_app/common_widget/custom_button.dart';
import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../provider/media_provider.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MediaProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(title: Text("Media")),

          body: Column(
            spacing: 50,
            children: [
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: provider.file == null
                      ? Image.asset(Assets.images.avatar.path)
                      : Image.file(provider.file!),
                ),
              ),

              CustomButton(
                onPressed: () async {
                  await provider.getImagePicker(source: ImageSource.camera);
                },
                text: "Pick Camera",
              ),
              CustomButton(
                onPressed: () async {
                  await provider.getImagePicker(source: ImageSource.gallery);
                },
                text: "Pick Gallery",
              ),
            ],
          ),
        );
      },
    );
  }
}

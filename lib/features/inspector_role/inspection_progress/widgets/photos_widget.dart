import 'dart:developer';
import 'dart:io';

import 'package:artneidich_app/common_widget/media_widget.dart';
import 'package:artneidich_app/helpers/all_routes.dart';
import 'package:artneidich_app/helpers/navigation_service.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../provider/inspector_progress_provider.dart';

class LabelPhotosWidget extends StatelessWidget {
  final InspectorProgressProvider provider;
  final int labelIndex;
  final String labelName;

  const LabelPhotosWidget({
    super.key,
    required this.provider,
    required this.labelIndex,
    required this.labelName,
  });

  @override
  Widget build(BuildContext context) {
    log("Label Name ===================== $labelName");
    final images = provider.inspectorList[labelIndex].images;
    return Padding(
      padding: EdgeInsets.only(left: 16.w),
      child: AnimationLimiter(
        child: GridView.builder(
          itemCount: images!.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.6,
          ),
          itemBuilder: (context, index) {
            final File? file = images[index];

            log("FIle IMagebb ==================== $file");

            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 375),
              columnCount: 1,
              child: ScaleAnimation(
                child: GestureDetector(
                  onTap: () async {
                    await showModalBottomSheet(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10.r),
                      ),

                      context: context,
                      builder: (_) {
                        return SizedBox(
                          child: MediaWidget(
                            provider: provider,
                            labelIndex: labelIndex,
                            imageIndex: index,
                          ),
                        );
                      },
                    );
                  },
                  child: FadeInAnimation(
                    child: file == null
                        ? DottedBorder(
                            options: RectDottedBorderOptions(
                              dashPattern: [4, 2],
                              strokeWidth: 1,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add_a_photo_outlined,
                                size: 20.sp,
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              NavigationService.navigateToWithArgs(
                                Routes.photoViewerScreen,
                                {
                                  "labelName": labelName,
                                  "imagePath": file.path,
                                },
                              );
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    10.r,
                                  ),
                                  child: Image.file(
                                    file,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                                Positioned(
                                  top: -5.h,
                                  right: -5.w,
                                  child: GestureDetector(
                                    onTap: () {
                                      provider.removeImage(labelIndex, index);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(
                                          alpha: 0.5,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      padding: EdgeInsets.all(2.w),
                                      child: Icon(
                                        Icons.cancel_outlined,
                                        size: 16.sp,
                                        color: Colors.red,
                                        //
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

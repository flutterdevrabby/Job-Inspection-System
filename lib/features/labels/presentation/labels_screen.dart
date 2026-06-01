import 'package:artneidich_app/gen/assets.gen.dart';
import 'package:artneidich_app/helpers/ui_helpers.dart';
import 'package:artneidich_app/provider/label_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../common_widget/create_job.dart';
import '../../../common_widget/label_header_widget.dart';
import '../../../constants/text_font_style.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/loading_helper.dart';
import '../../../helpers/navigation_service.dart';
import '../../../helpers/toast.dart';
import '../../../networks/api_acess.dart';
import '../widgets/update_label.dart';

class LabelsScreen extends StatefulWidget {
  const LabelsScreen({super.key});

  @override
  State<LabelsScreen> createState() => _LabelsScreenState();
}

class _LabelsScreenState extends State<LabelsScreen> {
  final labelnameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final provider = context.read<LabelProvider>();

      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          provider.hasMore &&
          !provider.isLoading) {
        provider.fetchAllLabel();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    labelnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LabelProvider>(
      builder: (context, labelProvider, child) {
        return Scaffold(
          body: Column(
            children: [
              LabelHeaderWidget(
                title: "Labels",
                icon: Assets.icons.label.path,
                subtitle: "Total Labels",
              ),

              // UIHelper.verticalSpace(20.h),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: EdgeInsets.all(12.sp),
                    child: Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        ...labelProvider.data.map(
                          (item) => Builder(
                            builder: (BuildContext itemContext) {
                              return GestureDetector(
                                onTap: () async {
                                  final RenderBox button =
                                      itemContext.findRenderObject()
                                          as RenderBox;

                                  final RenderBox overlay =
                                      Overlay.of(
                                            context,
                                          ).context.findRenderObject()
                                          as RenderBox;

                                  final RelativeRect position =
                                      RelativeRect.fromRect(
                                        Rect.fromPoints(
                                          button.localToGlobal(
                                            Offset.zero,
                                            ancestor: overlay,
                                          ),
                                          button.localToGlobal(
                                            button.size.bottomRight(
                                              Offset.zero,
                                            ),
                                            ancestor: overlay,
                                          ),
                                        ),
                                        Offset.zero & overlay.size,
                                      );

                                  showMenu(
                                    context: context,
                                    position: position,
                                    items: [
                                      PopupMenuItem(
                                        value: 'edit',
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              size: 20.sp,
                                              color: Colors.blue,
                                            ),
                                            UIHelper.horizontalSpace(8.w),
                                            Text(
                                              'Edit',
                                              style: TextFontStyle
                                                  .headLine14c323539InterW400
                                                  .copyWith(
                                                    color: Colors.blue,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'delete',
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.delete,
                                              size: 20.sp,
                                              color: Colors.red,
                                            ),
                                            UIHelper.horizontalSpace(8.w),
                                            Text(
                                              'Delete',
                                              style: TextFontStyle
                                                  .headLine14c323539InterW400
                                                  .copyWith(
                                                    color: Colors.red,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ).then((value) {
                                    if (value == 'edit') {
                                      // Update Label

                                      labelnameController.text =
                                          item.label ?? '';

                                      showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadiusGeometry.circular(
                                                    10.r,
                                                  ),
                                            ),
                                            content: Form(
                                              key: _formKey,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8.w,

                                                  vertical: 8.h,
                                                ),
                                                child: UpdateLabel(
                                                  labelnameController:
                                                      labelnameController,
                                                  onTap: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      updateLabelRxObj
                                                          .updateLabelRx(
                                                            label:
                                                                labelnameController
                                                                    .text,
                                                            id: item.id!,
                                                          )
                                                          .waitingForFuture()
                                                          .then((success) {
                                                            if (success) {
                                                              context
                                                                  .read<
                                                                    LabelProvider
                                                                  >()
                                                                  .refreshAllLabel();
                                                              ToastUtil.showShortToast(
                                                                "Update Label successfully",
                                                              );
                                                              NavigationService
                                                                  .goBack;
                                                            }
                                                          });
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    } else if (value == 'delete') {
                                      // ignore: avoid_single_cascade_in_expression_statements
                                      deleteLabelRxObj
                                        ..deleteLabelRx(
                                          id: item.id!,
                                        ).waitingForFuture().then((success) {
                                          if (success) {
                                            context
                                                .read<LabelProvider>()
                                                .refreshAllLabel();
                                            ToastUtil.showShortToast(
                                              "Delete Label successfully",
                                            );
                                          }
                                        });
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF2D8D7C,
                                    ).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    item.label ?? '',
                                    style: TextFontStyle
                                        .headLine14c323539InterW400,

                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        if (labelProvider.isLoading && labelProvider.hasMore)
                          Padding(
                            padding: EdgeInsets.all(16.sp),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF2D8D7C),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          floatingActionButton: CreateJob(
            heroTag: "new_label_tag",
            title: 'Create new Label',
            onpressed: () {
              NavigationService.navigateTo(Routes.createLabelScreen);
            },
          ),
        );
      },
    );
  }
}

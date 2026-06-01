import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:artneidich_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../provider/notification_provider.dart';
import '../../provider/profile_provider.dart';
import '../overview/widgets/activity_widget.dart';
import 'widgets/notification_bar_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
     // context.read<NotificationProvider>().fetchNotificationData();
      final provider = context.read<NotificationProvider>();
      provider.reset();
      provider.setPagination(true);
      provider.fetchNotificationData();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<NotificationProvider>().fetchNotificationData();
      }
    });
  }

  String fName = "";

@override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<ProfileProvider>(
                builder: (context, provider, child) {
                  fName = provider.data?.firstName ?? "";
                  return NotificationBarWidget(
                    email: provider.data?.email ?? "",
                    fName: provider.data?.firstName ?? "",
                    name:
                        "${provider.data?.firstName ?? ""} ${provider.data?.lastName ?? ""}",
                  );
                },
              ),

              UIHelper.verticalSpace(20.h),
              Text(
                "Notification",
                style: TextFontStyle.headLine16c141414InterW400.copyWith(
                  color: const Color(0xFF8E8E93),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              UIHelper.verticalSpace(16.h),

              Consumer<NotificationProvider>(
                builder: (context, provider, child) {
                  //  First time loading
                  if (provider.isLoading && provider.data.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF2D8D7C),
                        ),
                      ),
                    );
                  }

                  //  No notification available
                  if (provider.data.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_off_outlined,
                              size: 48.sp,
                              color: Colors.grey,
                            ),
                            UIHelper.verticalSpace(12.h),
                            Text(
                              "No notifications available",
                              style: TextFontStyle.headLine16c141414InterW400
                                  .copyWith(
                                    color: Colors.grey,
                                    fontSize: 14.sp,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.separated(
                      controller: _scrollController,
                      physics: ClampingScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          Divider(color: Colors.black.withValues(alpha: 0.1)),
                      itemCount:
                          provider.data.length +
                          ((provider.hasMore && provider.isLoading) ? 1 : 0),

                     
                      padding: EdgeInsets.zero,
                      itemBuilder: (_, index) {
                        if (index == provider.data.length) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF2D8D7C),
                            ),
                          );
                        }

                        final data = provider.data[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: ActivityWidget(
                            fName: fName,
                            title: data.title ?? "",
                            subtitle: data.body ?? "",
                            time: DateFormat.yMMMMd().format(
                              data.createdAt ?? DateTime.now(),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              UIHelper.verticalSpace(20.h),
            ],
          ),
        ),
      ),
    );
  }
}

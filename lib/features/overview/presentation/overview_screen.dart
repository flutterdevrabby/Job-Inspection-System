import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:artneidich_app/features/overview/widgets/activity_widget.dart';
import 'package:artneidich_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../common_widget/create_job.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/navigation_service.dart';
import '../../../provider/admin_overview_provider.dart';
import '../../../provider/notification_provider.dart';
import '../../../provider/profile_provider.dart';
import '../widgets/job_section_widget.dart';
import '../widgets/overview_app_bar_widget.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().fetchProfile();
      final provider = context.read<NotificationProvider>();
      provider.reset();
      provider.setPagination(false);
      provider.fetchNotificationData();
    });
  }

  String fName = "";
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminOverviewProvider>(
      builder: (context, adminOverviewProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<ProfileProvider>(
                    builder: (context, profileProvider, child) {
                      if (profileProvider.isLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF2D8D7C),
                          ),
                        );
                      }
                      return OverviewAppBarWidget(
                        email: profileProvider.data?.email ?? "",
                        fName: profileProvider.data?.firstName ?? "",
                        name:
                            "${profileProvider.data?.firstName ?? ""} ${profileProvider.data?.lastName ?? ""}",
                      );
                    },
                  ),

                  UIHelper.verticalSpace(20.h),
                  Text(
                    "Summary",
                    style: TextFontStyle.headLine16c141414InterW400.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                    ),
                  ),
                  UIHelper.verticalSpace(8.h),

                  Flexible(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await adminOverviewProvider.fetchAdminOverviewData();
                      },
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        children: [
                          // Summary Widget
                          JobSection(
                            title: 'Total Jobs',
                            subtitle:
                                '${adminOverviewProvider.data?.data?.totalJobs.toString() ?? 0}',
                            icon: Icons.star_border,
                            iconColor: Colors.black,
                          ),
                          JobSection(
                            title: 'Pending',
                            subtitle:
                                '${adminOverviewProvider.data?.data?.inProgressJobs.toString() ?? 0}',
                            icon: Icons.schedule,
                            iconColor: Colors.orange,
                          ),
                          JobSection(
                            title: 'Overdue',
                            icon: Icons.block,
                            subtitle:
                                '${adminOverviewProvider.data?.data?.overDueJobs ?? 0}',
                            iconColor: Colors.red,
                          ),
                          JobSection(
                            title: 'Completed Today',
                            icon: Icons.check,
                            subtitle:
                                '${adminOverviewProvider.data?.data?.completedJobs.toString() ?? 0}',
                            iconColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ),

                  UIHelper.verticalSpace(24.h),
                  Consumer<NotificationProvider>(
                    builder: (context, provider, child) {
                      return provider.data.isNotEmpty
                          ? Text(
                              "Activity",
                              style: TextFontStyle.headLine16c141414InterW400
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13.sp,
                                  ),
                            )
                          : SizedBox.shrink();
                    },
                  ),

                  UIHelper.verticalSpace(10.h),

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
                                  style: TextFontStyle
                                      .headLine16c141414InterW400
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
                          physics: ClampingScrollPhysics(),
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.black.withValues(alpha: 0.1),
                          ),
                          itemCount:
                              provider.data.length +
                              ((provider.hasMore && provider.isLoading)
                                  ? 1
                                  : 0),

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
          floatingActionButton: CreateJob(
            heroTag: "overview_screen_tag",
            title: 'Create New Job',
            onpressed: () {
              NavigationService.navigateTo(Routes.createJobScreen);
            },
          ),
        );
      },
    );
  }
}

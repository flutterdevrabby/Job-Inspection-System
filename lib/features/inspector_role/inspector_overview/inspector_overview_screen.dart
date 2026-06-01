import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:artneidich_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../provider/inspector_overview_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../overview/widgets/job_section_widget.dart';
import '../widgets/inspector_overview_widget.dart';

class InspectorOverviewScreen extends StatefulWidget {
  const InspectorOverviewScreen({super.key});

  @override
  State<InspectorOverviewScreen> createState() =>
      _InspectorOverviewScreenState();
}

class _InspectorOverviewScreenState extends State<InspectorOverviewScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().fetchProfile();
    });
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
                builder: (context, profileProvider, child) {
                  if (profileProvider.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF2D8D7C),
                      ),
                    );
                  } 
                    return InspectorOverviewAppBarWidget(
                      email: profileProvider.data?.email ?? "",
                      fName: profileProvider.data?.firstName ?? "",
                      name:
                          "${profileProvider.data?.firstName ?? ""} ${profileProvider.data?.lastName ?? ""}",
                    );
                
                },
              ),

              UIHelper.verticalSpace(30.h),
              Text(
                "Summary",
                style: TextFontStyle.headLine16c141414InterW400.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                ),
              ),
              UIHelper.verticalSpace(8.h),

              // REFRESAH INDICATOR ADDED
              Expanded(
                child: RefreshIndicator(
                  color: Color(0xFF2D8D7C),
                  onRefresh: () async {
                    await Provider.of<InspectorOverviewProvider>(
                      context,
                      listen: false,
                    ).fetchInspectorOverviewData();
                  },
                  child: Consumer<InspectorOverviewProvider>(
                    builder: (context, provider, child) {
                      return ListView(
                        physics: AlwaysScrollableScrollPhysics(),
                        children: [
                          JobSection(
                            title: 'Total Jobs',
                            subtitle:
                                provider.data?.data?.totalJobs.toString() ??
                                '0',
                            icon: Icons.star_border,
                            iconColor: Colors.black,
                          ),
                          JobSection(
                            title: 'Pending',
                            subtitle:
                                provider.data?.data?.inProgressJobs
                                    .toString() ??
                                '0',
                            icon: Icons.schedule,
                            iconColor: Colors.orange,
                          ),
                          JobSection(
                            title: 'Overdue',
                            icon: Icons.block,
                            subtitle:
                                provider.data?.data?.overDueJobs.toString() ??
                                '0',
                            iconColor: Colors.red,
                          ),
                          JobSection(
                            title: 'Completed Today',
                            icon: Icons.check,
                            subtitle:
                                provider.data?.data?.completedJobs.toString() ??
                                '0',
                            iconColor: Colors.green,
                          ),
                          UIHelper.verticalSpace(20.h),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class _InspectorOverviewScreenState extends State<InspectorOverviewScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<InspectorOverviewProvider>(
//       builder: (context, provider, child) {
//         return Scaffold(
//           backgroundColor: Colors.white,

//           body: RefreshIndicator(
//             onRefresh: () async {
//               await Future.delayed(Duration(seconds: 2));
//             },
//             child: SingleChildScrollView(
//               padding: EdgeInsets.symmetric(horizontal: 16.w),
//               physics: AlwaysScrollableScrollPhysics(),
//               child: SafeArea(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Consumer<ProfileProvider>(
//                       builder: (context, provider, child) {
//                         //  Loading state
//                         if (provider.isLoading) {
//                           return Center(
//                             child: CircularProgressIndicator(
//                               color: Color(0xFF2D8D7C),
//                             ),
//                           );
//                         }

//                         // Error state
//                         if (provider.errorMessage != null) {
//                           return Center(
//                             child: Text(
//                               provider.errorMessage!,
//                               style: TextStyle(
//                                 color: Colors.red,
//                                 fontSize: 16.sp,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           );
//                         }

//                         //  Data loaded successfully

//                         return InspectorOverviewAppBarWidget(
//                           email: provider.data?.email ?? "",
//                           fName: provider.data?.firstName ?? "",
//                           name:
//                               "${provider.data?.firstName ?? ""} ${provider.data?.lastName ?? ""}",
//                         );
//                       },
//                     ),

//                     UIHelper.verticalSpace(30.h),
//                     Text(
//                       "Summary",
//                       style: TextFontStyle.headLine16c141414InterW400.copyWith(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 13.sp,
//                       ),
//                     ),
//                     UIHelper.verticalSpace(8.h),

//                     // Summary Widget
//                     JobSection(
//                       title: 'Total Jobs',
//                       subtitle:
//                           provider.data?.data?.totalJobs.toString() ?? '0',
//                       icon: Icons.star_border,
//                       iconColor: Colors.black,
//                     ),
//                     JobSection(
//                       title: 'Pending',
//                       subtitle:
//                           provider.data?.data?.inProgressJobs.toString() ?? '0',
//                       icon: Icons.schedule,
//                       iconColor: Colors.orange,
//                     ),
//                     JobSection(
//                       title: 'Overdue',
//                       icon: Icons.block,
//                       subtitle:
//                           provider.data?.data?.overDueJobs.toString() ?? '0',
//                       iconColor: Colors.red,
//                     ),
//                     JobSection(
//                       title: 'Completed Today',
//                       icon: Icons.check,
//                       subtitle:
//                           provider.data?.data?.completedJobs.toString() ?? '0',
//                       iconColor: Colors.green,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

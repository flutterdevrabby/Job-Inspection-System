import 'package:artneidich_app/provider/admin_provider.dart';
import 'package:artneidich_app/provider/assign_inspector_provider.dart';
import 'package:artneidich_app/provider/profile_provider.dart';
import 'package:artneidich_app/provider/reset_password_provider.dart';
import 'package:artneidich_app/provider/single_image_provider.dart';
import 'package:provider/provider.dart';

import '../provider/admin_overview_provider.dart';
import '../provider/archive_list_provider.dart';
import '../provider/archive_settings_provider.dart';
import '../provider/camera_setting_provider.dart';
import '../provider/create_job_provider.dart';
import '../provider/inspection_id_provider.dart';
import '../provider/inspection_provider.dart';
import '../provider/inspector_label_provider.dart';
import '../provider/inspector_list_provider.dart';
import '../provider/inspector_overview_provider.dart';
import '../provider/inspector_progress_provider.dart';
import '../provider/job_details_provider.dart';
import '../provider/label_provider.dart';
import '../provider/media_provider.dart';
import '../provider/multiple_image_provider.dart';
import '../provider/notification_provider.dart';
import '../provider/otp_provider.dart';
import '../provider/pdf_provider.dart';
import '../provider/push_notification_provider.dart';
import '../provider/role_provider.dart';
import '../provider/signin_provider.dart';
import '../provider/signup_provider.dart';
import '../provider/test_provider.dart';

var providers = [
  ChangeNotifierProvider<PdfProvider>(create: ((context) => PdfProvider())),

  ChangeNotifierProvider<AssignInspectorProvider>(
    create: ((context) => AssignInspectorProvider()),
  ),

  //New
  ChangeNotifierProvider<SignupProvider>(
    create: ((context) => SignupProvider()),
  ),
  ChangeNotifierProvider<SigninProvider>(
    create: ((context) => SigninProvider()),
  ),
  ChangeNotifierProvider<OtpProvider>(create: ((context) => OtpProvider())),
  ChangeNotifierProvider<ResetPasswordProvider>(
    create: ((context) => ResetPasswordProvider()),
  ),

  ChangeNotifierProvider<RoleProvider>(create: ((context) => RoleProvider())),

  ChangeNotifierProvider<CameraSettingProvider>(
    create: ((context) => CameraSettingProvider()),
  ),

  ChangeNotifierProvider<PushNotificationProvider>(
    create: ((context) => PushNotificationProvider()),
  ),

  ChangeNotifierProvider<LabelProvider>(create: ((context) => LabelProvider())),

  ChangeNotifierProvider<InspectorProgressProvider>(
    create: ((context) => InspectorProgressProvider()),
  ),
  ChangeNotifierProvider<CreateJobProvider>(
    create: ((context) => CreateJobProvider()),
  ),

  ChangeNotifierProvider<InspectionProvider>(
    create: ((context) => InspectionProvider()),
  ),
  ChangeNotifierProvider<JobDetailsProvider>(
    create: ((context) => JobDetailsProvider()),
  ),

  ChangeNotifierProvider<AdminProvider>(create: ((context) => AdminProvider())),

  ChangeNotifierProvider<AdminOverviewProvider>(
    create: ((context) => AdminOverviewProvider()),
  ),
  ChangeNotifierProvider<InspectorOverviewProvider>(
    create: ((context) => InspectorOverviewProvider()),
  ),
  ChangeNotifierProvider<InspectorLabelProvider>(
    create: ((context) => InspectorLabelProvider()),
  ),

  ChangeNotifierProvider<SingleImageProvider>(
    create: ((context) => SingleImageProvider()),
  ),

  ChangeNotifierProvider<MultipleImageProvider>(
    create: ((context) => MultipleImageProvider()),
  ),

  ChangeNotifierProvider<InspectionIdProvider>(
    create: ((context) => InspectionIdProvider()),
  ),
  ChangeNotifierProvider<NotificationProvider>(
    create: ((context) => NotificationProvider()),
  ),
  ChangeNotifierProvider<ProfileProvider>(
    create: ((context) => ProfileProvider()),
  ),

  ChangeNotifierProvider<InspectorListProvider>(
    create: ((context) => InspectorListProvider()),
  ),

  // ChangeNotifierProvider<AcknowledgeProvider>(
  //   create: ((context) => AcknowledgeProvider()),
  // ),
  ChangeNotifierProvider<TestProvider>(create: ((context) => TestProvider())),
  ChangeNotifierProvider<ArchiveSettingsProvider>(
    create: ((context) => ArchiveSettingsProvider()),
  ),
  ChangeNotifierProvider<ArchiveListProvider>(
    create: ((context) => ArchiveListProvider()),
  ),
  ChangeNotifierProvider<MediaProvider>(create: ((context) => MediaProvider())),
];

//

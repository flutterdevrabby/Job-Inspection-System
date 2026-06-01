import 'package:rxdart/subjects.dart';

import '../features/archive_list/data/model/archive_response.dart';
import '../features/archive_list/data/rx_delete/rx.dart';
import '../features/archive_list/data/rx_get_report/rx.dart';
import '../features/archive_list/data/rx_restore/rx.dart';
import '../features/archive_settings/data/model/archive_setting_response.dart';
import '../features/archive_settings/data/rx_get/rx.dart';
import '../features/archive_settings/data/rx_patch/rx.dart';
import '../features/authentication/forget_password/data/rx.dart';
import '../features/authentication/otp_verified/data/rx.dart';
import '../features/authentication/reset_password/data/rx.dart';
import '../features/authentication/sign_in/data/rx.dart';
import '../features/authentication/sign_up/data/rx.dart';
import '../features/create_job/data/rx_get_all_user/model/all_user_response.dart';
import '../features/create_job/data/rx_get_all_user/rx.dart';
import '../features/create_job/data/rx_post_create/rx.dart';
import '../features/create_label/data/rx_post/rx.dart';
import '../features/inspection/data/model/all_job_response.dart';
import '../features/inspection/data/rx_get/rx.dart';
import '../features/inspector_list/data/rx_suspend/rx.dart';
import '../features/inspector_list/data/rx_unsuspend/rx.dart';
import '../features/inspector_role/email_support/data/rx.dart';
import '../features/inspector_role/inspect_notification/rx_get_state/model/notification_state_response.dart';
import '../features/inspector_role/inspect_notification/rx_get_state/rx.dart';
import '../features/inspector_role/inspect_notification/rx_put_toggle/rx.dart';
import '../features/inspector_role/inspection_progress/data/rx_post/rx.dart';
import '../features/inspector_role/inspection_setting/data/rx.dart';
import '../features/inspector_role/inspection_view/data/rx_get/model/inspection_response.dart';
import '../features/inspector_role/inspection_view/data/rx_get/rx.dart';
import '../features/inspector_role/inspection_progress/data/rx_patch_resubmit/rx.dart';
import '../features/inspector_role/inspector_label/data/rx_get/model/inspector_label_response.dart';
import '../features/inspector_role/inspector_label/data/rx_get/rx.dart';
import '../features/inspector_role/inspector_overview/data/rx_get/model/inspector_overview_response.dart';
import '../features/inspector_role/inspector_overview/data/rx_get/rx.dart';
import '../features/job_details/data/rx_get_report/model/job_report_response.dart';
import '../features/job_details/data/rx_get_report/rx.dart';
import '../features/job_details/data/rx_get_summary/model/summary_response.dart';
import '../features/job_details/data/rx_get_summary/rx.dart';
import '../features/labels/data/rx_delete/rx.dart';
import '../features/labels/data/rx_get/model/label_response.dart';
import '../features/labels/data/rx_get/rx.dart';
import '../features/labels/data/rx_update/rx.dart';
import '../features/notification/data/rx_get_all/model/all_notification_response.dart';
import '../features/notification/data/rx_get_all/rx.dart';
import '../features/notification/data/rx_post/rx.dart';
import '../features/overview/data/rx_get/model/admin_overview_response.dart';
import '../features/overview/data/rx_get/rx.dart';
import '../features/profile/data/rx_get_profile/model/profile_response_model.dart';
import '../features/profile/data/rx_get_profile/rx.dart';
import '../features/profile/data/rx_post_profile/rx.dart';
import '../features/settings/data/rx.dart';

// Authenticate
SignupRx signupRxObj = SignupRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
SigninRx signinRxObj = SigninRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
ForgetPasswordRx forgetPasswordRxObj = ForgetPasswordRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
OtpVerifyRx otpVerifyRxObj = OtpVerifyRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
ResetPasswordRx resetPasswordRxObj = ResetPasswordRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

ProfileRx profileRxObj = ProfileRx(
  empty: ProfileResponse(),
  dataFetcher: BehaviorSubject<ProfileResponse>(),
);
UpdateProfileRx updateProfileRxObj = UpdateProfileRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
AllUserRx allUserRxObj = AllUserRx(
  empty: AllUserResponse(),
  dataFetcher: BehaviorSubject<AllUserResponse>(),
);
CreateJobRx createJobRxObj = CreateJobRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
AllJobRx allJobRxObj = AllJobRx(
  empty: AllJobResponse(),
  dataFetcher: BehaviorSubject<AllJobResponse>(),
);

SummaryRx summaryRxObj = SummaryRx(
  empty: SummaryResponse(),
  dataFetcher: BehaviorSubject<SummaryResponse>(),
);

JobReportRx jobReportRxObj = JobReportRx(
  empty: ReportResponse(),
  dataFetcher: BehaviorSubject<ReportResponse>(),
);

CreateLabelRx createLabelRxObj = CreateLabelRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

AllLabelRx allLabelRxObj = AllLabelRx(
  empty: GetLabelResponse(),
  dataFetcher: BehaviorSubject<GetLabelResponse>(),
);
DeleteLabelRx deleteLabelRxObj = DeleteLabelRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

UpdateLabelRx updateLabelRxObj = UpdateLabelRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

SuspendRx suspendRxObj = SuspendRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
UnSuspendRx unSuspendRxObj = UnSuspendRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
InspectionRx inspectionRxObj = InspectionRx(
  empty: InspectionResponse(),
  dataFetcher: BehaviorSubject<InspectionResponse>(),
);

AdminOverviewRx adminOverviewRxObj = AdminOverviewRx(
  empty: AdminOverviewResponse(),
  dataFetcher: BehaviorSubject<AdminOverviewResponse>(),
);

InspectorOverviewRx inspectorOverviewRxObj = InspectorOverviewRx(
  empty: InspectorOverviewResponse(),
  dataFetcher: BehaviorSubject<InspectorOverviewResponse>(),
);
EmailSupportRx emailSupportRxObj = EmailSupportRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

InspectorLabelRx inspectorLabelRxObj = InspectorLabelRx(
  empty: LabelInspectorResponse(),
  dataFetcher: BehaviorSubject<LabelInspectorResponse>(),
);

CreateReportRx createReportRxObj = CreateReportRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

GetAllNotificationRX getAllNotificationRXObj = GetAllNotificationRX(
  empty: GetAllNotificationResponse(),
  dataFetcher: BehaviorSubject<GetAllNotificationResponse>(),
);

RegistrationTokenRX registrationTokenRXObj = RegistrationTokenRX(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
LogoutRx logoutRxObj = LogoutRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

NotificationStateRX notificationStateRXObj = NotificationStateRX(
  empty: NotificationStateResponse(),
  dataFetcher: BehaviorSubject<NotificationStateResponse>(),
);

NotificationOnOffRx notificationOnOffRxObj = NotificationOnOffRx(
  empty: NotificationStateResponse(),
  dataFetcher: BehaviorSubject<NotificationStateResponse>(),
);

ArchiveSettingUpdateRx archiveSettingUpdateRxObj = ArchiveSettingUpdateRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
ArchiveSettingFetchRx archiveSettingFetchRxObj = ArchiveSettingFetchRx(
  empty: ArchiveSettingFetchResponse(),
  dataFetcher: BehaviorSubject<ArchiveSettingFetchResponse>(),
);
// Archive List
ArchiveListRx archiveListRxObj = ArchiveListRx(
  empty: ArchiveReportResponse(),
  dataFetcher: BehaviorSubject<ArchiveReportResponse>(),
);

ArchiveListDeleteRx archiveListDeleteRxObj = ArchiveListDeleteRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

ArchiveListRestoreRx archiveListRestoreRxObj = ArchiveListRestoreRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
DeleteUserAccountRx deleteUserAccountRxObj = DeleteUserAccountRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
InspectionResubmitJobRX inspectionResubmitJobRXObj = InspectionResubmitJobRX(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

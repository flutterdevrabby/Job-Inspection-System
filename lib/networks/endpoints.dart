// ignore_for_file: constant_identifier_names, unnecessary_string_interpolations

// const String url = String.fromEnvironment("BASE_URL");
//const String url = "http://localhost:8080/api/v1";

//const String url = "http://76.13.100.15:8080/api/v1";
//import 'package:artneidich_app/features/inpector_acknowledgement/data/rx_get/api.dart';

const String url = "https://api.domainname.com";
// ignore: unnecessary_brace_in_string_interps
const String imageUrl = "${url}";

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
  static const MULTIPART_DATA = "multipart/form-data";
}

// final class PaymentGateway {
//   PaymentGateway._();
//   static String gateway(String orderId) =>  "https://demo.vivapayments.com/web/checkout?ref={$orderId}";
// }

final class Endpoints {
  Endpoints._();
  //backend_url
  //New
  static String signUp() => "/auth/register";
  static String signin() => "/auth/login";
  static String forgetPassword() => "/auth/forgot-password";
  static String otpVerify() => "/auth/verify-otp"; // endpoint change
  static String resetPassword() => "/auth/reset-password"; // endpoint change
  static String logout() => "/auth/logout";

  // profile Update and Get
  static String getProfiles() => "/user/profile";
  static String updateProfiles() => "/user/profile";

  static String emailSupport() => "/email/support";

  // Create job from admin
  static String createJob() => "/job";

  // Create Report
  static String createReport() => "/report";

  // all user
  static String getAllUser({
    int? page,
    int? limit,
    String? search,
    int? role,
    bool? isSuspended,
    bool? isApproved,
  }) {
    final Map<String, String> queryParams = {};

    if (page != null) queryParams["page"] = page.toString();
    if (limit != null) queryParams["limit"] = limit.toString();
    if (search != null && search.trim().isNotEmpty) {
      queryParams["search"] = search;
    }
    if (role != null) queryParams["role"] = role.toString();
    if (isSuspended != null) {
      queryParams["isSuspended"] = isSuspended.toString();
    }
    if (isApproved != null) queryParams["isApproved"] = isApproved.toString();

    final uri = Uri.parse(
      "/user",
    ).replace(queryParameters: queryParams.isEmpty ? null : queryParams);

    return uri.toString();
  }

  // All Job

  static String getAllJob({
    int? page,
    int? limit,
    String? search,
    String? status,

    /// allowed values: this_month, previous_month, custom
    String? dateType,

    /// only required when dateType == custom
    String? customDate,
  }) {
    final Map<String, String> queryParams = {};

    if (page != null) queryParams["page"] = page.toString();
    if (limit != null) queryParams["limit"] = limit.toString();

    if (search != null && search.trim().isNotEmpty) {
      queryParams["search"] = search;
    }

    if (status != null && status.isNotEmpty) {
      queryParams["status"] = status;
    }

    if (dateType != null && dateType.isNotEmpty) {
      queryParams["dateType"] = dateType;

      //  only when custom
      if (dateType == "custom" && customDate != null && customDate.isNotEmpty) {
        queryParams["customDate"] = customDate;
      }
    }

    final uri = Uri.parse(
      "/job",
    ).replace(queryParameters: queryParams.isEmpty ? null : queryParams);

    return uri.toString();
  }

  // Archive  Get Report

  static String getArchiveReport({int? page, int? limit}) {
    final Map<String, String> queryParams = {};

    if (page != null) queryParams["page"] = page.toString();
    if (limit != null) queryParams["limit"] = limit.toString();

    final uri = Uri.parse(
      "/report/archive/list",
    ).replace(queryParameters: queryParams.isEmpty ? null : queryParams);

    return uri.toString();
  }

  static String deleteArchiveReport() => "/report/archive/permanent";
  static String restoreArchiveReport() => "/report/archive/restore";

  // static String getAllJob({
  //   int? page,
  //   int? limit,
  //   String? search,
  //   String? status,
  //   String? custom,
  // }) {
  //   final Map<String, String> queryParams = {};

  //   if (page != null) queryParams["page"] = page.toString();
  //   if (limit != null) queryParams["limit"] = limit.toString();
  //   if (search != null && search.trim().isNotEmpty) {
  //     queryParams["search"] = search;
  //   }
  //   if (status != null) queryParams["status"] = status.toString();

  //   if (custom != null) queryParams["custom"] = custom.toString();

  //   final uri = Uri.parse(
  //     "/job",
  //   ).replace(queryParameters: queryParams.isEmpty ? null : queryParams);

  //   return uri.toString();
  // }

  // Image Label

  static String getLabel({int? page, int? limit, String? search}) {
    final Map<String, String> queryParams = {};

    if (page != null) queryParams["page"] = page.toString();
    if (limit != null) queryParams["limit"] = limit.toString();

    if (search != null && search.trim().isNotEmpty) {
      queryParams["search"] = search;
    }

    final uri = Uri.parse(
      "/image-label",
    ).replace(queryParameters: queryParams.isEmpty ? null : queryParams);

    return uri.toString();
  }

  static String logIn() => "/api/login";

  /// Job Details Summary
  static String getJob({required String id}) => "/job/$id";
  static String getReportJob({required String id}) => "/report/$id";

  // Create Label

  static String createLabel() => "/image-label";

  // update
  static String updateLabel({required String id}) => "/image-label/$id";
  // All Job
  static String getAllLabel({int? page, int? limit, String? search}) {
    final Map<String, String> queryParams = {};

    if (page != null) queryParams["page"] = page.toString();
    if (limit != null) queryParams["limit"] = limit.toString();
    if (search != null && search.trim().isNotEmpty) {
      queryParams["search"] = search;
    }

    final uri = Uri.parse(
      "/image-label",
    ).replace(queryParameters: queryParams.isEmpty ? null : queryParams);

    return uri.toString();
  }

  // Delete label
  static String deleteLabel({required String id}) => "/image-label/$id";

  // Suspend inspector User
  static String suspend({required String id}) => "/user/$id/suspend";
  // Unsuspend inspector user
  static String unSuspend({required String id}) => "/user/$id/unsuspend";

  static String resubmitJobInspector({required String id}) =>
      "/report/$id/resubmit";

  // my job inspection
  static String getMyJob({
    int? page,
    int? limit,
    String? search,
    String? dueDateFrom,
    String? dueDateTo,
  }) {
    final Map<String, String> queryParams = {};

    if (page != null) queryParams["page"] = page.toString();
    if (limit != null) queryParams["limit"] = limit.toString();
    if (search != null && search.trim().isNotEmpty) {
      queryParams["search"] = search;
    }
    if (dueDateFrom != null && dueDateFrom.trim().isNotEmpty) {
      queryParams["dueDate[from]"] = dueDateFrom;
    }
    if (dueDateTo != null && dueDateTo.trim().isNotEmpty) {
      queryParams["dueDate[to]"] = dueDateTo;
    }

    final uri = Uri.parse(
      "/job/my-jobs",
    ).replace(queryParameters: queryParams.isEmpty ? null : queryParams);

    return uri.toString();
  }

  /// getAllNotification
  static String getAllNotification({int? page, int? limit}) {
    final Map<String, String> queryParams = {};
    if (page != null) queryParams["page"] = page.toString();
    if (limit != null) queryParams["limit"] = limit.toString();
    final uri = Uri.parse(
      "/notification",
    ).replace(queryParameters: queryParams.isEmpty ? null : queryParams);
    return uri.toString();
  }

  // registration Token
  static String registrationToken() => "/notification/token";

  // upate Token
  static String toggleNotification({required String deviceId}) =>
      "/notification/$deviceId";

  static String notificationState({required String deviceId}) =>
      "/notification/notification-state/$deviceId";

  // Test Images
  // Create Report
  static String singleImageP() => "/test/single-upload";
  static String multipleImageP() => "/test/multiple-upload";

  // admin overview
  static String adminOverVIew() => "/admin/overview";
  static String inspectorOverVIew() => "/inspector/overview";
  //

  // acknowledge
  static String inspectionAcknowledge() => "/inspector-acknowledgement/";

  // Archive Setting Update
  static String archiveSettingUpdate() => "/archive-settings";

  // Archive Setting Fetch
  static String archiveSettingFetch() => "/archive-settings";

  // Delete api
  static String deleteUserId({required String id}) => "/user/$id";
}

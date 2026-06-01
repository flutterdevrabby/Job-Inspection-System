import 'dart:convert';

class AdminOverviewResponse {
  bool? success;
  String? message;
  int? code;
  Data? data;

  AdminOverviewResponse({this.success, this.message, this.code, this.data});

  AdminOverviewResponse copyWith({
    bool? success,
    String? message,
    int? code,
    Data? data,
  }) => AdminOverviewResponse(
    success: success ?? this.success,
    message: message ?? this.message,
    code: code ?? this.code,
    data: data ?? this.data,
  );

  factory AdminOverviewResponse.fromRawJson(String str) =>
      AdminOverviewResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdminOverviewResponse.fromJson(Map<String, dynamic> json) =>
      AdminOverviewResponse(
        success: json["success"],
        message: json["message"],
        code: json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "code": code,
    "data": data?.toJson(),
  };
}

class Data {
  int? totalJobs;
  int? inProgressJobs;
  int? overDueJobs;
  int? completedJobs;

  Data({
    this.totalJobs,
    this.inProgressJobs,
    this.overDueJobs,
    this.completedJobs,
  });

  Data copyWith({
    int? totalJobs,
    int? inProgressJobs,
    int? overDueJobs,
    int? completedJobs,
  }) => Data(
    totalJobs: totalJobs ?? this.totalJobs,
    inProgressJobs: inProgressJobs ?? this.inProgressJobs,
    overDueJobs: overDueJobs ?? this.overDueJobs,
    completedJobs: completedJobs ?? this.completedJobs,
  );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalJobs: json["totalJobs"],
    inProgressJobs: json["inProgressJobs"],
    overDueJobs: json["overDueJobs"],
    completedJobs: json["completedJobs"],
  );

  Map<String, dynamic> toJson() => {
    "totalJobs": totalJobs,
    "inProgressJobs": inProgressJobs,
    "overDueJobs": overDueJobs,
    "completedJobs": completedJobs,
  };
}

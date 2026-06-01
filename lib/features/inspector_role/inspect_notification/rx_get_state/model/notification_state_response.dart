import 'dart:convert';

class NotificationStateResponse {
  bool? success;
  String? message;
  Data? data;
  int? code;

  NotificationStateResponse({this.success, this.message, this.data, this.code});

  NotificationStateResponse copyWith({
    bool? success,
    String? message,
    Data? data,
    int? code,
  }) => NotificationStateResponse(
    success: success ?? this.success,
    message: message ?? this.message,
    data: data ?? this.data,
    code: code ?? this.code,
  );

  factory NotificationStateResponse.fromRawJson(String str) =>
      NotificationStateResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationStateResponse.fromJson(Map<String, dynamic> json) =>
      NotificationStateResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "code": code,
  };
}

class Data {
  String? deviceId;
  bool? notificationActive;

  Data({this.deviceId, this.notificationActive});

  Data copyWith({String? deviceId, bool? notificationActive}) => Data(
    deviceId: deviceId ?? this.deviceId,
    notificationActive: notificationActive ?? this.notificationActive,
  );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    deviceId: json["deviceId"],
    notificationActive: json["notificationActive"],
  );

  Map<String, dynamic> toJson() => {
    "deviceId": deviceId,
    "notificationActive": notificationActive,
  };
}

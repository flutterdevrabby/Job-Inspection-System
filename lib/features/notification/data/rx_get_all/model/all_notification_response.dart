import 'dart:convert';

class GetAllNotificationResponse {
  bool? success;
  String? message;
  List<Datum>? data;
  MetaData? metaData;
  int? code;

  GetAllNotificationResponse({
    this.success,
    this.message,
    this.data,
    this.metaData,
    this.code,
  });

  GetAllNotificationResponse copyWith({
    bool? success,
    String? message,
    List<Datum>? data,
    MetaData? metaData,
    int? code,
  }) => GetAllNotificationResponse(
    success: success ?? this.success,
    message: message ?? this.message,
    data: data ?? this.data,
    metaData: metaData ?? this.metaData,
    code: code ?? this.code,
  );

  factory GetAllNotificationResponse.fromRawJson(String str) =>
      GetAllNotificationResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllNotificationResponse.fromJson(Map<String, dynamic> json) =>
      GetAllNotificationResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        metaData: json["metaData"] == null
            ? null
            : MetaData.fromJson(json["metaData"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "metaData": metaData?.toJson(),
    "code": code,
  };
}

class Datum {
  String? id;
  String? title;
  String? body;
  Data? data;
  String? type;
  dynamic authorId;
  DateTime? createdAt;

  Datum({
    this.id,
    this.title,
    this.body,
    this.data,
    this.type,
    this.authorId,
    this.createdAt,
  });

  Datum copyWith({
    String? id,
    String? title,
    String? body,
    Data? data,
    String? type,
    dynamic authorId,
    DateTime? createdAt,
  }) => Datum(
    id: id ?? this.id,
    title: title ?? this.title,
    body: body ?? this.body,
    data: data ?? this.data,
    type: type ?? this.type,
    authorId: authorId ?? this.authorId,
    createdAt: createdAt ?? this.createdAt,
  );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    title: json["title"],
    body: json["body"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    type: json["type"],
    authorId: json["authorId"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "body": body,
    "data": data?.toJson(),
    "type": type,
    "authorId": authorId,
    "createdAt": createdAt?.toIso8601String(),
  };
}

class Data {
  String? userId;
  String? action;

  Data({this.userId, this.action});

  Data copyWith({String? userId, String? action}) =>
      Data(userId: userId ?? this.userId, action: action ?? this.action);

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(userId: json["userId"], action: json["action"]);

  Map<String, dynamic> toJson() => {"userId": userId, "action": action};
}

class MetaData {
  int? page;
  int? limit;
  int? totalNotifications;
  int? totalPage;

  MetaData({this.page, this.limit, this.totalNotifications, this.totalPage});

  MetaData copyWith({
    int? page,
    int? limit,
    int? totalNotifications,
    int? totalPage,
  }) => MetaData(
    page: page ?? this.page,
    limit: limit ?? this.limit,
    totalNotifications: totalNotifications ?? this.totalNotifications,
    totalPage: totalPage ?? this.totalPage,
  );

  factory MetaData.fromRawJson(String str) =>
      MetaData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
    page: json["page"],
    limit: json["limit"],
    totalNotifications: json["totalNotifications"],
    totalPage: json["totalPage"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "totalNotifications": totalNotifications,
    "totalPage": totalPage,
  };
}

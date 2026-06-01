import 'dart:convert';

class AllUserResponse {
  bool? success;
  String? message;
  List<Datum>? data;
  MetaData? metaData;
  int? code;

  AllUserResponse({
    this.success,
    this.message,
    this.data,
    this.metaData,
    this.code,
  });

  AllUserResponse copyWith({
    bool? success,
    String? message,
    List<Datum>? data,
    MetaData? metaData,
    int? code,
  }) => AllUserResponse(
    success: success ?? this.success,
    message: message ?? this.message,
    data: data ?? this.data,
    metaData: metaData ?? this.metaData,
    code: code ?? this.code,
  );

  factory AllUserResponse.fromRawJson(String str) =>
      AllUserResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllUserResponse.fromJson(Map<String, dynamic> json) =>
      AllUserResponse(
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
  String? firstName;
  String? lastName;
  String? email;
  bool? isSuspended;
  bool? isApproved;
  int? role;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? roleLabel;

  Datum({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.isSuspended,
    this.isApproved,
    this.role,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.roleLabel,
  });

  Datum copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    bool? isSuspended,
    bool? isApproved,
    int? role,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? roleLabel,
  }) => Datum(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    isSuspended: isSuspended ?? this.isSuspended,
    isApproved: isApproved ?? this.isApproved,
    role: role ?? this.role,
    userId: userId ?? this.userId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    roleLabel: roleLabel ?? this.roleLabel,
  );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    isSuspended: json["isSuspended"],
    isApproved: json["isApproved"],
    role: json["role"],
    userId: json["userId"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    roleLabel: json["roleLabel"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "isSuspended": isSuspended,
    "isApproved": isApproved,
    "role": role,
    "userId": userId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "roleLabel": roleLabel,
  };
}

class MetaData {
  int? page;
  int? limit;
  int? totalUser;
  int? totalPage;

  MetaData({this.page, this.limit, this.totalUser, this.totalPage});

  MetaData copyWith({int? page, int? limit, int? totalUser, int? totalPage}) =>
      MetaData(
        page: page ?? this.page,
        limit: limit ?? this.limit,
        totalUser: totalUser ?? this.totalUser,
        totalPage: totalPage ?? this.totalPage,
      );

  factory MetaData.fromRawJson(String str) =>
      MetaData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
    page: json["page"],
    limit: json["limit"],
    totalUser: json["totalUser"],
    totalPage: json["totalPage"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "totalUser": totalUser,
    "totalPage": totalPage,
  };
}

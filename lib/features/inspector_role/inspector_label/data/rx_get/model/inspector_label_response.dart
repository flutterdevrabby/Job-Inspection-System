import 'dart:convert';

class LabelInspectorResponse {
  bool? success;
  String? message;
  List<Datum>? data;
  MetaData? metaData;
  int? code;

  LabelInspectorResponse({
    this.success,
    this.message,
    this.data,
    this.metaData,
    this.code,
  });

  LabelInspectorResponse copyWith({
    bool? success,
    String? message,
    List<Datum>? data,
    MetaData? metaData,
    int? code,
  }) => LabelInspectorResponse(
    success: success ?? this.success,
    message: message ?? this.message,
    data: data ?? this.data,
    metaData: metaData ?? this.metaData,
    code: code ?? this.code,
  );

  factory LabelInspectorResponse.fromRawJson(String str) =>
      LabelInspectorResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LabelInspectorResponse.fromJson(Map<String, dynamic> json) =>
      LabelInspectorResponse(
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
  String? label;
  AtedBy? createdBy;
  AtedBy? lastUpdatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.label,
    this.createdBy,
    this.lastUpdatedBy,
    this.createdAt,
    this.updatedAt,
  });

  Datum copyWith({
    String? id,
    String? label,
    AtedBy? createdBy,
    AtedBy? lastUpdatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Datum(
    id: id ?? this.id,
    label: label ?? this.label,
    createdBy: createdBy ?? this.createdBy,
    lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    label: json["label"],
    createdBy: json["createdBy"] == null
        ? null
        : AtedBy.fromJson(json["createdBy"]),
    lastUpdatedBy: json["lastUpdatedBy"] == null
        ? null
        : AtedBy.fromJson(json["lastUpdatedBy"]),
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "label": label,
    "createdBy": createdBy?.toJson(),
    "lastUpdatedBy": lastUpdatedBy?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class AtedBy {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? role;

  AtedBy({this.id, this.firstName, this.lastName, this.email, this.role});

  AtedBy copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? role,
  }) => AtedBy(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    role: role ?? this.role,
  );

  factory AtedBy.fromRawJson(String str) => AtedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AtedBy.fromJson(Map<String, dynamic> json) => AtedBy(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "role": role,
  };
}

class MetaData {
  int? page;
  int? limit;
  int? totalLabel;
  int? totalPage;

  MetaData({this.page, this.limit, this.totalLabel, this.totalPage});

  MetaData copyWith({int? page, int? limit, int? totalLabel, int? totalPage}) =>
      MetaData(
        page: page ?? this.page,
        limit: limit ?? this.limit,
        totalLabel: totalLabel ?? this.totalLabel,
        totalPage: totalPage ?? this.totalPage,
      );

  factory MetaData.fromRawJson(String str) =>
      MetaData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
    page: json["page"],
    limit: json["limit"],
    totalLabel: json["totalLabel"],
    totalPage: json["totalPage"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "totalLabel": totalLabel,
    "totalPage": totalPage,
  };
}

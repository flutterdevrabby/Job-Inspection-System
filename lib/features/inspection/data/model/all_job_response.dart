import 'dart:convert';

class AllJobResponse {
  bool? success;
  String? message;
  List<Datum>? data;
  MetaData? metaData;
  int? code;

  AllJobResponse({
    this.success,
    this.message,
    this.data,
    this.metaData,
    this.code,
  });

  AllJobResponse copyWith({
    bool? success,
    String? message,
    List<Datum>? data,
    MetaData? metaData,
    int? code,
  }) => AllJobResponse(
    success: success ?? this.success,
    message: message ?? this.message,
    data: data ?? this.data,
    metaData: metaData ?? this.metaData,
    code: code ?? this.code,
  );

  factory AllJobResponse.fromRawJson(String str) =>
      AllJobResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllJobResponse.fromJson(Map<String, dynamic> json) => AllJobResponse(
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
  CreatedBy? inspector;
  String? formType;
  String? feeStatus;
  int? agreedFee;
  String? fhaCaseDetailsNo;
  String? orderId;
  String? streetAddress;
  String? developmentName;
  String? siteContactName;
  String? siteContactPhone;
  String? siteContactEmail;
  DateTime? dueDate;
  CreatedBy? createdBy;
  CreatedBy? lastUpdatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? reportStatus;
  bool? hasReport;
  String? reportStatusLabel;

  Datum({
    this.id,
    this.inspector,
    this.formType,
    this.feeStatus,
    this.agreedFee,
    this.fhaCaseDetailsNo,
    this.orderId,
    this.streetAddress,
    this.developmentName,
    this.siteContactName,
    this.siteContactPhone,
    this.siteContactEmail,
    this.dueDate,
    this.createdBy,
    this.lastUpdatedBy,
    this.createdAt,
    this.updatedAt,
    this.reportStatus,
    this.hasReport,
    this.reportStatusLabel,
  });

  Datum copyWith({
    String? id,
    CreatedBy? inspector,
    String? formType,
    String? feeStatus,
    int? agreedFee,
    String? fhaCaseDetailsNo,
    String? orderId,
    String? streetAddress,
    String? developmentName,
    String? siteContactName,
    String? siteContactPhone,
    String? siteContactEmail,
    DateTime? dueDate,
    CreatedBy? createdBy,
    CreatedBy? lastUpdatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? reportStatus,
    bool? hasReport,
    String? reportStatusLabel,
  }) => Datum(
    id: id ?? this.id,
    inspector: inspector ?? this.inspector,
    formType: formType ?? this.formType,
    feeStatus: feeStatus ?? this.feeStatus,
    agreedFee: agreedFee ?? this.agreedFee,
    fhaCaseDetailsNo: fhaCaseDetailsNo ?? this.fhaCaseDetailsNo,
    orderId: orderId ?? this.orderId,
    streetAddress: streetAddress ?? this.streetAddress,
    developmentName: developmentName ?? this.developmentName,
    siteContactName: siteContactName ?? this.siteContactName,
    siteContactPhone: siteContactPhone ?? this.siteContactPhone,
    siteContactEmail: siteContactEmail ?? this.siteContactEmail,
    dueDate: dueDate ?? this.dueDate,
    createdBy: createdBy ?? this.createdBy,
    lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    reportStatus: reportStatus ?? this.reportStatus,
    hasReport: hasReport ?? this.hasReport,
    reportStatusLabel: reportStatusLabel ?? this.reportStatusLabel,
  );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    inspector: json["inspector"] == null
        ? null
        : CreatedBy.fromJson(json["inspector"]),
    formType: json["formType"],
    feeStatus: json["feeStatus"],
    agreedFee: json["agreedFee"],
    fhaCaseDetailsNo: json["fhaCaseDetailsNo"],
    orderId: json["orderId"],
    streetAddress: json["streetAddress"],
    developmentName: json["developmentName"],
    siteContactName: json["siteContactName"],
    siteContactPhone: json["siteContactPhone"],
    siteContactEmail: json["siteContactEmail"],
    dueDate: json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
    createdBy: json["createdBy"] == null
        ? null
        : CreatedBy.fromJson(json["createdBy"]),
    lastUpdatedBy: json["lastUpdatedBy"] == null
        ? null
        : CreatedBy.fromJson(json["lastUpdatedBy"]),
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    reportStatus: json["reportStatus"],
    hasReport: json["hasReport"],
    reportStatusLabel: json["reportStatusLabel"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "inspector": inspector?.toJson(),
    "formType": formType,
    "feeStatus": feeStatus,
    "agreedFee": agreedFee,
    "fhaCaseDetailsNo": fhaCaseDetailsNo,
    "orderId": orderId,
    "streetAddress": streetAddress,
    "developmentName": developmentName,
    "siteContactName": siteContactName,
    "siteContactPhone": siteContactPhone,
    "siteContactEmail": siteContactEmail,
    "dueDate": dueDate?.toIso8601String(),
    "createdBy": createdBy?.toJson(),
    "lastUpdatedBy": lastUpdatedBy?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "reportStatus": reportStatus,
    "hasReport": hasReport,
    "reportStatusLabel": reportStatusLabel,
  };
}

class CreatedBy {
  String? id;
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? role;

  CreatedBy({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
  });

  CreatedBy copyWith({
    String? id,
    String? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? role,
  }) => CreatedBy(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    role: role ?? this.role,
  );

  factory CreatedBy.fromRawJson(String str) =>
      CreatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["_id"],
    userId: json["userId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "role": role,
  };
}

class MetaData {
  int? page;
  int? limit;
  int? totalJob;
  int? totalPage;

  MetaData({this.page, this.limit, this.totalJob, this.totalPage});

  MetaData copyWith({int? page, int? limit, int? totalJob, int? totalPage}) =>
      MetaData(
        page: page ?? this.page,
        limit: limit ?? this.limit,
        totalJob: totalJob ?? this.totalJob,
        totalPage: totalPage ?? this.totalPage,
      );

  factory MetaData.fromRawJson(String str) =>
      MetaData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
    page: json["page"],
    limit: json["limit"],
    totalJob: json["totalJob"],
    totalPage: json["totalPage"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "totalJob": totalJob,
    "totalPage": totalPage,
  };
}

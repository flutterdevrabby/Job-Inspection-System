import 'dart:convert';

class ArchiveReportResponse {
  bool? success;
  String? message;
  List<Datum>? data;
  MetaData? metaData;
  int? code;

  ArchiveReportResponse({
    this.success,
    this.message,
    this.data,
    this.metaData,
    this.code,
  });

  ArchiveReportResponse copyWith({
    bool? success,
    String? message,
    List<Datum>? data,
    MetaData? metaData,
    int? code,
  }) => ArchiveReportResponse(
    success: success ?? this.success,
    message: message ?? this.message,
    data: data ?? this.data,
    metaData: metaData ?? this.metaData,
    code: code ?? this.code,
  );

  factory ArchiveReportResponse.fromRawJson(String str) =>
      ArchiveReportResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArchiveReportResponse.fromJson(Map<String, dynamic> json) =>
      ArchiveReportResponse(
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
  Job? job;
  String? status;
  DateTime? completedAt;
  DateTime? createdAt;

  Datum({this.id, this.job, this.status, this.completedAt, this.createdAt});

  Datum copyWith({
    String? id,
    Job? job,
    String? status,
    DateTime? completedAt,
    DateTime? createdAt,
  }) => Datum(
    id: id ?? this.id,
    job: job ?? this.job,
    status: status ?? this.status,
    completedAt: completedAt ?? this.completedAt,
    createdAt: createdAt ?? this.createdAt,
  );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    job: json["job"] == null ? null : Job.fromJson(json["job"]),
    status: json["status"],
    completedAt: json["completedAt"] == null
        ? null
        : DateTime.parse(json["completedAt"]),
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "job": job?.toJson(),
    "status": status,
    "completedAt": completedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
  };
}

class Job {
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
  String? specialNotesForInspector;
  String? specialNoteForApOrAr;
  CreatedBy? createdBy;
  CreatedBy? lastUpdatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? hasReport;
  String? reportId;
  String? reportStatus;
  String? reportStatusLabel;

  Job({
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
    this.specialNotesForInspector,
    this.specialNoteForApOrAr,
    this.createdBy,
    this.lastUpdatedBy,
    this.createdAt,
    this.updatedAt,
    this.hasReport,
    this.reportId,
    this.reportStatus,
    this.reportStatusLabel,
  });

  Job copyWith({
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
    String? specialNotesForInspector,
    String? specialNoteForApOrAr,
    CreatedBy? createdBy,
    CreatedBy? lastUpdatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? hasReport,
    String? reportId,
    String? reportStatus,
    String? reportStatusLabel,
  }) => Job(
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
    specialNotesForInspector:
        specialNotesForInspector ?? this.specialNotesForInspector,
    specialNoteForApOrAr: specialNoteForApOrAr ?? this.specialNoteForApOrAr,
    createdBy: createdBy ?? this.createdBy,
    lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    hasReport: hasReport ?? this.hasReport,
    reportId: reportId ?? this.reportId,
    reportStatus: reportStatus ?? this.reportStatus,
    reportStatusLabel: reportStatusLabel ?? this.reportStatusLabel,
  );

  factory Job.fromRawJson(String str) => Job.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Job.fromJson(Map<String, dynamic> json) => Job(
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
    specialNotesForInspector: json["specialNotesForInspector"],
    specialNoteForApOrAr: json["specialNoteForApOrAr"],
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
    hasReport: json["hasReport"],
    reportId: json["reportId"],
    reportStatus: json["reportStatus"],
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
    "specialNotesForInspector": specialNotesForInspector,
    "specialNoteForApOrAr": specialNoteForApOrAr,
    "createdBy": createdBy?.toJson(),
    "lastUpdatedBy": lastUpdatedBy?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "hasReport": hasReport,
    "reportId": reportId,
    "reportStatus": reportStatus,
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
  int? currentPage;
  int? totalPages;
  int? totalItems;
  int? itemsPerPage;
  bool? hasNextPage;
  bool? hasPreviousPage;

  MetaData({
    this.currentPage,
    this.totalPages,
    this.totalItems,
    this.itemsPerPage,
    this.hasNextPage,
    this.hasPreviousPage,
  });

  MetaData copyWith({
    int? currentPage,
    int? totalPages,
    int? totalItems,
    int? itemsPerPage,
    bool? hasNextPage,
    bool? hasPreviousPage,
  }) => MetaData(
    currentPage: currentPage ?? this.currentPage,
    totalPages: totalPages ?? this.totalPages,
    totalItems: totalItems ?? this.totalItems,
    itemsPerPage: itemsPerPage ?? this.itemsPerPage,
    hasNextPage: hasNextPage ?? this.hasNextPage,
    hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
  );

  factory MetaData.fromRawJson(String str) =>
      MetaData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    totalItems: json["totalItems"],
    itemsPerPage: json["itemsPerPage"],
    hasNextPage: json["hasNextPage"],
    hasPreviousPage: json["hasPreviousPage"],
  );

  Map<String, dynamic> toJson() => {
    "currentPage": currentPage,
    "totalPages": totalPages,
    "totalItems": totalItems,
    "itemsPerPage": itemsPerPage,
    "hasNextPage": hasNextPage,
    "hasPreviousPage": hasPreviousPage,
  };
}

import 'dart:convert';

class InspectionResponse {
  bool? success;
  String? message;
  List<Datum>? data;
  MetaData? metaData;
  int? code;

  InspectionResponse({
    this.success,
    this.message,
    this.data,
    this.metaData,
    this.code,
  });

  InspectionResponse copyWith({
    bool? success,
    String? message,
    List<Datum>? data,
    MetaData? metaData,
    int? code,
  }) => InspectionResponse(
    success: success ?? this.success,
    message: message ?? this.message,
    data: data ?? this.data,
    metaData: metaData ?? this.metaData,
    code: code ?? this.code,
  );

  factory InspectionResponse.fromRawJson(String str) =>
      InspectionResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InspectionResponse.fromJson(Map<String, dynamic> json) =>
      InspectionResponse(
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
  String? specialNotesForInspector;
  String? specialNoteForApOrAr;
  CreatedBy? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  LastUpdatedBy? lastUpdatedBy;
  bool? hasReport;
  String? reportId;
  String? reportStatus;
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
    this.specialNotesForInspector,
    this.specialNoteForApOrAr,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.lastUpdatedBy,
    this.hasReport,
    this.reportId,
    this.reportStatus,
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
    String? specialNotesForInspector,
    String? specialNoteForApOrAr,
    CreatedBy? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    LastUpdatedBy? lastUpdatedBy,
    bool? hasReport,
    String? reportId,
    String? reportStatus,
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
    specialNotesForInspector:
        specialNotesForInspector ?? this.specialNotesForInspector,
    specialNoteForApOrAr: specialNoteForApOrAr ?? this.specialNoteForApOrAr,
    createdBy: createdBy ?? this.createdBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
    hasReport: hasReport ?? this.hasReport,
    reportId: reportId ?? this.reportId,
    reportStatus: reportStatus ?? this.reportStatus,
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
    specialNotesForInspector: json["specialNotesForInspector"],
    specialNoteForApOrAr: json["specialNoteForApOrAr"],
    createdBy: json["createdBy"] == null
        ? null
        : CreatedBy.fromJson(json["createdBy"]),
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    lastUpdatedBy: json["lastUpdatedBy"] == null
        ? null
        : LastUpdatedBy.fromJson(json["lastUpdatedBy"]),
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
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "lastUpdatedBy": lastUpdatedBy?.toJson(),
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

class LastUpdatedBy {
  String? role;

  LastUpdatedBy({this.role});

  LastUpdatedBy copyWith({String? role}) =>
      LastUpdatedBy(role: role ?? this.role);

  factory LastUpdatedBy.fromRawJson(String str) =>
      LastUpdatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LastUpdatedBy.fromJson(Map<String, dynamic> json) =>
      LastUpdatedBy(role: json["role"]);

  Map<String, dynamic> toJson() => {"role": role};
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

// import 'dart:convert';

// class InspectionResponse {
//   bool? success;
//   String? message;
//   List<Datum>? data;
//   MetaData? metaData;
//   int? code;

//   InspectionResponse({
//     this.success,
//     this.message,
//     this.data,
//     this.metaData,
//     this.code,
//   });

//   InspectionResponse copyWith({
//     bool? success,
//     String? message,
//     List<Datum>? data,
//     MetaData? metaData,
//     int? code,
//   }) => InspectionResponse(
//     success: success ?? this.success,
//     message: message ?? this.message,
//     data: data ?? this.data,
//     metaData: metaData ?? this.metaData,
//     code: code ?? this.code,
//   );

//   factory InspectionResponse.fromRawJson(String str) =>
//       InspectionResponse.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory InspectionResponse.fromJson(Map<String, dynamic> json) =>
//       InspectionResponse(
//         success: json["success"],
//         message: json["message"],
//         data: json["data"] == null
//             ? []
//             : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//         metaData: json["metaData"] == null
//             ? null
//             : MetaData.fromJson(json["metaData"]),
//         code: json["code"],
//       );

//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "message": message,
//     "data": data == null
//         ? []
//         : List<dynamic>.from(data!.map((x) => x.toJson())),
//     "metaData": metaData?.toJson(),
//     "code": code,
//   };
// }

// class Datum {
//   String? id;
//   CreatedBy? inspector;
//   String? formType;
//   String? feeStatus;
//   int? agreedFee;
//   String? fhaCaseDetailsNo;
//   String? orderId;
//   String? streetAddress;
//   String? developmentName;
//   String? siteContactName;
//   String? siteContactPhone;
//   String? siteContactEmail;
//   DateTime? dueDate;
//   CreatedBy? createdBy;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   LastUpdatedBy? lastUpdatedBy;
//   bool? hasReport;
//   String? reportId;
//   String? reportStatus;
//   String? reportStatusLabel;

//   Datum({
//     this.id,
//     this.inspector,
//     this.formType,
//     this.feeStatus,
//     this.agreedFee,
//     this.fhaCaseDetailsNo,
//     this.orderId,
//     this.streetAddress,
//     this.developmentName,
//     this.siteContactName,
//     this.siteContactPhone,
//     this.siteContactEmail,
//     this.dueDate,
//     this.createdBy,
//     this.createdAt,
//     this.updatedAt,
//     this.lastUpdatedBy,
//     this.hasReport,
//     this.reportId,
//     this.reportStatus,
//     this.reportStatusLabel,
//   });

//   Datum copyWith({
//     String? id,
//     CreatedBy? inspector,
//     String? formType,
//     String? feeStatus,
//     int? agreedFee,
//     String? fhaCaseDetailsNo,
//     String? orderId,
//     String? streetAddress,
//     String? developmentName,
//     String? siteContactName,
//     String? siteContactPhone,
//     String? siteContactEmail,
//     DateTime? dueDate,
//     CreatedBy? createdBy,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     LastUpdatedBy? lastUpdatedBy,
//     bool? hasReport,
//     String? reportId,
//     String? reportStatus,
//     String? reportStatusLabel,
//   }) => Datum(
//     id: id ?? this.id,
//     inspector: inspector ?? this.inspector,
//     formType: formType ?? this.formType,
//     feeStatus: feeStatus ?? this.feeStatus,
//     agreedFee: agreedFee ?? this.agreedFee,
//     fhaCaseDetailsNo: fhaCaseDetailsNo ?? this.fhaCaseDetailsNo,
//     orderId: orderId ?? this.orderId,
//     streetAddress: streetAddress ?? this.streetAddress,
//     developmentName: developmentName ?? this.developmentName,
//     siteContactName: siteContactName ?? this.siteContactName,
//     siteContactPhone: siteContactPhone ?? this.siteContactPhone,
//     siteContactEmail: siteContactEmail ?? this.siteContactEmail,
//     dueDate: dueDate ?? this.dueDate,
//     createdBy: createdBy ?? this.createdBy,
//     createdAt: createdAt ?? this.createdAt,
//     updatedAt: updatedAt ?? this.updatedAt,
//     lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
//     hasReport: hasReport ?? this.hasReport,
//     reportId: reportId ?? this.reportId,
//     reportStatus: reportStatus ?? this.reportStatus,
//     reportStatusLabel: reportStatusLabel ?? this.reportStatusLabel,
//   );

//   factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["_id"],
//     inspector: json["inspector"] == null
//         ? null
//         : CreatedBy.fromJson(json["inspector"]),
//     formType: json["formType"],
//     feeStatus: json["feeStatus"],
//     agreedFee: json["agreedFee"],
//     fhaCaseDetailsNo: json["fhaCaseDetailsNo"],
//     orderId: json["orderId"],
//     streetAddress: json["streetAddress"],
//     developmentName: json["developmentName"],
//     siteContactName: json["siteContactName"],
//     siteContactPhone: json["siteContactPhone"],
//     siteContactEmail: json["siteContactEmail"],
//     dueDate: json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
//     createdBy: json["createdBy"] == null
//         ? null
//         : CreatedBy.fromJson(json["createdBy"]),
//     createdAt: json["createdAt"] == null
//         ? null
//         : DateTime.parse(json["createdAt"]),
//     updatedAt: json["updatedAt"] == null
//         ? null
//         : DateTime.parse(json["updatedAt"]),
//     lastUpdatedBy: json["lastUpdatedBy"] == null
//         ? null
//         : LastUpdatedBy.fromJson(json["lastUpdatedBy"]),
//     hasReport: json["hasReport"],
//     reportId: json["reportId"],
//     reportStatus: json["reportStatus"],
//     reportStatusLabel: json["reportStatusLabel"],
//   );

//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "inspector": inspector?.toJson(),
//     "formType": formType,
//     "feeStatus": feeStatus,
//     "agreedFee": agreedFee,
//     "fhaCaseDetailsNo": fhaCaseDetailsNo,
//     "orderId": orderId,
//     "streetAddress": streetAddress,
//     "developmentName": developmentName,
//     "siteContactName": siteContactName,
//     "siteContactPhone": siteContactPhone,
//     "siteContactEmail": siteContactEmail,
//     "dueDate": dueDate?.toIso8601String(),
//     "createdBy": createdBy?.toJson(),
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//     "lastUpdatedBy": lastUpdatedBy?.toJson(),
//     "hasReport": hasReport,
//     "reportId": reportId,
//     "reportStatus": reportStatus,
//     "reportStatusLabel": reportStatusLabel,
//   };
// }

// class CreatedBy {
//   String? id;
//   String? userId;
//   String? firstName;
//   String? lastName;
//   String? email;
//   String? role;

//   CreatedBy({
//     this.id,
//     this.userId,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.role,
//   });

//   CreatedBy copyWith({
//     String? id,
//     String? userId,
//     String? firstName,
//     String? lastName,
//     String? email,
//     String? role,
//   }) => CreatedBy(
//     id: id ?? this.id,
//     userId: userId ?? this.userId,
//     firstName: firstName ?? this.firstName,
//     lastName: lastName ?? this.lastName,
//     email: email ?? this.email,
//     role: role ?? this.role,
//   );

//   factory CreatedBy.fromRawJson(String str) =>
//       CreatedBy.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
//     id: json["_id"],
//     userId: json["userId"],
//     firstName: json["firstName"],
//     lastName: json["lastName"],
//     email: json["email"],
//     role: json["role"],
//   );

//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "userId": userId,
//     "firstName": firstName,
//     "lastName": lastName,
//     "email": email,
//     "role": role,
//   };
// }

// class LastUpdatedBy {
//   String? role;

//   LastUpdatedBy({this.role});

//   LastUpdatedBy copyWith({String? role}) =>
//       LastUpdatedBy(role: role ?? this.role);

//   factory LastUpdatedBy.fromRawJson(String str) =>
//       LastUpdatedBy.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory LastUpdatedBy.fromJson(Map<String, dynamic> json) =>
//       LastUpdatedBy(role: json["role"]);

//   Map<String, dynamic> toJson() => {"role": role};
// }

// class MetaData {
//   int? page;
//   int? limit;
//   int? totalJob;
//   int? totalPage;

//   MetaData({this.page, this.limit, this.totalJob, this.totalPage});

//   MetaData copyWith({int? page, int? limit, int? totalJob, int? totalPage}) =>
//       MetaData(
//         page: page ?? this.page,
//         limit: limit ?? this.limit,
//         totalJob: totalJob ?? this.totalJob,
//         totalPage: totalPage ?? this.totalPage,
//       );

//   factory MetaData.fromRawJson(String str) =>
//       MetaData.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
//     page: json["page"],
//     limit: json["limit"],
//     totalJob: json["totalJob"],
//     totalPage: json["totalPage"],
//   );

//   Map<String, dynamic> toJson() => {
//     "page": page,
//     "limit": limit,
//     "totalJob": totalJob,
//     "totalPage": totalPage,
//   };
// }

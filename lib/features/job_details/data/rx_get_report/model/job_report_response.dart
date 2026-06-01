import 'dart:convert';

class ReportResponse {
  bool? success;
  String? message;
  ReportData? data;
  int? code;
  ReportResponse({this.success, this.message, this.data, this.code});

  ReportResponse copyWith({
    bool? success,
    String? message,
    ReportData? data,
    int? code,
  }) => ReportResponse(
    success: success ?? this.success,
    message: message ?? this.message,
    data: data ?? this.data,
    code: code ?? this.code,
  );

  factory ReportResponse.fromRawJson(String str) =>
      ReportResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReportResponse.fromJson(Map<String, dynamic> json) => ReportResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : ReportData.fromJson(json["data"]),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "code": code,
  };
}

class ReportData {
  String? id;
  Inspector? inspector;
  Job? job;
  String? status;
  String? noteForAdmin;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ImageElement>? images;

  ReportData({
    this.id,
    this.inspector,
    this.job,
    this.status,
    this.noteForAdmin,
    this.createdAt,
    this.updatedAt,
    this.images,
  });

  ReportData copyWith({
    String? id,
    Inspector? inspector,
    Job? job,
    String? status,
    String? noteForAdmin,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<ImageElement>? images,
  }) => ReportData(
    id: id ?? this.id,
    inspector: inspector ?? this.inspector,
    job: job ?? this.job,
    status: status ?? this.status,
    noteForAdmin: noteForAdmin ?? this.noteForAdmin,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    images: images ?? this.images,
  );

  factory ReportData.fromRawJson(String str) => ReportData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReportData.fromJson(Map<String, dynamic> json) => ReportData(
    id: json["_id"],
    inspector: json["inspector"] == null
        ? null
        : Inspector.fromJson(json["inspector"]),
    job: json["job"] == null ? null : Job.fromJson(json["job"]),
    status: json["status"],
    noteForAdmin: json["noteForAdmin"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    images: json["images"] == null
        ? []
        : List<ImageElement>.from(
            json["images"]!.map((x) => ImageElement.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "inspector": inspector?.toJson(),
    "job": job?.toJson(),
    "status": status,
    "noteForAdmin": noteForAdmin,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "images": images == null
        ? []
        : List<dynamic>.from(images!.map((x) => x.toJson())),
  };
}

class ImageElement {
  String? imageLabel;
  ImageImage? image;

  ImageElement({this.imageLabel, this.image});

  ImageElement copyWith({String? imageLabel, ImageImage? image}) =>
      ImageElement(
        imageLabel: imageLabel ?? this.imageLabel,
        image: image ?? this.image,
      );

  factory ImageElement.fromRawJson(String str) =>
      ImageElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageElement.fromJson(Map<String, dynamic> json) => ImageElement(
    imageLabel: json["imageLabel"],
    image: json["image"] == null ? null : ImageImage.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "imageLabel": imageLabel,
    "image": image?.toJson(),
  };
}

class ImageImage {
  String? fileName;
  String? url;
  String? key;
  String? alt;
  String? mimeType;
  int? size;

  ImageImage({
    this.fileName,
    this.url,
    this.key,
    this.alt,
    this.mimeType,
    this.size,
  });

  ImageImage copyWith({
    String? fileName,
    String? url,
    String? key,
    String? alt,
    String? mimeType,
    int? size,
  }) => ImageImage(
    fileName: fileName ?? this.fileName,
    url: url ?? this.url,
    key: key ?? this.key,
    alt: alt ?? this.alt,
    mimeType: mimeType ?? this.mimeType,
    size: size ?? this.size,
  );

  factory ImageImage.fromRawJson(String str) =>
      ImageImage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageImage.fromJson(Map<String, dynamic> json) => ImageImage(
    fileName: json["fileName"],
    url: json["url"],
    key: json["key"],
    alt: json["alt"],
    mimeType: json["mimeType"],
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "fileName": fileName,
    "url": url,
    "key": key,
    "alt": alt,
    "mimeType": mimeType,
    "size": size,
  };
}

class Inspector {
  String? id;
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? role;

  Inspector({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
  });

  Inspector copyWith({
    String? id,
    String? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? role,
  }) => Inspector(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    role: role ?? this.role,
  );

  factory Inspector.fromRawJson(String str) =>
      Inspector.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Inspector.fromJson(Map<String, dynamic> json) => Inspector(
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

class Job {
  Inspector? createdBy;
  Inspector? lastUpdatedBy;
  String? id;
  String? fhaCaseDetailsNo;
  String? formType;
  String? orderId;
  String? streetAddress;
  String? developmentName;
  String? siteContactName;
  String? siteContactPhone;
  String? siteContactEmail;
  DateTime? dueDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  Job({
    this.createdBy,
    this.lastUpdatedBy,
    this.id,
    this.fhaCaseDetailsNo,
    this.formType,
    this.orderId,
    this.streetAddress,
    this.developmentName,
    this.siteContactName,
    this.siteContactPhone,
    this.siteContactEmail,
    this.dueDate,
    this.createdAt,
    this.updatedAt,
  });

  Job copyWith({
    Inspector? createdBy,
    Inspector? lastUpdatedBy,
    String? id,
    String? fhaCaseDetailsNo,
    String? formType,
    String? orderId,
    String? streetAddress,
    String? developmentName,
    String? siteContactName,
    String? siteContactPhone,
    String? siteContactEmail,
    DateTime? dueDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Job(
    createdBy: createdBy ?? this.createdBy,
    lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
    id: id ?? this.id,
    fhaCaseDetailsNo: fhaCaseDetailsNo ?? this.fhaCaseDetailsNo,
    formType: formType ?? this.formType,
    orderId: orderId ?? this.orderId,
    streetAddress: streetAddress ?? this.streetAddress,
    developmentName: developmentName ?? this.developmentName,
    siteContactName: siteContactName ?? this.siteContactName,
    siteContactPhone: siteContactPhone ?? this.siteContactPhone,
    siteContactEmail: siteContactEmail ?? this.siteContactEmail,
    dueDate: dueDate ?? this.dueDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Job.fromRawJson(String str) => Job.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    createdBy: json["createdBy"] == null
        ? null
        : Inspector.fromJson(json["createdBy"]),
    lastUpdatedBy: json["lastUpdatedBy"] == null
        ? null
        : Inspector.fromJson(json["lastUpdatedBy"]),
    id: json["_id"],
    fhaCaseDetailsNo: json["fhaCaseDetailsNo"],
    formType: json["formType"],
    orderId: json["orderId"],
    streetAddress: json["streetAddress"],
    developmentName: json["developmentName"],
    siteContactName: json["siteContactName"],
    siteContactPhone: json["siteContactPhone"],
    siteContactEmail: json["siteContactEmail"],
    dueDate: json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy?.toJson(),
    "lastUpdatedBy": lastUpdatedBy?.toJson(),
    "_id": id,
    "fhaCaseDetailsNo": fhaCaseDetailsNo,
    "formType": formType,
    "orderId": orderId,
    "streetAddress": streetAddress,
    "developmentName": developmentName,
    "siteContactName": siteContactName,
    "siteContactPhone": siteContactPhone,
    "siteContactEmail": siteContactEmail,
    "dueDate": dueDate?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}



// import 'dart:convert';

// class ReportResponse {
//   bool? success;
//   String? message;
//   ReportData? data;
//   int? code;

//   ReportResponse({this.success, this.message, this.data, this.code});

//   ReportResponse copyWith({
//     bool? success,
//     String? message,
//     ReportData? data,
//     int? code,
//   }) => ReportResponse(
//     success: success ?? this.success,
//     message: message ?? this.message,
//     data: data ?? this.data,
//     code: code ?? this.code,
//   );

//   factory ReportResponse.fromRawJson(String str) =>
//       ReportResponse.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory ReportResponse.fromJson(Map<String, dynamic> json) => ReportResponse(
//     success: json["success"],
//     message: json["message"],
//     data: json["data"] == null ? null : ReportData.fromJson(json["data"]),
//     code: json["code"],
//   );

//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "message": message,
//     "data": data?.toJson(),
//     "code": code,
//   };
// }

// class ReportData {
//   String? id;
//   Inspector? inspector;
//   Job? job;
//   String? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   List<DataImage>? images;

//   ReportData({
//     this.id,
//     this.inspector,
//     this.job,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.images,
//   });

//   ReportData copyWith({
//     String? id,
//     Inspector? inspector,
//     Job? job,
//     String? status,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     List<DataImage>? images,
//   }) => ReportData(
//     id: id ?? this.id,
//     inspector: inspector ?? this.inspector,
//     job: job ?? this.job,
//     status: status ?? this.status,
//     createdAt: createdAt ?? this.createdAt,
//     updatedAt: updatedAt ?? this.updatedAt,
//     images: images ?? this.images,
//   );

//   factory ReportData.fromRawJson(String str) =>
//       ReportData.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory ReportData.fromJson(Map<String, dynamic> json) => ReportData(
//     id: json["_id"],
//     inspector: json["inspector"] == null
//         ? null
//         : Inspector.fromJson(json["inspector"]),
//     job: json["job"] == null ? null : Job.fromJson(json["job"]),
//     status: json["status"],
//     createdAt: json["createdAt"] == null
//         ? null
//         : DateTime.parse(json["createdAt"]),
//     updatedAt: json["updatedAt"] == null
//         ? null
//         : DateTime.parse(json["updatedAt"]),
//     images: json["images"] == null
//         ? []
//         : List<DataImage>.from(
//             json["images"]!.map((x) => DataImage.fromJson(x)),
//           ),
//   );

//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "inspector": inspector?.toJson(),
//     "job": job?.toJson(),
//     "status": status,
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//     "images": images == null
//         ? []
//         : List<dynamic>.from(images!.map((x) => x.toJson())),
//   };
// }

// class DataImage {
//   String? imageLabel;
//   List<ImageImage>? images;

//   DataImage({this.imageLabel, this.images});

//   DataImage copyWith({String? imageLabel, List<ImageImage>? images}) =>
//       DataImage(
//         imageLabel: imageLabel ?? this.imageLabel,
//         images: images ?? this.images,
//       );

//   factory DataImage.fromRawJson(String str) =>
//       DataImage.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory DataImage.fromJson(Map<String, dynamic> json) => DataImage(
//     imageLabel: json["imageLabel"],
//     images: json["images"] == null
//         ? []
//         : List<ImageImage>.from(
//             json["images"]!.map((x) => ImageImage.fromJson(x)),
//           ),
//   );

//   Map<String, dynamic> toJson() => {
//     "imageLabel": imageLabel,
//     "images": images == null
//         ? []
//         : List<dynamic>.from(images!.map((x) => x.toJson())),
//   };
// }

// class ImageImage {
//   String? fileName;
//   String? url;
//   String? key;
//   String? alt;
//   String? mimeType;
//   int? size;
//   String? noteForAdmin;

//   ImageImage({
//     this.fileName,
//     this.url,
//     this.key,
//     this.alt,
//     this.mimeType,
//     this.size,
//     this.noteForAdmin,
//   });

//   ImageImage copyWith({
//     String? fileName,
//     String? url,
//     String? key,
//     String? alt,
//     String? mimeType,
//     int? size,
//     String? noteForAdmin,
//   }) => ImageImage(
//     fileName: fileName ?? this.fileName,
//     url: url ?? this.url,
//     key: key ?? this.key,
//     alt: alt ?? this.alt,
//     mimeType: mimeType ?? this.mimeType,
//     size: size ?? this.size,
//     noteForAdmin: noteForAdmin ?? this.noteForAdmin,
//   );

//   factory ImageImage.fromRawJson(String str) =>
//       ImageImage.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory ImageImage.fromJson(Map<String, dynamic> json) => ImageImage(
//     fileName: json["fileName"],
//     url: json["url"],
//     key: json["key"],
//     alt: json["alt"],
//     mimeType: json["mimeType"],
//     size: json["size"],
//     noteForAdmin: json["noteForAdmin"],
//   );

//   Map<String, dynamic> toJson() => {
//     "fileName": fileName,
//     "url": url,
//     "key": key,
//     "alt": alt,
//     "mimeType": mimeType,
//     "size": size,
//     "noteForAdmin": noteForAdmin,
//   };
// }

// class Inspector {
//   String? id;
//   String? userId;
//   String? firstName;
//   String? lastName;
//   String? email;
//   String? role;

//   Inspector({
//     this.id,
//     this.userId,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.role,
//   });

//   Inspector copyWith({
//     String? id,
//     String? userId,
//     String? firstName,
//     String? lastName,
//     String? email,
//     String? role,
//   }) => Inspector(
//     id: id ?? this.id,
//     userId: userId ?? this.userId,
//     firstName: firstName ?? this.firstName,
//     lastName: lastName ?? this.lastName,
//     email: email ?? this.email,
//     role: role ?? this.role,
//   );

//   factory Inspector.fromRawJson(String str) =>
//       Inspector.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Inspector.fromJson(Map<String, dynamic> json) => Inspector(
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

// class Job {
//   Inspector? createdBy;
//   Inspector? lastUpdatedBy;
//   String? id;
//   String? fhaCaseDetailsNo;
//   String? formType;
//   String? orderId;
//   String? streetAddress;
//   String? developmentName;
//   String? siteContactName;
//   String? siteContactPhone;
//   String? siteContactEmail;
//   DateTime? dueDate;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   Job({
//     this.createdBy,
//     this.lastUpdatedBy,
//     this.id,
//     this.fhaCaseDetailsNo,
//     this.formType,
//     this.orderId,
//     this.streetAddress,
//     this.developmentName,
//     this.siteContactName,
//     this.siteContactPhone,
//     this.siteContactEmail,
//     this.dueDate,
//     this.createdAt,
//     this.updatedAt,
//   });

//   Job copyWith({
//     Inspector? createdBy,
//     Inspector? lastUpdatedBy,
//     String? id,
//     String? fhaCaseDetailsNo,
//     String? formType,
//     String? orderId,
//     String? streetAddress,
//     String? developmentName,
//     String? siteContactName,
//     String? siteContactPhone,
//     String? siteContactEmail,
//     DateTime? dueDate,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) => Job(
//     createdBy: createdBy ?? this.createdBy,
//     lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
//     id: id ?? this.id,
//     fhaCaseDetailsNo: fhaCaseDetailsNo ?? this.fhaCaseDetailsNo,
//     formType: formType ?? this.formType,
//     orderId: orderId ?? this.orderId,
//     streetAddress: streetAddress ?? this.streetAddress,
//     developmentName: developmentName ?? this.developmentName,
//     siteContactName: siteContactName ?? this.siteContactName,
//     siteContactPhone: siteContactPhone ?? this.siteContactPhone,
//     siteContactEmail: siteContactEmail ?? this.siteContactEmail,
//     dueDate: dueDate ?? this.dueDate,
//     createdAt: createdAt ?? this.createdAt,
//     updatedAt: updatedAt ?? this.updatedAt,
//   );

//   factory Job.fromRawJson(String str) => Job.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Job.fromJson(Map<String, dynamic> json) => Job(
//     createdBy: json["createdBy"] == null
//         ? null
//         : Inspector.fromJson(json["createdBy"]),
//     lastUpdatedBy: json["lastUpdatedBy"] == null
//         ? null
//         : Inspector.fromJson(json["lastUpdatedBy"]),
//     id: json["_id"],
//     fhaCaseDetailsNo: json["fhaCaseDetailsNo"],
//     formType: json["formType"],
//     orderId: json["orderId"],
//     streetAddress: json["streetAddress"],
//     developmentName: json["developmentName"],
//     siteContactName: json["siteContactName"],
//     siteContactPhone: json["siteContactPhone"],
//     siteContactEmail: json["siteContactEmail"],
//     dueDate: json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
//     createdAt: json["createdAt"] == null
//         ? null
//         : DateTime.parse(json["createdAt"]),
//     updatedAt: json["updatedAt"] == null
//         ? null
//         : DateTime.parse(json["updatedAt"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "createdBy": createdBy?.toJson(),
//     "lastUpdatedBy": lastUpdatedBy?.toJson(),
//     "_id": id,
//     "fhaCaseDetailsNo": fhaCaseDetailsNo,
//     "formType": formType,
//     "orderId": orderId,
//     "streetAddress": streetAddress,
//     "developmentName": developmentName,
//     "siteContactName": siteContactName,
//     "siteContactPhone": siteContactPhone,
//     "siteContactEmail": siteContactEmail,
//     "dueDate": dueDate?.toIso8601String(),
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//   };
// }

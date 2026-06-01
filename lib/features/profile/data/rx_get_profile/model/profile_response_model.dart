import 'dart:convert';

class ProfileResponse {
  bool? success;
  String? message;
  Data? data;
  int? code;

  ProfileResponse({this.success, this.message, this.data, this.code});

  ProfileResponse copyWith({
    bool? success,
    String? message,
    Data? data,
    int? code,
  }) => ProfileResponse(
    success: success ?? this.success,
    message: message ?? this.message,
    data: data ?? this.data,
    code: code ?? this.code,
  );

  factory ProfileResponse.fromRawJson(String str) =>
      ProfileResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
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
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  bool? isSuspended;
  bool? isApproved;
  String? role;
  dynamic resetToken;
  dynamic resetTokenExpiry;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.isSuspended,
    this.isApproved,
    this.role,
    this.resetToken,
    this.resetTokenExpiry,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  Data copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    bool? isSuspended,
    bool? isApproved,
    String? role,
    dynamic resetToken,
    dynamic resetTokenExpiry,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Data(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    isSuspended: isSuspended ?? this.isSuspended,
    isApproved: isApproved ?? this.isApproved,
    role: role ?? this.role,
    resetToken: resetToken ?? this.resetToken,
    resetTokenExpiry: resetTokenExpiry ?? this.resetTokenExpiry,
    userId: userId ?? this.userId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    isSuspended: json["isSuspended"],
    isApproved: json["isApproved"],
    role: json["role"],
    resetToken: json["resetToken"],
    resetTokenExpiry: json["resetTokenExpiry"],
    userId: json["userId"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "isSuspended": isSuspended,
    "isApproved": isApproved,
    "role": role,
    "resetToken": resetToken,
    "resetTokenExpiry": resetTokenExpiry,
    "userId": userId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

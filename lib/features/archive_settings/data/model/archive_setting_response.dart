import 'dart:convert';

class ArchiveSettingFetchResponse {
  bool? success;
  String? message;
  Data? data;
  int? code;

  ArchiveSettingFetchResponse({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  ArchiveSettingFetchResponse copyWith({
    bool? success,
    String? message,
    Data? data,
    int? code,
  }) => ArchiveSettingFetchResponse(
    success: success ?? this.success,
    message: message ?? this.message,
    data: data ?? this.data,
    code: code ?? this.code,
  );

  factory ArchiveSettingFetchResponse.fromRawJson(String str) =>
      ArchiveSettingFetchResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArchiveSettingFetchResponse.fromJson(Map<String, dynamic> json) =>
      ArchiveSettingFetchResponse(
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
  int? autoArchiveDays;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({this.id, this.autoArchiveDays, this.createdAt, this.updatedAt});

  Data copyWith({
    String? id,
    int? autoArchiveDays,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Data(
    id: id ?? this.id,
    autoArchiveDays: autoArchiveDays ?? this.autoArchiveDays,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    autoArchiveDays: json["autoArchiveDays"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "autoArchiveDays": autoArchiveDays,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

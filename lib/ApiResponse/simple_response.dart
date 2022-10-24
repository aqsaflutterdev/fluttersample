import 'package:json_annotation/json_annotation.dart';

part 'simple_response.g.dart';

//done this file

@JsonSerializable()
class SimpleResponse {

  @JsonKey(name: 'message')
  final dynamic message;

  @JsonKey(name: 'error')
  final int? error;

  @JsonKey(name: 'data')
  final Map<String,dynamic>? data;

  SimpleResponse(this.data,{required this.message,this.error=0});

  factory SimpleResponse.fromJson(Map<String, dynamic> json) => _$SimpleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleResponseToJson(this);

}


@JsonSerializable()
class SimpleListResponse {

  @JsonKey(name: 'message')
  final dynamic message;

  @JsonKey(name: 'error')
  final int? error;

  @JsonKey(name: 'data')
  final List<Map<String,dynamic>>? data;

  SimpleListResponse(this.data,{required this.message,this.error=0});

  factory SimpleListResponse.fromJson(Map<String, dynamic> json) => _$SimpleListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleListResponseToJson(this);

}


@JsonSerializable()
class ClearNotificationResponse {

  @JsonKey(name: 'message')
  final dynamic message;

  @JsonKey(name: 'error')
  final int? error;

  @JsonKey(name: 'data')
  final int data;

  ClearNotificationResponse(this.data,{required this.message,this.error=0});

  factory ClearNotificationResponse.fromJson(Map<String, dynamic> json) => _$ClearNotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ClearNotificationResponseToJson(this);

}
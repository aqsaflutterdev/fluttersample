// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleResponse _$SimpleResponseFromJson(Map<String, dynamic> json) =>
    SimpleResponse(
      json['data'] as Map<String, dynamic>?,
      message: json['message'],
      error: json['error'] as int? ?? 0,
    );

Map<String, dynamic> _$SimpleResponseToJson(SimpleResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'error': instance.error,
      'data': instance.data,
    };

SimpleListResponse _$SimpleListResponseFromJson(Map<String, dynamic> json) =>
    SimpleListResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      message: json['message'],
      error: json['error'] as int? ?? 0,
    );

Map<String, dynamic> _$SimpleListResponseToJson(SimpleListResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'error': instance.error,
      'data': instance.data,
    };

ClearNotificationResponse _$ClearNotificationResponseFromJson(
        Map<String, dynamic> json) =>
    ClearNotificationResponse(
      json['data'] as int,
      message: json['message'],
      error: json['error'] as int? ?? 0,
    );

Map<String, dynamic> _$ClearNotificationResponseToJson(
        ClearNotificationResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'error': instance.error,
      'data': instance.data,
    };

import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

//done this file

@JsonSerializable()
class LoginResponse {


  @JsonKey(name: 'message')
  final dynamic message;

  @JsonKey(name: 'error')
  final int? error;

  @JsonKey(name: 'data')
  final Map<String,dynamic>? data;

  LoginResponse(this.data,{required this.message,this.error=0});


  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);


}
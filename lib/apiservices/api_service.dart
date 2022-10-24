import 'package:dio/dio.dart';
import 'package:practiceflutter/ApiResponse/login_response.dart';
import 'package:practiceflutter/ApiResponse/simple_response.dart';
import 'package:practiceflutter/apiservices/AppUrl.dart';
import 'package:practiceflutter/apiservices/Interceptor/Logging.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';
@RestApi(baseUrl: AppUrl.apiUrl)
abstract class ApiService{
  factory ApiService(Dio dio, baseUrl) {
    dio.options = BaseOptions(receiveTimeout: 50000, connectTimeout: 50000,
        // contentType: 'application/json',
        /* If needed headers */
        headers: {
          // 'Content-Type': 'application/json',
          'Authorization': 'Basic dGVzdHVzZXI64oCMMTIzNDU2'
        });

    dio.interceptors.add(Logging());
    return _ApiService(dio, baseUrl: AppUrl.apiUrl);
  }

  // signup service
  @POST('/signup')
  Future<LoginResponse> signup(@Body() Map<String, dynamic> body);

  // Login service
  @POST('/login')
  Future<SimpleResponse> login(@Body() Map<String, dynamic> body);

}



import 'package:dio/dio.dart' as dio;



class AppUrl {
  static const String baseUrl = 'https://solo.novusguard.co.uk';
  static const String apiUrl = baseUrl + '/api/fofficer';
  static const String login = apiUrl + '/ApiLogin';
  static const String register = apiUrl + '/registration';
  static const String addRecipient = apiUrl + '/registration';
  static const String forgotPassword = apiUrl + '/forgot_password';
 // static ApiService apiService = ApiService(dio.Dio(),AppUrl.apiUrl);
}

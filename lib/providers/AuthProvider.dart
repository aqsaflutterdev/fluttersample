// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:dio/dio.dart' as dio;
// import 'package:flutter/material.dart';
// // import 'package:novus_guard_solo/modal/user.dart';

// // import 'package:novus_guard_solo/utility/app_url.dart';
// // import 'package:novus_guard_solo/utility/providers_utility.dart';
// // import 'package:novus_guard_solo/utility/shared_preference.dart';
// import 'package:http/http.dart';

// import 'package:practiceflutter/Network/Network.dart';
// import 'package:practiceflutter/model/UserRequest.dart';
//
//
//
// enum Status {
//   NotLoggedIn,
//   NotRegistered,
//   LoggedIn,
//   Registered,
//   Authenticating,
//   Registering,
//   LoggedOut
// }
//
// class AuthProvider extends ChangeNotifier {
//   String? locationx;
//   Status _loggedInStatus = Status.NotLoggedIn;
//   Status _registeredInStatus = Status.NotRegistered;
//   Status get loggedInStatus => _loggedInStatus;
//   set loggedInStatus(Status value) {
//     _loggedInStatus = value;
//   }
//   Status get registeredInStatus => _registeredInStatus;
//   set registeredInStatus(Status value) {
//     _registeredInStatus = value;
//   }
//   static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
//   Map<String, dynamic> _deviceData = <String, dynamic>{};
//
//   notify(){
//     notifyListeners();
//   }
//
//   Future<Map<String, dynamic>> signup(UserRequest userRequest) async {
//
//     Map<String, Object> result;
//
//     final Map<String, dynamic> signData = {
//       'email': userRequest.email,
//       'password': userRequest.password,
//       "first_name" : userRequest.firstName,
//       "last_name" : userRequest.lastName,
//       "phone" : userRequest.phoneNum,
//       "country" : userRequest.country,
//       "country_code" : userRequest.countryCode,
//       "phone_separated":userRequest.countrydialcode + "-" + userRequest.phoneSeparated
//     };
//
//     _registeredInStatus = Status.Registered;
//     notifyListeners();
//
//
//     // done , now run app
//
//     ApiService apiService = ApiService(dio.Dio(),AppUrl.apiUrl);
//
//     try {
//       final response = await apiService.signup(signData);
//       print("Signupndata $signData");
//
//       print('${response.toJson()}');
//       // {message: [{name: email, msg: The email has already been taken.}], error: 1}
//       if (response.error == 0) {
//
//
//         registeredInStatus = Status.Registered;
//         notifyListeners();
// //{message: {msg: You have successfully signed up. Please check your email for verification link.}, error: 0, data: null}
//         //result = {'status': true, 'message': response.message, 'email':userRequest.email};
//         result = {'status': true, 'message': response.message, 'email':userRequest.email};
//       } else {
//         registeredInStatus = Status.NotRegistered;
//         notifyListeners();
//         var msg = response.message[0]['msg'];//json.decode(response.message)[0]['msg'];
//         print(msg);
//         result = {
//           'status': false,
//           'message': msg
//         };
//       }
//       return result;
//
//     } catch(err){
//       print(err.toString());
//       result = {
//         'status': false,
//         'message': 'No response from Server'
//       };
//
//       return result;
//     }
//   }
//
//   Future<Map<String, dynamic>> login(String email, String password, String firebaseToken) async {
//     var result;
//     var deviceData = <String, dynamic>{};
//     var generatedDeviceInfo;
//
//     Network n = new Network("http://ip-api.com/json");
//     (await n.getData().then((value){
//       locationx = jsonDecode(value)["countryCode"];
//     }));
//
//     if (Platform.isAndroid) {
//       deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
//       generatedDeviceInfo = "Model: ${deviceData['model']}, Manufacture: ${deviceData['manufacturer']}, OS: Android, OS Version: ${deviceData['version.release']}";
//     } else if (Platform.isIOS) {
//       deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
//       generatedDeviceInfo = "Model: ${deviceData['model']}, Manufacture: Apple, OS: iOS, OS Version: ${deviceData['utsname.release']}";
//     }
//
//     final Map<String, dynamic> loginData = {
//       'email': email,
//       'password': password,
//       "device_type": Platform.isAndroid?'android':'iphone',
//       "device_token": firebaseToken,
//       "country_code": locationx,
//       "device_info" : generatedDeviceInfo
//       //"device_token" : "faF7l-p5vjA:APA91bFQdf_FjROq_Hkwzk7rYRX7cCJfCeEiJJU6A0jd-OpgRKLBalZbkp2eLze3N5YMCRmnyXnSUO1jcwOfC9p2wEmCPBgMvFdQ6rNn8y3YgoBrxYXv62rFQr0BahpqnomcAXj-B0xF",
//     };
//     print("[LOGIN DATA API SENT BODY]: ${loginData}");
//     _registeredInStatus = Status.Registered;
//     notifyListeners();
//     // done , now run app
//     ApiService apiService = ApiService(dio.Dio(),AppUrl.apiUrl);
//     try {
//       final response = await apiService.login(loginData);
//       print('${response.toJson()}');
//       print(response.error == 0);
//       if (response.error! == 0) {
//
//         // User authUser = User.fromJson(response.data!);
//         //  User(
//         //     token:response.data!['token'],
//         //     email: email,
//         //     password: password,
//         //     organizationID:response.data!['user']['miscDetail']['officer_organisations'][0]['officer_data']['organisation_id'] ,
//         //     clientID:response.data!['user']['miscDetail']['officer_organisations'][0]['clients'][0]['client_id'] ,
//         //     siteID:response.data!['user']['miscDetail']['officer_organisations'][0]['clients'][0]['sites'][0]['site_id'] ,
//         //     username:response.data!['user']['name'],
//         //     wallet:Wallet(balance: response.data!['user']['wallet']['balance']),
//         //     jobInfo:JobInfo(completed: response.data!['user']['job_info']['completed'])
//         // );
//
//         //  UserPreferences().setUser(authUser);
//
//         registeredInStatus = Status.Registered;
//         notifyListeners();
//         result = {'status': true, 'message': 'Successful', 'email':email, 'data':response.data};
//       } else {
//         registeredInStatus = Status.NotRegistered;
//         notifyListeners();
//         result = {
//           'status': false,
//           'message': response.message
//         };
//       }
//       return result;
//     } catch(err){
//       print(err.toString());
//       result = {
//         'status': false,
//         'message': 'Some problem occurred while attempting to login'
//       };
//       return result;
//     }
//   }
//
//   static onError(error){
//     print('the error is ${error.detail}');
//     return {
//       'status':false,
//       'message':'Unsuccessful Request',
//       'data':error
//     };
//   }
//
//   // https://pub.dev/packages/device_info_plus/example
//
//   Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
//     return <String, dynamic>{
//       'version.securityPatch': build.version.securityPatch,
//       'version.sdkInt': build.version.sdkInt,
//       'version.release': build.version.release,
//       'version.previewSdkInt': build.version.previewSdkInt,
//       'version.incremental': build.version.incremental,
//       'version.codename': build.version.codename,
//       'version.baseOS': build.version.baseOS,
//       'board': build.board,
//       'bootloader': build.bootloader,
//       'brand': build.brand,
//       'device': build.device,
//       'display': build.display,
//       'fingerprint': build.fingerprint,
//       'hardware': build.hardware,
//       'host': build.host,
//       'id': build.id,
//       'manufacturer': build.manufacturer,
//       'model': build.model,
//       'product': build.product,
//       'supported32BitAbis': build.supported32BitAbis,
//       'supported64BitAbis': build.supported64BitAbis,
//       'supportedAbis': build.supportedAbis,
//       'tags': build.tags,
//       'type': build.type,
//       'isPhysicalDevice': build.isPhysicalDevice,
//       'androidId': build.androidId,
//       'systemFeatures': build.systemFeatures,
//     };
//   }
//
//   Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
//     return <String, dynamic>{
//       'name': data.name,
//       'systemName': data.systemName,
//       'systemVersion': data.systemVersion,
//       'model': data.model,
//       'localizedModel': data.localizedModel,
//       'identifierForVendor': data.identifierForVendor,
//       'isPhysicalDevice': data.isPhysicalDevice,
//       'utsname.sysname:': data.utsname.sysname,
//       'utsname.nodename:': data.utsname.nodename,
//       'utsname.release:': data.utsname.release,
//       'utsname.version:': data.utsname.version,
//       'utsname.machine:': data.utsname.machine,
//     };
//   }
//
// }
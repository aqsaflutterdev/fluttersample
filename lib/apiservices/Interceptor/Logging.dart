import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practiceflutter/Userlocalstorage/UserPreferences.dart';
import 'package:practiceflutter/utility/CustomColor.dart';
import 'package:practiceflutter/utility/TopVariables.dart';
import 'package:practiceflutter/utility/dialog/error_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';


class Logging extends Interceptor {
  String endpoint = "";

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // print('[CONSTANT API URL]:\t${options.baseUrl}${options.path}');
    // print('[PREFERENCES API URL]\t${UserPreferences.baseUrl}${options.path}');
    // Use Our Custom Selected API Base URL
    options.baseUrl = UserPreferences.baseUrl;
    TopFunctions.internetConnectivityStatus().then((value) {
      if (value == false) {
        print("Your Internet Connection Appears To Be Offline.");
        Fluttertoast.showToast(
            msg: "Your Internet Connection Appears To Be Offline.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: CustomColor.white,
            backgroundColor: CustomColor.primary,
            fontSize: 16.0);
        return false;
      }
    });
    print('REQUEST[${options.method}] of [${options.baseUrl}${options.path}] => DATA: ${options.data}');
    endpoint = options.path;
    if (options.path == '/emergencyRecipient') {
      options.contentType = 'multipart/form-data';
    }
    if (options.path != '/login' &&
        options.path != '/signup' &&
        options.path != '/forgotpassword' &&
        options.path != '/twilio/otp/verify' &&
        options.path != '/twilio/otp' &&
        options.path != '/twilio/otp/voice') {
      options.headers
          .addEntries([MapEntry("token", UserPreferences.getToken())]);
    }
    if (options.path == '/twilio/otp/verify' ||
        options.path == '/twilio/otp' ||
        options.path == '/twilio/otp/voice' ||
        options.path == '/revoke_token') {
      options.baseUrl = UserPreferences.baseUrl.substring(
          0,
          UserPreferences.baseUrl
              .lastIndexOf('/')); // Remove /fofficer From API URL
    }
    if (options.path == '/ios_iapns') {
      options.baseUrl = UserPreferences.baseUrl.substring(
          0,
          UserPreferences.baseUrl
              .lastIndexOf('/')); // Remove /fofficer From API URL
      options.baseUrl = UserPreferences.baseUrl.substring(
          0,
          UserPreferences.baseUrl
              .lastIndexOf('/')); // Remove /api From API URL
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RESPONSE[${response.statusCode}] of [${response.requestOptions.path}] => DATA: ${response.data}');
    var jsonDecode_data = response.data;
    if (response.data.runtimeType.toString() == "String") {
      jsonDecode_data = jsonDecode(response.data);
    } else if (response.data.runtimeType.toString() == "_InternalLinkedHashMap<String, dynamic>") {
      jsonDecode_data = response.data;
    } else if (response.data.runtimeType.toString() == "Map<String, dynamic>?") {
      jsonDecode_data = response.data;
    } else {
      jsonDecode_data = response.data;
    }
    if (jsonDecode_data['message'] == 'Invalid token or token expired') {
      _tokenExpiredDialog(TopVariables.appNavigationKey.currentContext!);
    } else if (jsonDecode_data['error'] == 1) {
      if (endpoint == '/signup') {
        showErrorDialog(jsonDecode_data['message'][0]['msg'].toString());
      } else {
        showErrorDialog(jsonDecode_data['message'].toString());
      }
    }
    /*
    print("Working Till Here ${response.extra}");
    print("Working Till Here ${response.headers}");
    print("Working Till Here ${response.isRedirect}");
    print("Working Till Here ${response.realUri}");
    print("Working Till Here ${response.requestOptions}");
    print("Working Till Here ${response.statusCode}");
    print("Working Till Here ${response.statusMessage}");
    print("Working Till Here ${response.runtimeType}");
    */
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    //CustomProgressDialog.hideProDialog();
    print('ERROR[${err.response}] of [${err.requestOptions.path}] => DATA: ${err.toString()}');
    if (err.response?.statusCode == 200) {
      // Everything is Alright
    } else if (err.response?.statusCode == 404) {
      showErrorDialog(err.error);
    } else if (err.response?.statusCode == 500) {
      showErrorDialog(err.error);
    } else {
      //showErrorDialog(err.toString());
    }
    //return super.onError(err, handler);
  }

  _tokenExpiredDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User Must Tap Button To Close Dialog, Can't Click Anywhere Else To Close
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
                title: Container(
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0)),
                      color: CustomColor.primary,
                    ),
                    child: const Text(
                      'Token Expired',
                      style: TextStyle(color: CustomColor.white),
                    )),
                content: SingleChildScrollView(
                  child: Column(
                    children: const <Widget>[
                      Text('Your token has been expired.'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      child: const Text(
                        'Okay',
                        style: TextStyle(color: CustomColor.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(CustomColor.primary),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)))),
                      onPressed: () async {
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        await preferences.clear();
                        Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                      },
                    ),
                  )
                ]));
      },
    );
  }

}

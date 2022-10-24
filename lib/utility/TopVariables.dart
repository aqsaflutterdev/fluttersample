import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:practiceflutter/apiservices/api_service.dart';



import 'package:provider/provider.dart';
import 'package:practiceflutter/providers/DeploymentProvider.dart';


import '../apiservices/AppUrl.dart';


class TopVariables {
  ///
  /// VARIABLES
  ///
  static bool isConnectedToInternet = false;
  static bool isSmsPermissionGranted = false;
  static bool SosAlertIdAudio = false;
  static bool SosRasiedAudio = false;
  static final GlobalKey<NavigatorState> appNavigationKey =
  GlobalKey<NavigatorState>();
  static InterstitialAd? interstitialAd;
  static double? screenWidth =
      MediaQuery.of(appNavigationKey.currentContext!).size.width;
  static double? screenHeight =
      MediaQuery.of(appNavigationKey.currentContext!).size.height;
  static ThemeData appTheme = Theme.of(appNavigationKey.currentContext!);
  static double? customWidth = 100.0;
  ApiService apiService = ApiService(dio.Dio(), AppUrl.apiUrl);
  static FlutterBackgroundService service = FlutterBackgroundService();

  // static bool BackgroundTracking = false;
  // static bool FLDSOS = false;
  // static bool NOMOVSOS = false;

  static String newPhone = "";
  static bool quickSOSFlag = false;
  static String quickSOS_JobID = "";
  static bool isAnySessionLive = false;
  static bool isAnySOSLive = false;
  static String liveSessionID = "";
  static String? currentSOSType = "";
  static String? currentSOSMsg = "";
  static late File frontImage_File;
  static late File backImage_File;

  ///
  /// PROVIDERS
  ///
  static DeploymentProvider deploymentProvider =
  Provider.of<DeploymentProvider>(appNavigationKey.currentContext!,
      listen: false);
}

class TopFunctions {
  ///
  /// FUNCTIONS
  ///
  static showToast(String toastMsg) {
    ScaffoldMessenger.of(TopVariables.appNavigationKey.currentContext!)
        .showSnackBar(
      SnackBar(content: Text(toastMsg)),
    );
  }

  // Check Internet Connectivity Status
  static Future<bool> internetConnectivityStatus() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet Status = Connected');
        return true;
      } else {
        print('Internet Status = Not Connected');
        return false;
      }
    } on SocketException catch (_) {
      print('Internet Status = Not Connected');
      return false;
    }
  }

  // Generate Random Number
  // static const _chars = '1234567890';
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';

  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(Random().nextInt(_chars.length))));
}

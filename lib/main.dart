import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practiceflutter/Firebaseintegration/DefaultFirebaseOptions.dart';
import 'package:practiceflutter/Userlocalstorage/UserPreferences.dart';

import 'Screens/SoloApp.dart';

// void main() {
//   runApp(const MyApp());
// }

Future<void> main() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  WidgetsFlutterBinding.ensureInitialized();
  //  final ThemeService themeService = ThemeServicePrefs();
  //
  // await themeService.init();
  // final ThemeController controller = ThemeController(themeService);
  // await controller.loadAll();
  await Firebase.initializeApp(
    // name: 'Novus Guard Solo',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await initializeService();
  // await listenToFCM();
   await initializePreferences();
  // await initializecontrollerPreferences();
  // MobileAds.instance.initialize();
  runApp(SoloApp());
}



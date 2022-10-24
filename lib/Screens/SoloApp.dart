import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:practiceflutter/Screens/HomePage.dart';
import 'package:practiceflutter/Screens/LoginPage.dart';
import 'package:practiceflutter/Screens/SignUpPage.dart';
import 'package:practiceflutter/Userlocalstorage/UserPreferences.dart';
import 'package:practiceflutter/domain/User.dart';
import 'package:practiceflutter/providers/UserProvider.dart';
import 'package:practiceflutter/utility/TopVariables.dart';
import 'package:provider/provider.dart';

final FlexSchemeColor _schemeLight = FlexSchemeColor.from(
  primary: const Color(0xFF00296B),
  secondary: const Color(0xFFFF7B00),
  appBarColor: Color(0xffce107c)

);
final FlexSchemeColor _schemeDark = FlexSchemeColor.from(
  primary: const Color(0xFF6B8BC3),
  secondary: const Color(0xffff7155),
);
const TextTheme _textTheme = TextTheme(
  headline1: TextStyle(fontSize: 57),
  headline2: TextStyle(fontSize: 45),
  headline3: TextStyle(fontSize: 36),
  overline: TextStyle(fontSize: 11, letterSpacing: 0.5),
);
const FlexSchemeData _myFlexScheme = FlexSchemeData(
  name: 'Midnight blue',
  description: 'Midnight blue theme, custom definition of all colors',
  light: FlexSchemeColor(
    primary: Color(0xFF00296B),
    primaryVariant: Color(0xFF2F5C91),
    secondary: Color(0xFFFF7B00),
    secondaryVariant: Color(0xFFFDB100),
  ),
  dark: FlexSchemeColor(
    primary: Color(0xFF6B8BC3),
    primaryVariant: Color(0xFF4874AA),
    secondary: Color(0xffff7155),
    secondaryVariant: Color(0xFFF1CB9D),
  ),
);
const FlexScheme _scheme = FlexScheme.blueWhale;
const bool _swapColors = false;
const double _appBarElevation = 0.5;
const bool _transparentStatusBar = true;
const FlexTabBarStyle _tabBarForAppBar = FlexTabBarStyle.forAppBar;
final TargetPlatform _platform = defaultTargetPlatform;
const FlexSurfaceMode _surfaceMode = FlexSurfaceMode.highBackgroundLowScaffold;
const int _blendLevel = 40;
const bool _tooltipsMatchBackground = true;
final VisualDensity _visualDensity = FlexColorScheme.comfortablePlatformDensity;
class SoloApp extends StatefulWidget {
  const SoloApp({Key? key}) : super(key: key);


  @override
  State<SoloApp> createState() => _SoloAppState();
}

class _SoloAppState extends State<SoloApp> {

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized(); //You only need to call this method if you need the binding to be initialized before calling runApp.
    // A simple answer is that if Flutter needs to call native code before calling runApp
    Future<User> getUserData() => UserPreferences().getUser();
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ],
    child:  MaterialApp(
      navigatorKey: TopVariables.appNavigationKey,
      title: 'Solo',
      theme: FlexThemeData.light(
        colors: _schemeLight,
        // scheme: _scheme,
        // swapColors: _swapColors,
        // appBarStyle: FlexAppBarStyle.primary,
        // appBarElevation: _appBarElevation,
        // transparentStatusBar: _transparentStatusBar,
        // tabBarStyle: _tabBarForAppBar,
        // surfaceMode: _surfaceMode,
        // blendLevel: _blendLevel,
        // tooltipsMatchBackground: _tooltipsMatchBackground,
        // // fontFamily: _fontFamily,
        //textTheme: _textTheme,
        // primaryTextTheme: _textTheme,
        //
        // visualDensity: _visualDensity,
        platform: _platform,

      ),
      home: FutureBuilder(
        future:getUserData() ,
        builder: (context, snapshot){
          print("snapshot data is ${snapshot.data}");

          if(snapshot.data != null){
            User user = (snapshot.data as User);
            switch(snapshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (user.token == null || user.token == '') {
                  return const LoginPage();
                }
                else{
                  Provider.of<UserProvider>(context, listen: false).setUser((snapshot.data as User));
                  return const HomePage();

                }

            }
            return const LoginPage();

          }

          else {
            return const LoginPage();
          }
        },
      ),
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => HomePage()
      },

      debugShowCheckedModeBanner: false,
    )
    );





  }
}

import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:oktoast/oktoast.dart';
import 'dart:async';
import 'core/constants/constants.dart';
import 'core/constants/entity_factory.dart';
import 'core/constants/shared_preferences_utils_impl.dart';
import 'core/constants/themes.dart';
import 'core/localization/local_setup.dart';
import 'core/services/locator.dart';
import 'core/services/navigation/navigation_service.dart';
import 'package:provider/provider.dart';
import 'screens/Nationalize_Screen.dart';
import 'utils/bloc_listener_notifier/code_challenge_bloc.dart';
import 'package:connectivity/connectivity.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.white,
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark, // For iOS: (light icons)
      statusBarIconBrightness: Brightness.dark, // For Android: (dark icons)
      systemNavigationBarContrastEnforced: false,
      // systemNavigationBarColor: ColorConstant.whiteColor,
      // systemNavigationBarDividerColor: ColorConstant.whiteColor,
      // statusBarColor: ColorConstant.primaryColor,
      systemNavigationBarIconBrightness:
          Brightness.dark, // Dark == white status bar -- for IOS.
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(locale);
  }

  static void refreshApp(BuildContext context) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.refreshApp();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  NavigationService? navigationService = locator<NavigationService>();
  Locale? _locale;
  bool _jailbroken = false;
  bool _developerMode = false;
  ThemeData _currentTheme = ThemeData.light();
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  refreshApp() {
    _getTheme();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    initPlatformStates();
    WidgetsBinding.instance!.addObserver(this);
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }

  Future<void> initPlatformStates() async {
    try {
      if (!isWeb) {
        if (Platform.isAndroid || Platform.isIOS) {
          bool jailbroken = await FlutterJailbreakDetection.jailbroken;
          bool developerMode = await FlutterJailbreakDetection.developerMode;
          if (mounted) {
            setState(() {
              _jailbroken = jailbroken;
              _developerMode = developerMode;
            });
          }
        }
      }
    } on PlatformException {
      if (mounted) {
        setState(() {
          _jailbroken = true;
          _developerMode = true;
        });
      }
    }
    if (_jailbroken == false) {
      // _getDeepLink();
      _getLanguage();
      _getTheme();
    }
  }

  _getLanguage() async {
    Locale? locale = await SharedPreferencesUtilsImpl.getLanguage();
    setState(() {
      _locale = locale;
    });
  }

  _getTheme() async {
    await SharedPreferencesUtilsImpl.isDarkThemeEnabled().then((darkTheme) {
      setState(() {
        if (kIsWeb) {
          _currentTheme = darkTheme ? ThemeData.dark() : ThemeAndroid.light;
        } else if (Platform.isAndroid) {
          _currentTheme = darkTheme ? ThemeAndroid.dark : ThemeAndroid.light;
        } else if (Platform.isIOS) {
          _currentTheme = darkTheme ? ThemeIOS.dark : ThemeIOS.light;
        } else {
          _currentTheme = darkTheme ? ThemeData.dark() : ThemeData.light();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_connectionStatus == ConnectivityResult.none.toString()) {
      return _checkConnectivity();
    }
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    if (_jailbroken == true && appType == AppType.Release) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.bottom]);
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("BuddyBet Coding Challege"),
          ),
          body: SafeArea(
            child: Center(
              child: Text(
                'Rooted Device Detected',
                style: TextStyle(
                    fontSize:
                        AdaptiveTextSize().getadaptiveTextSize(context, 14),
                    color: ColorConstant.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
    }
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return OKToast(
      child: ChangeNotifierProvider<CodeChallengeBloc>(
        create: (context) => CodeChallengeBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          color: ColorConstant.appbarColor,
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
          localeResolutionCallback: loadSupportedLocals,
          locale: _locale ?? Locale('en'),
          builder: (context, myWidget) {
            myWidget = DevicePreview.appBuilder(context, myWidget);
            myWidget = BotToastInit()(context, myWidget);
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                overlays: [SystemUiOverlay.bottom]);
            return myWidget;
          },
          navigatorObservers: [BotToastNavigatorObserver()],
          title: 'BuddyBet Coding Challege',
          navigatorKey: navigationService!.navigatorKey,
          onGenerateRoute: MyRouter.generateRoute,
          theme: _currentTheme,
          themeMode: ThemeMode.system,
          home: NationalizeScreen(),
        ),
      ),
    );
  }

  _checkConnectivity() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("BuddyBet Coding Challege"),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Center(
                    child: Text(
                      "No Internet Connection!",
                      style: AppStyles.customFontCalibri(context,
                          color: ColorConstant.primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                Image.asset('assets/images/nointernet.png', width: 250),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

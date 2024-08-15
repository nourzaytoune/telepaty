import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tourism/Feature/Auth/login.dart';
import 'package:tourism/Feature/Auth/newpassword.dart';
import 'package:tourism/Feature/Auth/verification.dart';
import 'package:tourism/Feature/OnBoarding/skip.dart';
import 'package:tourism/HomeDetails/home.dart';
import 'package:tourism/general/provider.dart';
import 'package:tourism/SettingsDetails/multilanguage.dart';
import 'package:tourism/general/appthemee.dart';
import 'package:tourism/HomeDetails/news.dart';
import 'package:tourism/SettingsDetails/profile.dart';
import 'package:tourism/generated/l10n.dart';
import 'package:tourism/map/map.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => LocaleNotifier()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  //const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final localeNotifier = Provider.of<LocaleNotifier>(context);

    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: localeNotifier.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeNotifier.currentTheme,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
         // return MaterialPageRoute(builder: (_) => OnboardingScreen());
           return MaterialPageRoute(builder: (_) => HomePage());
          case '/login':
            return MaterialPageRoute(builder: (_) => LoginPage());
          case '/newpassword':
            return MaterialPageRoute(builder: (_) => CreateNewPasswordPage());
         // case '/verification':
         //   return MaterialPageRoute(builder: (_) => OtpVerificationPage());
          case '/news':
            return MaterialPageRoute(builder: (_) => NewsPage());
          case '/profile':
            return MaterialPageRoute(builder: (_) => ProfileScreen());
          case '/languageSettings':
            return MaterialPageRoute(builder: (_) => LanguageSettingsScreen ());
          default:
            return null;
        }
      },
    );
  }
}







/*import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tourism/Feature/Auth/login.dart';
import 'package:tourism/Feature/Auth/newpassword.dart';
import 'package:tourism/Feature/Auth/verification.dart';
import 'package:tourism/Feature/OnBoarding/skip.dart';
import 'package:tourism/SettingsDetails/multilanguage.dart';
import 'package:tourism/appthemee.dart';
import 'package:tourism/HomeDetails/news.dart';
import 'package:tourism/SettingsDetails/profile.dart';
import 'package:tourism/generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();

  static of(BuildContext context) {}
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en');

  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: _locale,
      debugShowCheckedModeBanner: false,
  
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => OnboardingScreen());
          case '/login':
            return MaterialPageRoute(builder: (_) => LoginPage(locale: _locale, onLocaleChange: _setLocale));
          // ...
          case '/languageSettings':
            return MaterialPageRoute(builder: (_) => LanguageSettingsScreen(onLocaleChange: _setLocale));
          // ...
          default:
            return null;
        }
      },
    );
  }
}*/







/*import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tourism/Feature/Auth/login.dart';
import 'package:tourism/Feature/Auth/newpassword.dart';
import 'package:tourism/Feature/Auth/verification.dart';
import 'package:tourism/Feature/OnBoarding/skip.dart';
import 'package:tourism/SettingsDetails/multilanguage.dart';
import 'package:tourism/appthemee.dart';
import 'package:tourism/HomeDetails/news.dart';
import 'package:tourism/SettingsDetails/profile.dart';
import 'package:tourism/generated/l10n.dart';
//import 'package:tourism/newaccount.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
           // home:CreateAccountScreen(),
         home:OnboardingScreen(),
        // home:LanguageSettingsScreen(),
          //home:NewsPage(),
     //home:  LoginPage(),
     //home:   CreateNewPasswordPage (),
    // home: ProfileScreen(),
    );
  }
}*/



import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skywatch_application/app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(); TODO: INITIALIZE FIREBASE APP
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    return runApp(
      ModularApp(
        debugMode: kDebugMode,
        module: AppModule(),
        child: const AppWidget(),
      ),
    );
  });
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SkyWatch',
      theme: ThemeData(
        primaryColor: const Color(0xFF5A9AFF),
        scaffoldBackgroundColor: const Color(0xFF283840),
        textTheme: const TextTheme(titleLarge: TextStyle(color: Colors.white)),
        disabledColor: const Color(0xFF96A7AF),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF283840)),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Color(0xFF283840)),
        filledButtonTheme: FilledButtonThemeData(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFF5A9AFF)))),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFFFF464F)))),
        useMaterial3: true,
      ),
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: Modular.routerConfig,
      debugShowCheckedModeBanner: false,
    );
  }
}

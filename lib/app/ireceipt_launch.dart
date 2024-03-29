import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ireceipt/app/app_configuration.dart';
import 'package:ireceipt/router/app_router.gr.dart';
import 'package:ireceipt/util/valut.dart';

@pragma('vm:entry-point', true)
class IReceiptLaunch {
  const IReceiptLaunch._();

  static Future<void> launch(
    ApplicationConfiguration configuration,
  ) async {
    WidgetsFlutterBinding.ensureInitialized();

    await Valut.init();

    await Valut.getConfiguration(configuration.version);

    await Firebase.initializeApp();

    await ScreenUtil.ensureScreenSize();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return runZonedGuarded(
      () => runApp(
        IReceiptApp(),
      ),
      (error, stack) {},
    );
  }
}

class IReceiptApp extends StatelessWidget {
  final _appRouter = AppRouter();

  IReceiptApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      builder: (context, child) {
        ScreenUtil.init(
          context,
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
        );

        return child!;
      },
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xff2c2c2c),
          onPrimary: Color(0xffe8e9ed),
          secondary: Color.fromARGB(255, 128, 128, 128),
          onSecondary: Color(0xff1B1B1B),
          onSecondaryContainer: Color(0xffffffff),
          error: Color(0xffED1B2D),
          onError: Color(0xffED1B2D),
          background: Color(0xfff2f5fa),
          onBackground: Color(0xffF3F3F3),
          surface: Color(0xffFFFFFF),
          onSurface: Color(0xffFFFFFF),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.robotoSlabTextTheme(textTheme),
      ),
    );
  }
}

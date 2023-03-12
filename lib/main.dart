import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ireceipt/router/app_router.gr.dart';
import 'package:ireceipt/util/save.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Save.init();

  await Firebase.initializeApp();

  await ScreenUtil.ensureScreenSize();

  runApp(MyApp());

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
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

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
        // colorSchemeSeed: Color.fromARGB(255, 0, 0, 0),
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xff1B1B1B),
          onPrimary: Color(0xff1B1B1B),
          secondary: Color.fromARGB(255, 128, 128, 128),
          onSecondary: Color(0xff1B1B1B),
          onSecondaryContainer: Color(0xff1B1B1B),
          error: Color(0xffED1B2D),
          onError: Color(0xffED1B2D),
          background: Color(0xffF3F3F3),
          onBackground: Color(0xffF3F3F3),
          surface: Color(0xffFFFFFF),
          onSurface: Color(0xffFFFFFF),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.dhurjatiTextTheme(textTheme),
      ),
    );
  }
}

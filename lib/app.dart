import 'package:clean_pro_user/theme/app_theme.dart';
import 'package:clean_pro_user/theme/cupertino_theme.dart';
import 'package:clean_pro_user/view/auth/login_page.dart';
import 'package:clean_pro_user/view/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
 final String? tocken;
   MyApp({
    required this.tocken,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2280),
      builder: (context, child) => GetMaterialApp(
        home: PlatformApp(
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          material: (context, platform) {
            return MaterialAppData(theme: AppTheme.lightTheme);
          },
          cupertino: (context, platform) {
            return CupertinoAppData(theme: AppCupertinoTheme.theme);
          },
          home:tocken==null? const LoginPage():HomePage(),

          // initialRoute: LoginScreen.route,
          // onGenerateRoute: AppRouter.generateRoute,
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:squch/core/service/page_route_service/app_pages.dart';
import 'package:squch/features/chat_screen_features/presentation/chat_screen.dart';
import 'core/service/LocalizationService.dart';
import 'core/service/Socket_Service.dart';
import 'core/service/firebase_messaging_service.dart';
import 'core/service/firebase_options.dart';
import 'core/service/settings_service.dart';
import 'features/welcome_page_feature/presenation/splash_screen.dart';
import 'package:sizing/sizing.dart';

void main() async {
  String authToken ="";
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    // navigation bar color
    statusBarColor: Colors.white,
    systemNavigationBarContrastEnforced: true,
    systemNavigationBarDividerColor: Colors.grey,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await initService();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]); // lock orientation
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }

  runApp(const MyApp());

}

Future<void> initService() async {
  Get.log('starting services ...');
  WidgetsFlutterBinding.ensureInitialized();
 if(Platform.isAndroid) {
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );
 }
  await Get.putAsync(() => SocketService().initializeSocket());
  await Get.putAsync(() => SettingsService().init());
  Get.log('All services started...');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SizingBuilder(builder: () {
      return GetMaterialApp(
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.AppRoutes,
        debugShowCheckedModeBanner: false,
        translations: LocalizationService(),
        locale: Locale('en', 'US'),
        fallbackLocale: Locale('en', 'US'),
        onReady: () async {
          if(Platform.isAndroid) {
            await Get.putAsync(() => FireBaseMessagingService().init());
          }
        },
        theme: Get.find<SettingsService>().getLightTheme(),
        darkTheme: Get.find<SettingsService>().getDarkTheme(),
        // standard dark theme
        themeMode: Get.find<SettingsService>().getThemeMode(),
        home: const SplashScreen(),
      );
    });
  }
}
/*customerRideNewBid*/
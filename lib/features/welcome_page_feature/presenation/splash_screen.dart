import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:sizing/sizing.dart';
import 'package:squch/core/service/page_route_service/routes.dart';
import 'package:squch/core/shared_pref/shared_pref_impl.dart';
import 'package:squch/core/utils/app_colors.dart';
import 'package:squch/core/utils/image_utils.dart';
import 'package:squch/features/user_auth_feature/presentation/login_page.dart';
import 'package:squch/features/user_auth_feature/presentation/signup_page.dart';
import 'package:squch/features/welcome_page_feature/presenation/how_to_use_this_app.dart';
import 'package:squch/features/welcome_page_feature/presenation/introduction_page.dart';


import '../../../core/shared_pref/shared_pref.dart';
import '../../home_page_feature/presentation/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () async {
      SharedPref sharedPref = Get.put(SharedPrefImpl());
      bool introScreanLoad = await sharedPref.isIntroScreenShown();
      if (introScreanLoad) {
        bool isLoggedin = await sharedPref.isLoggedin();
        if (isLoggedin)
          Get.offNamed(Routes.HOME);
        else
          Get.offNamed(Routes.HOME);
      } else {
        Get.offNamed(Routes.INTRODUCTIONWITHBASICLANDING);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageUtils.splashBackgroundImage),
              fit: BoxFit.fill,
            ),
          ),
          child:  Center(child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.center,children: [
            SvgPicture.asset(ImageUtils.appbarTopLogo,height: 88.38.ss,width: 93.18.ss,),
            Container(height: 10.ss,),
            SvgPicture.asset(ImageUtils.splashBackgroundTextImage,height: 40.95.ss,width: 126.59.ss,),
          ],))
      ),
    );
  }
}


import 'package:get/get.dart' show GetPage, Transition;
import 'package:squch/features/chat_screen_features/presentation/binding/chat_binding.dart';
import 'package:squch/features/chat_screen_features/presentation/chat_screen.dart';
import 'package:squch/features/home_page_feature/presentation/bindings/home_binding.dart';
import 'package:squch/features/home_page_feature/presentation/home_page.dart';
import 'package:squch/features/map_page_feature/presentation/bindings/map_binding.dart';
import 'package:squch/features/map_page_feature/presentation/map_page.dart';
import 'package:squch/features/map_page_feature/presentation/other_reason.dart';
import 'package:squch/features/map_page_feature/presentation/search_ride.dart';
import 'package:squch/features/payment_feature/presentation/payment_option_page.dart';
import 'package:squch/features/rate_ride_feature/presentation/rate_ride_page.dart';
import 'package:squch/features/user_auth_feature/presentation/bindings/auth_binding.dart';
import 'package:squch/features/user_auth_feature/presentation/forgot_password_page.dart';

import 'package:squch/features/user_auth_feature/presentation/login_page.dart';
import 'package:squch/features/user_auth_feature/presentation/set_new_password_page.dart';
import 'package:squch/features/user_auth_feature/presentation/signup_page.dart';
import 'package:squch/features/user_auth_feature/presentation/verify_forgot_password_otp.dart';
import 'package:squch/features/welcome_page_feature/presenation/bindings/welcome_binding.dart';
import 'package:squch/features/welcome_page_feature/presenation/cancel_by_driver.dart';
import 'package:squch/features/welcome_page_feature/presenation/how_to_use_this_app.dart';
import 'package:squch/features/welcome_page_feature/presenation/introduction_page.dart';
import 'package:squch/features/welcome_page_feature/presenation/splash_screen.dart';
import '../../../features/welcome_page_feature/intro_with_basic_landing.dart';
import 'auth_middleware.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = Routes.ROOT;

  static final AppRoutes = [
     GetPage(name: Routes.ROOT, page: () => SplashScreen(), binding: WelcomeBinding()),

     GetPage(name: Routes.INTRODUCTION, page: () => IntroductionPage(), binding: WelcomeBinding()),
     GetPage(name: Routes.HOW_TO_USE_PAGE, page: () => HowToUseThisApp(), binding: WelcomeBinding()),
     GetPage(name: Routes.CANCEL_BY_DRIVER, page: () => CancelByDriver(), binding: WelcomeBinding()),
    GetPage(
        name: Routes.INTRODUCTIONWITHBASICLANDING,
        page: () => IntroWithBasicLandingPage(),
        binding: WelcomeBinding()),
     GetPage(
        name: Routes.LOGIN,
        page: () => LoginPage(),
        binding: AuthBinding(),
        middlewares: [AuthMiddleware()],
      transitionDuration: Duration(milliseconds: 100)
    ),
     GetPage(
        name: Routes.REGISTER,
        page: () => SignUpPage(),
        binding: AuthBinding(),
        middlewares: [AuthMiddleware()],
      transitionDuration: Duration(milliseconds: 100)
    ),
     GetPage(
        name: Routes.REGISTER_OTP_VERIFICATION,
        page: () => SignUpPage(),
        binding: AuthBinding(),
        middlewares: [AuthMiddleware()],
      transitionDuration: Duration(milliseconds: 100)
    ),
     GetPage(
        name: Routes.REGISTER_OTP_VERIFICATION,
        page: () => VerifyForgetPasswordOtp(),
        binding: AuthBinding(),
        middlewares: [AuthMiddleware()],
      transitionDuration: Duration(milliseconds: 100)
    ),

     GetPage(
        name: Routes.FORGOT_PASSWORD,
        page: () => ForgotPasswordPage(),
        binding: AuthBinding(),
        middlewares: [AuthMiddleware()],
      transitionDuration: Duration(milliseconds: 100)
    ),
     GetPage(
        name: Routes.FORGOT_PASSWORD_OTP_VERIFICATION,
        page: () => VerifyForgetPasswordOtp(),
        binding: AuthBinding(),
        middlewares: [AuthMiddleware()],
      transitionDuration: Duration(milliseconds: 100)
    ),
     GetPage(
        name: Routes.SETUP_NEW_PASSWORD,
        page: () => SetNewPasswordPage(),
        binding: AuthBinding(),
        middlewares: [AuthMiddleware()],
        transitionDuration: Duration(milliseconds: 100)
    ),

     GetPage(
        name: Routes.HOME,
        page: () => HomePage(),
        binding: HomeBinding(),
        middlewares: [AuthMiddleware()],
        transitionDuration: Duration(milliseconds: 100)
    ),

    GetPage(
        name: Routes.SEARCH_RIDE,
        page: () => SearchRide(),
        binding: MapBinding(),
        middlewares: [AuthMiddleware()],
        transitionDuration: Duration(milliseconds: 100)
    ),GetPage(
        name: Routes.MAP_PAGE,
        page: () => MapPage(),
        binding: MapBinding(),
        middlewares: [AuthMiddleware()],
        transitionDuration: Duration(milliseconds: 100)
    ),
GetPage(
        name: Routes.OTHER_REASON,
        page: () => OterReason(),
        binding: MapBinding(),
        middlewares: [AuthMiddleware()],
        transitionDuration: Duration(milliseconds: 100)
    ),
GetPage(
        name: Routes.PAYMENT_OPTION,
        page: () => PaymentOptionPage(),
        binding: MapBinding(),
        middlewares: [AuthMiddleware()],
        transitionDuration: Duration(milliseconds: 100)
    ),
    GetPage(
        name: Routes.RATE_RIDE,
        page: () => RateRidePage(total:"\$616.80",tripCharge: "\$216.00",subTotal: "\$216.00",rounding: "\$111.00",bookingFee: "\$16.00",ridePromotion: "-\$56.00",date: "1/14/24",paidBy: "paypal",time: "10:34pm",payments: "\$616.80",),
        binding: MapBinding(),
        middlewares: [AuthMiddleware()],
        transitionDuration: Duration(milliseconds: 100)
    ),
    GetPage(
        name: Routes.CHAT_SCREEN,
        page: () => ChatScreen(),
        binding: ChatBinding(),
        middlewares: [AuthMiddleware()],
        transitionDuration: Duration(milliseconds: 100)
    ),
  ];
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;
import 'package:squch/core/service/page_route_service/routes.dart';
import 'package:squch/core/utils/Status.dart';

import '../../../../core/network_checker/common_network_checker_controller.dart';
import '../../../../core/network_checker/common_no_network_widget.dart';
import '../../../../core/shared_pref/shared_pref.dart';
import '../../../../core/utils/Resource.dart';
import '../../../../core/utils/utils.dart';
import '../../../home_page_feature/presentation/home_page.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final SharedPref sharedPref;
  final AuthRepository authRepository;
  RxBool isLoading = false.obs;
  RxBool rememberMe = false.obs;

  RxBool toggleObscured = false.obs;

  AuthController({required this.sharedPref, required this.authRepository});

  final userLoginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final CommonNetWorkStatusCheckerController _netWorkStatusChecker =
      Get.put(CommonNetWorkStatusCheckerController());

  @override
  void onInit() {
    _netWorkStatusChecker.updateConnectionStatus();
    getRememberData();
    // Get called when controller is created
    super.onInit();
  }

  @override
  void onReady() {
    // Get called after widget is rendered on the screen
    super.onReady();
  }

  @override
  void onClose() {
    //Get called when controller is removed from memory
    super.onClose();
  }

  Future login() async {
    if (!userLoginFormKey.currentState!.validate()) {
      return;
    } else {
      if (await _netWorkStatusChecker.isInternetAvailable()) {
        if (rememberMe.isTrue) {
          sharedPref.setRememberMe(rememberMe.value);
          sharedPref.setLoggedinIdPassword(
              emailController.text, passwordController.text);
        } else {
          sharedPref.setRememberMe(rememberMe.value);
          sharedPref.setLoggedinIdPassword("", "");
        }
        isLoading.value = true;
        String fcmToken = await sharedPref.getFCMToken();
        Resource loginResource = await authRepository.userLogin(
            emailController.text, passwordController.text,fcmToken);
        if (loginResource.status == STATUS.SUCCESS) {
          isLoading.value = false;
          showSuccessSnackbar(
              "Success", loginResource.message ?? "Login Success");
          sharedPref.setLogindata(jsonEncode(loginResource.data));
          sharedPref.setToken(loginResource.data.token);
          sharedPref.setIntroScreenShown(true);
          sharedPref.setLoggedin(true);
          ClearFormData();
          Get.offAllNamed(Routes.HOME);
        } else {
          isLoading.value = false;
          showFailureSnackbar(
              "Failed", loginResource.message ?? "Login Failed");
        }
      } else {
        Get.dialog(const CommonNoInterNetWidget());
      }
    }
  }

  ClearFormData() {
    emailController.text = "";
    passwordController.text = "";
  }

  Future<void> handleAppleSignIn() async {
    if (Platform.isIOS || Platform.isMacOS) {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'com.app.company.name',
          redirectUri: Uri.parse(
            'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
          ),
        ),
      );
      /* await GetStorage().write("userId", credential.userIdentifier);
      if (credential.familyName != null) {
        await GetStorage().write(
            "name", "${credential.familyName} ${credential.givenName} ");
      }
      if (credential.email != null) {
        await GetStorage().write("email", credential.email);
      }*/

      if (credential is AuthorizationCredentialAppleID) {
        // print("hi");

        /// send credentials to your server to create a session
        /// after they have been validated with Apple
      } else if (credential is AuthorizationCredentialPassword) {
        print("hello");
      }

      /// Login the user using username/password combination

      /* Get.dialog(
          Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black12,
              child: Center(
                  child:
                  CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Colors.deepOrangeAccent),
                  )
              )

            // Center(child:Image.asset(Assets.loaderGif, height: ScreenConstant.sizeXXXL,)),
          ),
          barrierColor: Colors.transparent,
          barrierDismissible: false);*/
      /* final userId = await GetStorage().read("userId");
      final name = await GetStorage().read("name");
      final email = await GetStorage().read("email");*/
    }
  }

  Future fbLogin() async {
    try {
      final LoginResult result =
          await FacebookAuth.instance.login(permissions: ['email']);

      if (result.status == LoginStatus.success) {
        final AccessToken? accessToken = result.accessToken;

        var graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${accessToken!.token}'));
        if (graphResponse.statusCode == 200) {
          var profile = json.decode(graphResponse.body);
          String fName = profile['first_name'];
          String lName = profile['last_name'];
          String fbId = profile['id'];
          String fbEmail = profile['email'];

          //  String languageCode = await _pref.getLanguageCode();
          // Utils.toast(fName+" "+lName);

          // return data;
        } else {
          // Utils.toast('Sorry! Something went wrong in Facebook login!');
        }
      } else {
        print(result.status);
        print(result.message);
      }
    } catch (ex) {
      print(ex);
    }
  }

  void getRememberData() async {
    if (await sharedPref.isRememberMe() == true) {
      rememberMe.value = true;
      emailController.text = await sharedPref.getLoginId() ?? "";
      passwordController.text = await sharedPref.getLoginPassword() ?? "";
    } else {
      rememberMe.value = false;
      emailController.text = "";
      passwordController.text = "";
    }
  }

  void showPassword() {
    toggleObscured.value = !toggleObscured.value;
  }
}

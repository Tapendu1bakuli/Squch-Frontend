import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squch/core/common/common_button.dart';
import 'package:squch/core/common/common_text_form_field.dart';
import 'package:squch/core/service/page_route_service/routes.dart';
import 'package:squch/core/utils/app_colors.dart';
import 'package:squch/core/utils/app_strings.dart';
import 'package:squch/core/utils/fonts.dart';
import 'package:squch/core/utils/image_utils.dart';
import 'package:squch/core/widgets/gap.dart';
import 'package:sizing/sizing.dart';
import 'package:get/get.dart';
import 'package:squch/core/widgets/horizontal_gap.dart';
import 'package:squch/core/widgets/title_text.dart';
import 'package:squch/features/user_auth_feature/presentation/controller/auth_controller.dart';
import 'package:squch/features/user_auth_feature/presentation/forgot_password_page.dart';
import 'package:squch/features/user_auth_feature/presentation/signup_page.dart';

import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/utils/validator.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(() => SafeArea(
          top: false,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: size.height / 6,
                    width: size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(ImageUtils.loginBackTop))),
                  ),
                  SvgPicture.asset(
                    ImageUtils.splashIcon,
                    color: AppColors.buttonColor,
                  ),
                  Gap(10.ss),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0.ss),
                    child: Form(
                      key: controller.userLoginFormKey,
                      child: Column(
                        children: [
                          Text(
                            AppStrings.HiWelcomeBack.tr,
                            style: CustomTextStyle(
                                color: AppColors.titleColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 20.fss),
                          ),
                          Gap(10.ss),
                          CommonTextFormField(
                            controller: controller.emailController,
                            isEnable: !controller.isLoading.value,
                            onValidator: Validator().validateEmail,
                            inputFormatters: [LowerCaseTextFormatter()],
                            hintText: AppStrings.email.tr,
                          ),
                          Gap(10.ss),
                          CommonTextFormField(
                            hintText: AppStrings.password.tr,
                            controller: controller.passwordController,
                            onValidator: Validator().validatePassword,
                            obscureText: controller.toggleObscured.isFalse,
                            isEnable: !controller.isLoading.value,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                              child: GestureDetector(
                                onTap: controller.showPassword,
                                child: Icon(
                                  controller.toggleObscured.isTrue
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                          Gap(20.ss),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0.ss),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IgnorePointer(
                                      ignoring: controller.isLoading.value,
                                      child: Checkbox(
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.padded,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0)),
                                        value: controller.rememberMe.value,
                                        focusColor:
                                            Theme.of(context).brightness !=
                                                    Brightness.dark
                                                ? AppColors.colorWhite
                                                : AppColors.titleColor,
                                        checkColor:
                                            Theme.of(context).brightness !=
                                                    Brightness.dark
                                                ? AppColors.colorWhite
                                                : AppColors.titleColor,
                                        onChanged: (value) {
                                          controller.rememberMe.value =
                                              value ?? false;
                                        },
                                      ),
                                    ),
                                    Text(
                                      AppStrings.rememberMe.tr,
                                      style: CustomTextStyle(
                                          color: AppColors.buttonColor,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 14.fss),
                                    )
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.FORGOT_PASSWORD);
                                  },
                                  child: Text(
                                    AppStrings.forgotPasswordText.tr,
                                    style: CustomTextStyle(
                                        color: AppColors.buttonColor,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14.fss),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(10.ss),
                          controller.isLoading.value
                              ? CircularProgressIndicator()
                              : Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0.ss),
                                  child: CommonButton(
                                    label: AppStrings.Login.tr,
                                    onClicked: () {
                                      controller.login();
                                    },
                                  ),
                                ),
                          Gap(20.ss),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0.ss),
                            child: Row(
                              children: [
                                Expanded(child: Divider(thickness: 1.ss)),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.ss),
                                  child: Text(AppStrings.or.tr),
                                ),
                                Expanded(
                                    child: Divider(
                                  thickness: 1.ss,
                                )),
                              ],
                            ),
                          ),
                          Gap(20.ss),
                          SocialButton(ImageUtils.google,
                              AppStrings.ContinueWithGoogle.tr, context),
                          Gap(10.ss),
                          InkWell(
                              onTap: () {
                                controller.handleAppleSignIn();
                              },
                              child: SocialButton(ImageUtils.apple,
                                  AppStrings.ContinueWithApple.tr, context)),
                          Gap(10.ss),
                          InkWell(
                              onTap: () async {
                                await controller.fbLogin();
                              },
                              child: SocialButton(ImageUtils.facebook,
                                  AppStrings.ContinueWithFacebook.tr, context)),
                          Gap(40.ss),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.REGISTER);
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      text: AppStrings.NewUserText.tr,
                                      style:
                                          CustomTextStyle(color: Colors.grey),
                                      children: [
                                        TextSpan(
                                            text: " " + AppStrings.SignUp.tr,
                                            style: CustomTextStyle(
                                                color: AppColors.buttonColor,
                                                fontWeight: FontWeight.w800)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(20.ss),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget SocialButton(String assetIcon, String title, BuildContext context) {
    return Container(
      height: 50.ss,
      margin: EdgeInsets.symmetric(horizontal: 20.0.ss),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.ss)),
          border: Border.all(color: AppColors.colorgrey)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(assetIcon),
            SvgPicture.asset(
              assetIcon,
            ),
            HorizontalGap(10.ss),
            Flexible(child: TitleText(context, title))
          ],
        ),
      ),
    );
  }
}

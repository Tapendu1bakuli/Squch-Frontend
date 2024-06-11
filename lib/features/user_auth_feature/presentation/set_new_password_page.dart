import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squch/core/common/common_button.dart';
import 'package:squch/core/common/common_text_form_field.dart';
import 'package:squch/core/utils/app_strings.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';
import 'package:squch/core/utils/fonts.dart';
import 'package:squch/core/utils/validator.dart';
import 'package:squch/core/widgets/gap.dart';
import 'package:squch/core/widgets/title_text.dart';
import 'package:squch/features/user_auth_feature/data/models/verify_otp_success_response.dart';
import 'package:squch/features/user_auth_feature/presentation/controller/forgot_password_controller.dart';
import 'package:squch/features/user_auth_feature/presentation/forgot_password_sent_success.dart';
import 'package:squch/features/user_auth_feature/presentation/verify_forgot_password_otp.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/common_app_bar.dart';
import 'package:country_code_picker/country_code_picker.dart';

class SetNewPasswordPage extends GetView<ForgotPasswordController> {
  SetNewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(
          title: AppStrings.newPassword.tr,
          isIconShow: true,
          onPressed: () {
            Get.back();
          }),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.ss, vertical: 20.ss),
        child: Obx(
          () => controller.isLoading.isTrue
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CommonButton(
                  onClicked: () {
                    controller.setPasssword();
                  },
                  label: AppStrings.next.tr,
                ),
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0.ss,
          ),
          child: Container(
            height: MediaQuery.sizeOf(context).height - 50,
            child: Form(
              key: controller.setNewPasswordFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(20.ss),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0.ss),
                    child: TitleText(context, AppStrings.password.tr),
                  ),
                  Gap(10.ss),
                  CommonTextFormField(
                    padding: 0,
                    controller: controller.newPasswordController,
                    onValidator: Validator().validatePassword,
                    obscureText: controller.toggleObscuredNew.isFalse,
                    isEnable: !controller.isLoading.value,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: GestureDetector(
                        onTap: controller.showPasswordNew,
                        child: Icon(
                          controller.toggleObscuredNew.isTrue
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
                    child: TitleText(context, AppStrings.confirmPassword.tr),
                  ),
                  Gap(10.ss),
                  CommonTextFormField(
                    padding: 0,
                    controller: controller.confirmPasswordController,
                    onValidator: (name) {
                      if (controller.confirmPasswordController.text == null ||
                          controller.confirmPasswordController.text.isEmpty) {
                        return 'Enter Confirm Password';
                      } else if (controller.confirmPasswordController.text !=
                          controller.newPasswordController.text) {
                        return "Confirm password doesn't match with Password";
                      } else {
                        return null;
                      }
                    },
                    obscureText: controller.toggleObscuredConfirm.isFalse,
                    isEnable: !controller.isLoading.value,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: GestureDetector(
                        onTap: controller.showPasswordConfirm,
                        child: Icon(
                          controller.toggleObscuredConfirm.isTrue
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          size: 24,
                        ),
                      ),
                    ),
                    // onValidator: Validator().validateConfirmPassword(controller.passwordController.text,controller.confirmPasswordController.text),
                  ),
                  Gap(10.ss),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0.ss),
                    child: Text(
                      AppStrings.setPasswordMessage.tr,
                      style: CustomTextStyle(),
                    ),
                  ),
                  Gap(30.ss),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squch/core/common/common_button.dart';
import 'package:squch/core/common/common_dropdown.dart';
import 'package:squch/core/common/common_text_form_field.dart';
import 'package:squch/core/service/page_route_service/routes.dart';
import 'package:squch/core/utils/fonts.dart';
import 'package:squch/core/widgets/common_app_bar.dart';
import 'package:sizing/sizing.dart';
import 'package:squch/features/user_auth_feature/presentation/controller/registration_controller.dart';
import 'package:squch/features/user_auth_feature/presentation/login_page.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';
import '../../../core/utils/image_utils.dart';
import '../../../core/utils/validator.dart';
import '../../../core/widgets/gap.dart';
import '../../../core/widgets/horizontal_gap.dart';
import '../../../core/widgets/title_text.dart';


class SignUpPage extends GetView<RegistrationController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height / 12),
          child: CommonAppbar(
            title: AppStrings.CreateYourAccount.tr,
            isIconShow: true,
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Obx(() => SafeArea(
              child: controller.isInitialLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.ss),
                          child: Form(
                            key: controller.userRegistrationFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.0.ss),
                                              child: TitleText(
                                                  context, AppStrings.Name.tr),
                                            ),
                                            Gap(10.ss),
                                            CommonTextFormField(
                                              hintText: AppStrings.enterName.tr,
                                              controller: controller
                                                  .firstNameController,
                                              onValidator: (name) {
                                                if (name == null ||
                                                    name.isEmpty) {
                                                  return AppStrings.enterName.tr;
                                                }
                                              },
                                            )
                                          ],
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.0.ss),
                                              child: TitleText(context,
                                                  AppStrings.LastName.tr),
                                            ),
                                            Gap(10.ss),
                                            CommonTextFormField(
                                              hintText:
                                                  AppStrings.enterLastName.tr,
                                              controller:
                                                  controller.lastNameController,
                                              onValidator: (name) {
                                                if (name == null ||
                                                    name.isEmpty) {
                                                  return AppStrings.enterLastName.tr;
                                                }
                                              },
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                                Gap(20.ss),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0.ss),
                                  child: TitleText(
                                      context, AppStrings.phoneNumber.tr),
                                ),
                                Gap(10.ss),
                                Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 20.ss),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.ss),
                                      ),
                                      border: Border.all(
                                        width:
                                            controller.isValidPhoneNo.value ==
                                                    false
                                                ? 1.ss
                                                : 0.5.ss,
                                        color:
                                            controller.isValidPhoneNo.value ==
                                                    false
                                                ? Colors.red
                                                : Colors.black,
                                      )),
                                  child: Row(
                                    children: [
                                      //CommonTextFormField(width: MediaQuery.sizeOf(context).width/4,),
                                      Container(
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                4,
                                        child: CountryCodePicker(
                                          onChanged: (newValue) {
                                            controller
                                                    .selectedCountryCode.value =
                                                newValue.dialCode ?? "+91";
                                          },
                                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                          initialSelection: controller
                                              .selectedCountryCode.value,
                                          favorite: ['+91', 'IN'],
                                          // optional. Shows only country name and flag
                                          showCountryOnly: false,
                                          // optional. Shows only country name and flag when popup is closed.
                                          showOnlyCountryWhenClosed: false,
                                          // optional. aligns the flag and the Text left
                                          alignLeft: false,
                                        ),
                                      ),

                                      Container(
                                        height: 30.ss,
                                        width: 0.5.ss,
                                        color: Colors.black,
                                      ),
                                      Flexible(
                                          child: CommonTextFormField(
                                        hintText:
                                            AppStrings.enterPhoneNumber.tr,
                                        controller:
                                            controller.phoneNumberController,
                                        textInputType: TextInputType.number,
                                        maxLength: 10,
                                        height: 50.ss,
                                        //  onValidator: Validator().validateMobile,
                                        onValueChanged: (value) {
                                          controller.phoneValidationMsg.value =
                                              Validator()
                                                      .validateMobile(value) ??
                                                  "";
                                          if (Validator()
                                                  .validateMobile(value) !=
                                              null) {
                                            controller.isValidPhoneNo.value =
                                                false;
                                          } else
                                            controller.isValidPhoneNo.value =
                                                true;
                                        },
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                AppStrings.enterPhoneNumber.tr,
                                            hintStyle: CustomTextStyle(
                                                color: Theme.of(context)
                                                            .brightness !=
                                                        Brightness.dark
                                                    ? AppColors.textSubBlack
                                                    : Colors.white,
                                                fontSize: 14.fss),
                                            counterText: ""),
                                      )),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: !controller.isValidPhoneNo.value &&
                                      controller
                                          .phoneValidationMsg.value.isNotEmpty,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0.ss, vertical: 5.ss),
                                    child: Text(
                                      controller.phoneValidationMsg.value,
                                      style: CustomTextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                                Gap(20.ss),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0.ss),
                                  child: TitleText(
                                      context, AppStrings.emailAddress.tr),
                                ),
                                Gap(10.ss),
                                CommonTextFormField(
                                  hintText: AppStrings.enterEmailAddress.tr,
                                  textInputType: TextInputType.emailAddress,
                                  controller: controller.emailController,
                                  onValidator: Validator().validateEmail,
                                  inputFormatters: [LowerCaseTextFormatter()],
                                ),
                                Gap(20.ss),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0.ss),
                                  child: TitleText(
                                      context, AppStrings.password.tr),
                                ),
                                Gap(10.ss),
                                CommonTextFormField(
                                  hintText: AppStrings.enterPassword.tr,
                                  controller: controller.passwordController,
                                  onValidator: Validator().validatePassword,
                                  obscureText:
                                      controller.toggleObscuredNew.isFalse,
                                  isEnable: !controller.isLoading.value,
                                  suffixIcon: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 4, 0),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0.ss),
                                  child: TitleText(
                                      context, AppStrings.confirmPassword.tr),
                                ),
                                Gap(10.ss),
                                CommonTextFormField(
                                  hintText: AppStrings.enterConfirmPassword.tr,
                                  controller:
                                      controller.confirmPasswordController,
                                  onValidator: (name) {
                                    if (controller.confirmPasswordController
                                                .text ==
                                            null ||
                                        controller.confirmPasswordController
                                            .text.isEmpty) {
                                      return AppStrings.enterConfirmPassword.tr;
                                    } else if (controller
                                            .confirmPasswordController.text !=
                                        controller.passwordController.text) {
                                      return "Confirm password doesn't match with Password";
                                    } else {
                                      return null;
                                    }
                                  },
                                  obscureText:
                                      controller.toggleObscuredConfirm.isFalse,
                                  isEnable: !controller.isLoading.value,
                                  suffixIcon: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 4, 0),
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
                                  // onValidator: Validator().validateConfirmPassword(_registrationController.passwordController.text,_registrationController.confirmPasswordController.text),
                                ),
                                /* Gap(10.ss),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 20.0.ss),
                              child: Row(
                                children: [
                                  ImageIcon(AssetImage(ImageUtils.closeCircle),color: Colors.red,),
                                  HorizontalGap(5.ss),
                                  Text("Password Strength: Weak",style: CustomTextStyle(
                                    color: Colors.red,
                                  ),)
                                ],
                              ),
                            ),*/
                                Gap(20.ss),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0.ss),
                                  child: TitleText(
                                      context, AppStrings.refCodeOptional.tr),
                                ),
                                Gap(10.ss),
                                CommonTextFormField(
                                  hintText: AppStrings.enterRefCode.tr,
                                  controller: controller.referralCodeController,
                                ),
                                Gap(20.ss),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0.ss),
                                  child: TitleText(
                                      context, AppStrings.selectCountry.tr),
                                ),
                                Gap(10.ss),
                                CommonDropdown(
                                    selectedValue:
                                        controller.selectedCountry.value,
                                    options: controller.countryList,
                                    onChange: (newValue) {
                                      controller.selectedCountry.value =
                                          newValue;
                                    }),
                                Gap(20.ss),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0.ss),
                                  child: TitleText(
                                      context, AppStrings.selectLanguage.tr),
                                ),
                                Gap(10.ss),
                                CommonDropdown(
                                    selectedValue:
                                        controller.selectedLanguage.value,
                                    options: controller.languageList,
                                    onChange: (newValue) {
                                      controller.selectedLanguage.value =
                                          newValue;
                                    }),
                                Gap(20.ss),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0.ss),
                                  child: TitleText(
                                      context, AppStrings.currency.tr),
                                ),
                                Gap(10.ss),
                                CommonDropdown(
                                    selectedValue:
                                        controller.selectedCurrency.value,
                                    options: controller.currencyList,
                                    onChange: (newValue) {
                                      controller.selectedCurrency.value =
                                          newValue;
                                    }),
                                Gap(20.ss),
                                Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 20.ss),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.ss, vertical: 10.ss),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.colorgrey,
                                          width: 0.5.ss),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.ss)),
                                      color: AppColors.colorlightgrey),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Transform.scale(
                                              scale: 1.5,
                                              child: Checkbox(
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .padded,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0)),
                                                value: controller
                                                    .iAmNotARobot.value,
                                                focusColor: Theme.of(context)
                                                            .brightness !=
                                                        Brightness.dark
                                                    ? AppColors.colorWhite
                                                    : AppColors.titleColor,
                                                checkColor: Theme.of(context)
                                                            .brightness !=
                                                        Brightness.dark
                                                    ? AppColors.colorWhite
                                                    : AppColors.titleColor,
                                                onChanged: (value) {
                                                  controller.iAmNotARobot
                                                      .value = value ?? false;
                                                },
                                              )),
                                          Text(
                                            AppStrings.IMNotRobot.tr,
                                            style: CustomTextStyle(
                                              fontSize: 16.fss,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? AppColors.colorWhite
                                                  : AppColors.titleColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                        ImageUtils.recaptcha,
                                        height: 60,
                                        width: 60,
                                      )
                                    ],
                                  ),
                                ),
                                Gap(20.ss),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0.ss),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Transform.scale(
                                              scale: 1.0,
                                              child: Checkbox(
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .padded,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                value: controller
                                                    .isTermAndConditionChecked
                                                    .value,
                                                onChanged: (value) {
                                                  controller
                                                      .isTermAndConditionChecked
                                                      .value = value ?? false;
                                                },
                                              )),
                                        ],
                                      ),
                                      Flexible(
                                        child: RichText(
                                          text: TextSpan(
                                            text: AppStrings
                                                .SignUpAgreeTermsText.tr,
                                            style: CustomTextStyle(
                                                color: Theme.of(context)
                                                            .brightness !=
                                                        Brightness.dark
                                                    ? Colors.black
                                                    : Colors.white),
                                            children: [
                                              TextSpan(
                                                  text: AppStrings
                                                      .TermsOfService.tr,
                                                  style: CustomTextStyle(
                                                      color: Theme.of(context)
                                                                  .brightness !=
                                                              Brightness.dark
                                                          ? AppColors
                                                              .buttonColor
                                                          : Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              TextSpan(
                                                  text: AppStrings.and.tr,
                                                  style: CustomTextStyle()),
                                              TextSpan(
                                                  text: AppStrings
                                                      .PrivacyPolicy.tr,
                                                  style: CustomTextStyle(
                                                      color:
                                                          AppColors.buttonColor,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(20.ss),
                                controller.isLoading.value
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(),
                                        ],
                                      )
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0.ss,
                                            vertical: 10.ss),
                                        child: CommonButton(
                                          label: AppStrings.SignUp.tr,
                                          onClicked: () {
                                            controller.signup();
                                          },
                                        ),
                                      ),
                                Gap(10.ss),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: InkWell(
                                        onTap: () {
                                          Get.toNamed(Routes.LOGIN);
                                        },
                                        child: RichText(
                                          text: TextSpan(
                                            text: AppStrings.AlreadyAUser.tr,
                                            style: CustomTextStyle(
                                                color: Colors.grey),
                                            children: [
                                              TextSpan(
                                                  text: AppStrings.Login.tr,
                                                  style: CustomTextStyle(
                                                      color:
                                                          AppColors.buttonColor,
                                                      fontWeight:
                                                          FontWeight.w800)),
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
                        controller.isLoading.value
                            ? Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child:
                                    Center(child: CircularProgressIndicator()))
                            : Offstage()
                      ],
                    )),
            )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';
import 'package:squch/core/widgets/gap.dart';

import '../../core/common/common_button.dart';
import '../../core/service/page_route_service/routes.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_strings.dart';
import '../../core/utils/fonts.dart';
import 'presenation/controller/introduction_controller.dart';

class IntroWithBasicLandingPage extends GetView<IntroductionController> {
  const IntroWithBasicLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: ClampingScrollPhysics(),
        children: controller.pageList,
        scrollDirection: Axis.horizontal,
        controller: controller.pageController,
        onPageChanged: (int page) {
          controller.index.value = page;
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton:
          Obx(() => controller.index == controller.pageList.length - 1
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.ss),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: CommonButton(
                          label: AppStrings.getStarted.tr,
                          onClicked: () {
                            Get.toNamed(Routes.INTRODUCTION);
                          },
                        ),
                      ),
                      Gap(14.ss),
                      Flexible(
                        child: CommonButton(
                          label: AppStrings.signIn.tr,
                          onClicked: () {
                            Get.offAllNamed(Routes.LOGIN);
                          },
                        ),
                      ),
                      Gap(20.ss),
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(20.ss),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: controller.onSkip,
                        child: Text(
                          AppStrings.skip.tr,
                          style: CustomTextStyle(
                              color: AppColors.colorBlack,
                              fontWeight: FontWeight.w700,
                              fontSize: 15.fss),
                        ),
                      ),
                      InkWell(
                        onTap: controller.tapNext,
                        child: Container(
                          width: 60.0.ss,
                          height: 60.0.ss,
                          decoration: new BoxDecoration(
                            color: AppColors.buttonColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.colorWhite,
                            size: 24.ss,
                          ),
                        ),
                      ),
                    ],
                  ))),
    );
  }
}

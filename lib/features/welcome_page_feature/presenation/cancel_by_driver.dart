import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:squch/core/utils/image_utils.dart';
import 'package:squch/features/user_auth_feature/presentation/login_page.dart';
import 'package:squch/features/welcome_page_feature/presenation/controller/introduction_controller.dart';

import '../../../core/common/common_button.dart';
import '../../../core/common/see_all_button.dart';
import '../../../core/service/page_route_service/routes.dart';
import '../../../core/shared_pref/shared_pref.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/fonts.dart';
import 'package:sizing/sizing.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../core/widgets/gap.dart';
import '../../../core/widgets/title_text.dart';

import 'package:get/get.dart';

class CancelByDriver extends GetView<IntroductionController> {
  String? pageTitle;

  CancelByDriver({super.key, this.pageTitle});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height / 12),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.ss),
              width: MediaQuery.of(context).size.width,
              height: 45,
              // color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    child: SvgPicture.asset(ImageUtils.close),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  Expanded(
                    child: Text(
                      pageTitle ?? AppStrings.CancelByDriver.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              fontWeight: FontWeight.w800, fontSize: 18.ss),
                    ),
                  ),
                  Container(
                    width: 10.ss,
                  )
                ],
              ),
            )),
        body: Obx(() => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (controller.cancelBydriverData.value.content
                                      ?.coverImage ??
                                  "")
                              .isNotEmpty
                          ? Container(
                              height: 250.ss,
                              width: size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(controller
                                              .cancelBydriverData
                                              .value
                                              .content
                                              ?.coverImage ??
                                          ""),
                                      fit: BoxFit.cover)),
                            )
                          : Offstage(),
                      Gap(
                        20.ss,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0.ss),
                        child: Text(
                          controller.cancelBydriverData.value.content
                                  ?.pageTitle ??
                              "",
                          style: CustomTextStyle(
                              fontSize: 18.fss, fontWeight: FontWeight.w800),
                        ),
                      ),
                      Gap(
                        10.ss,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0.ss),
                        child: Html(
                          data: controller.cancelBydriverData.value.content ==
                                  null
                              ? ""
                              : controller.cancelBydriverData.value.content
                                      ?.pageContent ??
                                  "",
                        ),
                      )
                    ],
                  ),
                ),
              )),
        bottomNavigationBar: Obx(() => controller.isLoading.value
            ? Container()
            : Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0.ss, vertical: 10.ss),
                child: CommonButton(
                  buttonWidth: MediaQuery.sizeOf(context).width - 100,
                  label: AppStrings.gotIt.tr,
                  onClicked: () async {
                    if ((pageTitle ?? "").isNotEmpty) {
                      Get.back();
                    } else {
                      SharedPref sharedPref = Get.find();
                      await sharedPref.setIntroScreenShown(true);
                      Get.offAllNamed(Routes.HOME);
                    }
                  },
                ),
              )),
      ),
    );
  }
}

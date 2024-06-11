import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizing/sizing.dart';
import 'package:squch/core/utils/app_colors.dart';
import 'package:squch/core/utils/image_utils.dart';
import 'package:squch/features/home_page_feature/presentation/controller/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        body: SafeArea(
          child: controller.widgetOptions
              .elementAt(controller.selectedIndex.value),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          // backgroundColor: colorScheme.surface,
          // selectedItemColor: colorScheme.onSurface,
          unselectedItemColor: AppColors.colorWhite.withOpacity(.35),
          // selectedLabelStyle: textTheme.caption,
          // unselectedLabelStyle: textTheme.caption,
          // type: BottomNavigationBarType.shifting,
          currentIndex: controller.selectedIndex.value,
          backgroundColor: AppColors.buttonColor,
          selectedItemColor: AppColors.colorWhite,
          iconSize: 28,
          onTap: controller.onItemTapped,
          elevation: 0,

          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Column(
                children: [
                  controller.selectedIndex.value == 0
                      ? Container(
                          width: 57.ss,
                          height: 3.ss,
                          color: Colors.white,
                        )
                      : const Offstage(),
                  Container(
                    height: 10.ss,
                  ),
                  SvgPicture.asset(
                    controller.selectedIndex.value == 0
                        ? ImageUtils.homeOutline
                        : ImageUtils.homeOutline,
                    color: controller.selectedIndex.value == 0
                        ? AppColors.colorWhite
                        : AppColors.colordeepgrey,
                  ),
                ],
              ),
            ),
            BottomNavigationBarItem(
              label: 'Activity',
              icon: Column(
                children: [
                  controller.selectedIndex.value == 1
                      ? Container(
                          width: 57.ss,
                          height: 3.ss,
                          color: Colors.white,
                        )
                      : const Offstage(),
                  Container(
                    height: 10.ss,
                  ),
                  SvgPicture.asset(
                      controller.selectedIndex.value == 1
                          ? ImageUtils.activityFilled
                          : ImageUtils.activityOutline,
                      color: controller.selectedIndex.value == 1
                          ? AppColors.colorWhite
                          : AppColors.colordeepgrey),
                ],
              ),
            ),
            BottomNavigationBarItem(
              label: 'Wallet',
              icon: Column(
                children: [
                  controller.selectedIndex.value == 2
                      ? Container(
                          width: 57.ss,
                          height: 3.ss,
                          color: Colors.white,
                        )
                      : const Offstage(),
                  Container(
                    height: 10.ss,
                  ),
                  SvgPicture.asset(
                      controller.selectedIndex.value == 2
                          ? ImageUtils.walletFilled
                          : ImageUtils.walletOutline,
                      color: controller.selectedIndex.value == 2
                          ? AppColors.colorWhite
                          : AppColors.colordeepgrey),
                ],
              ),
            ),
            BottomNavigationBarItem(
              label: 'Inbox',
              icon: Column(
                children: [
                  controller.selectedIndex.value == 3
                      ? Container(
                          width: 57.ss,
                          height: 3.ss,
                          color: Colors.white,
                        )
                      : const Offstage(),
                  Container(
                    height: 10.ss,
                  ),
                  SvgPicture.asset(
                      controller.selectedIndex.value == 3
                          ? ImageUtils.inboxFilled
                          : ImageUtils.inboxOutline,
                      color: controller.selectedIndex.value == 3
                          ? AppColors.colorWhite
                          : AppColors.colordeepgrey),
                ],
              ),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Column(
                children: [
                  controller.selectedIndex.value == 4
                      ? Container(
                          width: 57.ss,
                          height: 3.ss,
                          color: Colors.white,
                        )
                      : const Offstage(),
                  Container(
                    height: 10.ss,
                  ),
                  SvgPicture.asset(
                      controller.selectedIndex.value == 4
                          ? ImageUtils.profileFilled
                          : ImageUtils.profileOutline,
                      color: controller.selectedIndex.value == 4
                          ? AppColors.colorWhite
                          : AppColors.colordeepgrey),
                ],
              ),
            ),
          ],
        )));
  }
}

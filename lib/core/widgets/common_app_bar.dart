import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizing/sizing.dart';
import '../utils/app_colors.dart';
import '../utils/fonts.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  String? title;
  Function? onPressed;
  bool isIconShow;
  bool centerTitle;
  double? topPading;
  Icon? icon;
  Color? backgroundColor;
  List<Widget>? action;

  CommonAppbar({
    this.title,
    this.onPressed,
    this.isIconShow = false,
    this.centerTitle = false,
    this.icon,
    this.topPading,
    this.action,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: action,
      backgroundColor: backgroundColor != null ? backgroundColor :  Theme.of(context).brightness != Brightness.dark
          ? AppColors.colorOffWhite
          : AppColors.titleColor,
      iconTheme: IconThemeData(
        color: Theme.of(context).brightness != Brightness.dark
            ? AppColors.colorWhite
            : AppColors.titleColor, // Set the color of icons
        size: 20.ss, // Set the size of icons
        // You can set more properties like opacity, etc. if needed
      ),
      centerTitle: centerTitle,
      title: Text(
        title ?? "",
        style: CustomTextStyle(
            color: Theme.of(context).brightness != Brightness.dark
                ? AppColors.titleColor
                : AppColors.colorWhite,
            fontSize: 16.fss,
            fontWeight: FontWeight.w700),
      ),
      elevation: 0,
      titleSpacing: 0,
      leading: isIconShow == true
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: icon ??
                      Icon(Icons.arrow_back_ios_new_outlined,
                          color: Theme.of(context).brightness != Brightness.dark
                              ? AppColors.titleColor
                              : AppColors.colorWhite,
                          size: 16.ss),
                  onTap: () {
                    if (onPressed != null) {
                      onPressed!();
                    } else {
                      Get.back();
                    }
                  },
                ),
              ],
            )
          : Offstage(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

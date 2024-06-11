import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizing/sizing.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/fonts.dart';
import '../../core/widgets/gap.dart';

Widget RideTypeItem(int index,bool? isSelected,String? icon,String? rideTypeName) {
  return Container(
    height: 70.ss,
    width: 110.ss,
    margin: EdgeInsets.only(right: 5.ss),
    decoration: BoxDecoration(
      color: AppColors.rideTypeBackground,
      borderRadius: BorderRadius.all(Radius.circular(20.ss)),
      border: Border.all(
          color: isSelected == false
              ? AppColors.colorWhite
              : AppColors.buttonColor),
    ),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SvgPicture.asset(icon ?? "",
          color: isSelected == false
              ? AppColors.titleColor
              : AppColors.buttonColor),
      Gap(5.ss),
      Center(
        child: Text(
          rideTypeName ?? "",
          style: CustomTextStyle(
              fontSize: 12.fss,
              fontWeight: FontWeight.w700,
              color: isSelected == false
                  ? AppColors.titleColor
                  : AppColors.buttonColor),
        ),
      ),
    ]),
  );
}
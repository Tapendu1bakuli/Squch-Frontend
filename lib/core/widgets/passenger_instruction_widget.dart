import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';

import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import '../utils/fonts.dart';

class PassengerInstructionWidget extends StatelessWidget {
  Icon? leadingIcon;
  bool? isTrailingIconShown;
  String? title;
  Function()? onTap;


  PassengerInstructionWidget({super.key,this.leadingIcon,this.isTrailingIconShown,this.title,this.onTap });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.ss),
      decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(8.ss),
          color: AppColors.colorLoaderFill),
      child: ListTile(
        onTap: onTap??(){},
        title:  Text(
            textAlign: TextAlign.start,
            title??AppStrings.instructionForPassenger.tr,
            style: CustomTextStyle(
              color: AppColors.colorWhite,
              fontSize: 12.fss,
              fontWeight: FontWeight.w500,
            )
        ),
        horizontalTitleGap: 6.ss,
        dense: true,
        minLeadingWidth: 6.ss,
        trailing:isTrailingIconShown??false? Icon(Icons.arrow_forward_ios_rounded,color: AppColors.colorWhite,size: 18.ss):const Offstage(),
        leading: Icon(Icons.error, color: AppColors.colorWhite,size: 20.ss),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.ss),
      ),

    ) ;
  }
}
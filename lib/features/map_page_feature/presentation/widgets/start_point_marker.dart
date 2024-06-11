import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';
import 'package:squch/core/utils/fonts.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/image_utils.dart';

class StartPointMarker extends StatelessWidget {
  String? description;
  String? driverDuration;
  Image? pin;
  StartPointMarker({super.key, this.description, this.driverDuration,this.pin});

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6.ss),
                bottomLeft: Radius.circular(6.ss)),
            child: Container(
             width: Get.width/2,
              padding: EdgeInsets.symmetric(horizontal: 8.ss,vertical: 8.ss),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 10.ss,
                  ),
                  Flexible(child: Text(description??"",style: CustomTextStyle(fontSize: 10.fss, fontWeight: FontWeight.w700),)),
                  Container(
                    width: 9.ss,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.colorBlack,
                    size: 14.ss,
                  ),
                  Container(
                    width: 3.ss,
                  ),
                ],
              ),
            ),
          ),
          pin?? Image.asset(ImageUtils.pin,height: 25.ss,)
          // Add any other widgets you want below the ClipRRect
        ],
      ),
    );
  }
}

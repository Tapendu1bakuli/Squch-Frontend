import 'dart:core';

import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/fonts.dart';
import '../../../../core/utils/image_utils.dart';

class EndPointMarker extends StatelessWidget {
  String? description;
  String? driverDuration;
  Image? pin;
  EndPointMarker({super.key, this.description, this.driverDuration,this.pin});

  @override
  Widget build(BuildContext context) {
    return Container(

      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6.ss),
                bottomLeft: Radius.circular(6.ss)),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.ss,vertical: 8.ss),
                    decoration: BoxDecoration(
                      color: AppColors.colorBlack,
                    ),
                    child: Center(
                      child: Text(
                        driverDuration??"",
                        textAlign: TextAlign.center,
                        style: CustomTextStyle(
                            color: AppColors.colorWhite,
                            fontSize: 10.fss,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: 10.ss,
                  ),
                  Text(description??"",style: CustomTextStyle(fontSize: 10.fss, fontWeight: FontWeight.w500),),
                  Container(
                    width: 2.ss,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.colorBlack,
                    size: 14.ss,
                  ),
                  Container(
                    width: 5.ss,
                  ),
                ],
              ),
            ),
          ),
          pin??Image.asset(ImageUtils.pin,height: 25.ss,),
          // Add any other widgets you want below the ClipRRect
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizing/sizing.dart';
import 'package:squch/features/map_page_feature/data/models/address_model.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/fonts.dart';
import '../../../../core/utils/image_utils.dart';
import '../../../../core/widgets/horizontal_gap.dart';


class RideRouteWidget extends StatelessWidget {
  final Address? sourceAddress;
  final Address? destinationAddress;
  final String? sourceDistence;
  final String? destinationDistecnce;
  RideRouteWidget({super.key, this.sourceAddress, this.destinationAddress, this.sourceDistence, this.destinationDistecnce});

  @override
  Widget build(BuildContext context) {
    print("Source==>  ${sourceAddress?.toJson()}");
    print("Destination==>  ${destinationAddress?.toJson()}");
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.ss),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(ImageUtils.sourceLocationIcon),
              HorizontalGap(10.ss),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      sourceAddress?.getAddress??"",
                      style: CustomTextStyle(
                          color: AppColors.titleColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.fss),
                    ),
                    Text(
                      sourceAddress?.getDescription??"",
                      style: CustomTextStyle(
                          color: AppColors.textSubBlack,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.fss),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.0.ss),
            child: SvgPicture.asset(ImageUtils.line),
          ),
          Row(
            children: [
              SvgPicture.asset(
                  ImageUtils.destinationLocation),
              HorizontalGap(10.ss),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      destinationAddress?.getAddress??"",
                      style: CustomTextStyle(
                          color: AppColors.titleColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.fss),
                    ),
                    Text(
                      destinationAddress?.getDescription??"",
                      style: CustomTextStyle(
                          color: AppColors.textSubBlack,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.fss),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

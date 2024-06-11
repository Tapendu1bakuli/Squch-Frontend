import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';
import 'package:squch/core/utils/app_colors.dart';
import 'package:squch/core/utils/image_utils.dart';

import '../utils/fonts.dart';

class RatingWithCarWidget extends StatelessWidget {
  final String? carImage;
  final String? driverImage;
  final String? rating;

  RatingWithCarWidget(
      {super.key, this.carImage, this.driverImage, this.rating});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 42,
          width: 82,
        ),
        carImage != null
            ? Positioned(
                top: 8.ss,
                bottom: 8.ss,
                right: 8.ss,
                left: 8.ss,
                child: Image.asset(
                  ImageUtils.carImage4xAtBiddingCard,
                  width: 100.ss,
                  height: 40.ss,
                  fit: BoxFit.fill,
                ))
            : const Offstage(),
        driverImage != null
            ? Positioned(
                right: 0,
                child: CircleAvatar(
                    backgroundColor: AppColors.colorWhite,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ClipRRect(
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.ss)),
                          child: Image.network(
                            driverImage ?? "",
                            width: 38.ss,
                            height: 38.ss,
                            fit: BoxFit.fill,
                          )),
                    )))
            : const Offstage(),
        Positioned(
          bottom: 0,
          right: 5.ss,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0.ss),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.5),
                    color: Colors.white),
                child: Text(rating ?? "",
                    style: CustomTextStyle(
                      fontSize: 12.fss,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sizing/sizing.dart';
import 'package:squch/core/widgets/gap.dart';

import '../../features/map_page_feature/data/models/ride_booking_bid_response.dart';
import '../common/common_button.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import '../utils/fonts.dart';
import 'rating_with_car_widget.dart';
import 'horizontal_gap.dart';
import 'linear_percent_indicator_widget.dart';

class DriverArrivedCard extends StatelessWidget {
  Bids tripBid;
  Trip trip;
  Function()? onAccept;
  Function()? onAnimationEnd;
  Function()? onReject;
  String? tripDuration;
  DriverArrivedCard(
      {super.key,
      required this.tripBid,
      required this.trip,
      this.tripDuration,
      this.onAccept,
      this.onAnimationEnd,
      this.onReject});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.ss,
      margin: EdgeInsets.only(top: 20.ss),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.ss)),
        child: Column(
          children: [
            LinearPercentIndicatorWidget(
              animationDuration: ((int.tryParse(tripDuration??"0")??0)*1000),
              createdAt: tripBid.createdAt,
              onAnimationEnd: onAnimationEnd,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.ss, vertical: 10.ss),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(16.ss),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tripBid.driver?.driverDocument?.vehicleDetails
                                    ?.vehicleRegNo ??
                                "",
                            style: CustomTextStyle(
                                color: AppColors.titleColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.fss),
                          ),
                          Gap(3.ss),
                          Text(
                            tripBid.driver?.driverDocument?.vehicleDetails
                                    ?.vehicleModel?.name ??
                                "",
                            style: CustomTextStyle(
                                color: AppColors.driverBidSubTitle,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.fss),
                          ),
                        ],
                      ),
                      Spacer(),
                      /*Container(
                          height: 47.ss,
                          width: 86.ss,
                          child: CircleAvatar(
                              backgroundColor: AppColors.colorWhite,
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.ss)),
                                  child: Image.network(
                                      tripBid.driver?.profileImage ?? "")))),*/
                      RatingWithCarWidget(carImage:tripBid.driver?.driverDocument?.vehicleDetails?.vehicleImage ,driverImage:tripBid.driver?.profileImage,rating: "4.5",)
                    ],
                  ),
                  Gap(16.ss),
                  Divider(
                    color: AppColors.dividerColor,
                  ),
                  Gap(16.ss),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            HorizontalGap(10.ss),
                            Text(
                              "${AppStrings.fare.tr} (${tripBid.driverDistance?.distance?.text ?? ""}) ",
                              style: CustomTextStyle(
                                  color: AppColors.titleColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.fss),
                              maxLines: 3,
                              overflow: TextOverflow.clip,
                            ),
                            HorizontalGap(6.ss),
                            Container(
                              width: 4.ss,
                              height: 4.ss,
                              decoration: ShapeDecoration(
                                color: AppColors.titleColor,
                                shape: OvalBorder(),
                              ),
                            ),
                            HorizontalGap(6.ss),
                            Flexible(
                              child: Text(
                                "${tripBid.driverDistance?.duration?.text} ${AppStrings.away.tr}",
                                style: CustomTextStyle(
                                    color: AppColors.titleColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13.fss),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0.ss, vertical: 10.ss),
                        child: Text(
                          "${trip.currencySymbol} ${tripBid.driverPrice}",
                          style: CustomTextStyle(
                              color: AppColors.titleColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.fss),
                        ),
                      ),
                    ],
                  ),
                  Gap(20.ss),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonButton(
                        buttonWidth: MediaQuery.sizeOf(context).width / 2 - 50,
                        buttonHeight: 40.ss,
                        solidColor: AppColors.colorgrey,
                        labelColor: AppColors.colorBlack,
                        fontSize: 12.fss,
                        onClicked: onReject ?? () {},
                        label: AppStrings.decline,
                      ),
                      CommonButton(
                        buttonWidth: MediaQuery.sizeOf(context).width / 2 - 50,
                        buttonHeight: 40.ss,
                        fontSize: 12.fss,
                        label: AppStrings.accept,
                        onClicked: onAccept ?? () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

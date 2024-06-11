import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sizing/sizing.dart';
import 'package:squch/features/map_page_feature/presentation/widgets/ride_route_widget.dart';
import 'package:squch/features/map_page_feature/presentation/widgets/share_ride_route_widget.dart';

import '../../../../common/widget/dynamicTextField.dart';
import '../../../../common/widget/rideTypeItem.dart';
import '../../../../core/common/common_button.dart';
import '../../../../core/common/common_text_form_field.dart';
import '../../../../core/service/page_route_service/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/fonts.dart';
import '../../../../core/utils/image_utils.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/driver_arrived_card.dart';
import '../../../../core/widgets/gap.dart';
import '../../../../core/widgets/horizontal_gap.dart';
import '../../../../core/widgets/loader_widget.dart';
import '../../../../core/widgets/passenger_instruction_widget.dart';
import '../../../../core/widgets/rating_with_car_widget.dart';
import '../../../../core/widgets/title_text.dart';
import '../../data/models/address_model.dart';
import '../controller/map_controller.dart';
import '../controller/ride_status.dart';
import 'package:badges/badges.dart' as badges;
class DragableScrollSheetWidget extends GetView<MapController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => getStateView(context));
  }

  Widget getStateView(BuildContext context) {
    switch (controller.rideStatus.value) {
      case RideStatus.INITIAL_MAP:
        return const Offstage();

      case RideStatus.RIDE_TYPE_BOTTOM_SHEET_SHOWING:
        return Obx(
          () => DraggableScrollableSheet(
              initialChildSize: controller.bottomSheetIntSize.value,
              minChildSize: controller.bottomSheetMinSize.value,
              maxChildSize: controller.bottomSheetMaxSize.value,
              controller: DraggableScrollableController(),
              expand: true,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Column(
                  children: [
                    PassengerInstructionWidget(
                      isTrailingIconShown: true,
                      onTap: () {
                        controller.showPassengerInstruction();
                      },
                    ),
                    Gap(20.ss),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.ss, vertical: 20.ss),
                      decoration: BoxDecoration(
                          color: AppColors.colorWhite,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15.ss),
                            topLeft: Radius.circular(15.ss),
                          )),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                                child: Container(
                              height: 5.ss,
                              width: 80.ss,
                              color: AppColors.colorgrey,
                              padding: EdgeInsets.symmetric(vertical: 10.ss),
                            )),
                            Gap(10.ss),
                            Text(
                              AppStrings.PlanYourRide.tr,
                              style: CustomTextStyle(
                                  fontSize: 16.fss,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.titleColor),
                            ),
                            Gap(
                              20.ss,
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              height: 70.ss,
                              child: Obx(
                                () => ListView.builder(
                                    itemCount: controller.rideTypes.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                          onTap: () {
                                            controller.changeRideType(index);
                                          },
                                          child: RideTypeItem(
                                              index,
                                              controller
                                                  .rideTypes[index].isSelected,
                                              controller.rideTypes[index].icon,
                                              controller.rideTypes[index]
                                                  .rideTypeName));
                                    }),
                              ),
                            ),
                            Gap(10.ss),
                            Obx(() =>
                                DynamicTextField(
                                numberOfTextFields:
                                    controller.numberOfTextFields.value,
                                isNegetiveActive: controller.isNegetiveActive.value,
                                context: context,
                                onTapForSource: () {
                                  controller.desableInsertStopage();
                                  controller.enableInsertSource();
                                },
                                onTapForDest: () {
                                  controller.desableInsertSource();
                                  controller.desableInsertStopage();
                                },
                                onEditingComplete: () {
                                  controller.manageMapState(RideStatus
                                      .RIDE_TYPE_BOTTOM_SHEET_SHOWING);
                                  Get.toNamed(Routes.MAP_PAGE);
                                  controller.createMarker();
                                },
                                onStoppageEditingComplete: () {},
                                onAddNewTextField: () {
                                  Get.back();
                                },
                                onRemoveTextField: (){
                                  Get.back();
                                },
                                controllerForSource:
                                    controller.searchPickUpController.value,
                                controllerForDest:
                                    controller.searchDestController.value,
                                maxTextFields: 5,
                                textEditingControllers:
                                    controller.textEditingControllers,
                                onTapForStoppage: (int) {})),
                            SizedBox(
                              height: 20.ss,
                            ),
                          ],
                        ),
                      ),
                    ))
                  ],
                );
              }),
        );

      case RideStatus.VEHICLE_TYPE_BOTTOM_SHEET_SHOWING:
        return Obx(
          () => DraggableScrollableSheet(
              initialChildSize: controller.bottomSheetIntSize.value,
              minChildSize: controller.bottomSheetMinSize.value,
              maxChildSize: controller.bottomSheetMaxSize.value,
              controller: DraggableScrollableController(),
              expand: true,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Column(
                  children: [
                    Gap(20.ss),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.ss, vertical: 20.ss),
                      decoration: BoxDecoration(
                          color: AppColors.colorWhite,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15.ss),
                            topLeft: Radius.circular(15.ss),
                          )),
                      child: Visibility(
                        visible: controller.rideStatus.value ==
                            RideStatus.VEHICLE_TYPE_BOTTOM_SHEET_SHOWING,
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                  child: Container(
                                height: 5.ss,
                                width: 80.ss,
                                color: AppColors.colorgrey,
                                padding: EdgeInsets.symmetric(vertical: 10.ss),
                              )),
                              Gap(10.ss),
                              Text(
                                AppStrings.ChooseARide.tr,
                                style: CustomTextStyle(
                                    fontSize: 16.fss,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.titleColor),
                              ),
                              Gap(20.ss),
                              Obx(() => ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: controller.charges.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        controller.selectedCarTypeChargeIndex
                                            .value = index;
                                        controller.originalPrice.value =
                                            controller.charges[index].price
                                                    ?.toDouble() ??
                                                0.0;
                                        controller.minimumPrice.value =
                                            controller.charges[index]
                                                    .minAskingPrice
                                                    ?.toDouble() ??
                                                0.0;
                                        controller.maximumPrice.value =
                                            controller.charges[index]
                                                    .maxAskingPrice
                                                    ?.toDouble() ??
                                                0.0;
                                        controller.update();
                                        controller.charges.refresh();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.ss, vertical: 5.ss),
                                        height: 60.ss,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.ss)),
                                            border: Border.all(
                                                color: index ==
                                                        controller
                                                            .selectedCarTypeChargeIndex
                                                            .value
                                                    ? AppColors.buttonColor
                                                    : AppColors.colorWhite)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            70.0.ss),
                                                    child: Image.network(
                                                        controller
                                                                .charges[index]
                                                                .vehicleType
                                                                ?.image ??
                                                            ""
                                                        // "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8YXZhdGFyfGVufDB8fDB8fHww"
                                                        ,
                                                        height: 70.ss,
                                                        width: 70.ss,
                                                        fit: BoxFit.cover),
                                                  ),
                                                  backgroundColor:
                                                      AppColors.colorlightgrey,
                                                ),
                                                HorizontalGap(20.ss),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          controller
                                                                  .charges[
                                                                      index]
                                                                  .vehicleType
                                                                  ?.name ??
                                                              "",
                                                          style: CustomTextStyle(
                                                              fontSize: 16.fss,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                        HorizontalGap(5.ss),
                                                        SvgPicture.asset(
                                                            ImageUtils
                                                                .seatCapacity),
                                                        HorizontalGap(2.ss),
                                                        Text(
                                                          (controller
                                                                  .initRideData
                                                                  .value
                                                                  ?.charges?[
                                                                      index]
                                                                  .vehicleType
                                                                  ?.seatCapacity)
                                                              .toString(),
                                                          style: CustomTextStyle(
                                                              fontSize: 12.fss,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                      ],
                                                    ),
                                                    Gap(5.ss),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "1:46 pm",
                                                          style: CustomTextStyle(
                                                              fontSize: 12.fss,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: AppColors
                                                                  .titleColor
                                                                  .withOpacity(
                                                                      0.6)),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      5.ss),
                                                          child: CircleAvatar(
                                                            radius: 3,
                                                            backgroundColor:
                                                                AppColors
                                                                    .titleColor
                                                                    .withOpacity(
                                                                        0.6),
                                                          ),
                                                        ),
                                                        Text(
                                                            "${controller.initRideData.value!.distanceMatrix?.param?.duration?.text} ${AppStrings.away.tr}",
                                                            style: CustomTextStyle(
                                                                fontSize:
                                                                    12.fss,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: AppColors
                                                                    .titleColor
                                                                    .withOpacity(
                                                                        0.6))),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${controller.countryModel.value.currencySymbol} ${controller.charges[index].price?.round()}",
                                                  style: CustomTextStyle(
                                                      fontSize: 16.fss,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                                Gap(5.ss),
                                                Text(
                                                  "${controller.countryModel.value.currencySymbol} ${controller.charges[index].price?.round()}",
                                                  style: CustomTextStyle(
                                                      fontSize: 12.fss,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .titleColor
                                                          .withOpacity(0.6)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })),
                            ],
                          ),
                        ),
                      ),
                    ))
                  ],
                );
              }),
        );

      case RideStatus.RIDE_DETAILS_BOTTOM_SHEET_SHOWING:
        return Obx(
          () => Stack(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                decoration:
                    BoxDecoration(color: AppColors.colorBlack.withOpacity(0.3)),
              ),
              DraggableScrollableSheet(
                  initialChildSize: controller.bottomSheetIntSize.value,
                  minChildSize: controller.bottomSheetMinSize.value,
                  maxChildSize: controller.bottomSheetMaxSize.value,
                  controller: DraggableScrollableController(),
                  expand: true,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Column(
                      children: [
                        PassengerInstructionWidget(
                          isTrailingIconShown: true,
                          onTap: () {
                            controller.showPassengerInstruction();
                          },
                        ),
                        Gap(20.ss),
                        Expanded(
                            child: Container(
                          // height: size.height*3/4,
                          decoration: BoxDecoration(
                              color: AppColors.colorWhite,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15.ss),
                                topLeft: Radius.circular(15.ss),
                              )),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.ss),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Gap(10.ss),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 5.ss,
                                            width: 80.ss,
                                            color: AppColors.colorgrey,
                                          ),
                                        ],
                                      ),
                                      Gap(10.ss),
                                      Text(
                                        AppStrings.ChooseARide.tr,
                                        style: CustomTextStyle(
                                            fontSize: 16.fss,
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.titleColor),
                                      ),
                                      Gap(20.ss),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.ss, vertical: 5.ss),
                                        height: 60.ss,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.ss)),
                                            border: Border.all(
                                                color: AppColors.buttonColor)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor:
                                                      AppColors.colorlightgrey,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            70.0.ss),
                                                    child: Image.network(
                                                        controller
                                                                .selectedCharge
                                                                .value
                                                                .vehicleType!
                                                                .image ??
                                                            "",
                                                        height: 70.ss,
                                                        width: 70.ss,
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                HorizontalGap(20.ss),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          controller
                                                                  .selectedCharge
                                                                  .value
                                                                  .vehicleType!
                                                                  .name ??
                                                              "",
                                                          style: CustomTextStyle(
                                                              fontSize: 16.fss,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                        HorizontalGap(5.ss),
                                                        SvgPicture.asset(
                                                            ImageUtils
                                                                .seatCapacity),
                                                        HorizontalGap(2.ss),
                                                        Text(
                                                          (controller
                                                                  .selectedCharge
                                                                  .value
                                                                  .vehicleType
                                                                  ?.seatCapacity)
                                                              .toString(),
                                                          style: CustomTextStyle(
                                                              fontSize: 12.fss,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                      ],
                                                    ),
                                                    Gap(5.ss),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "1:46 pm",
                                                          style: CustomTextStyle(
                                                              fontSize: 12.fss,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: AppColors
                                                                  .titleColor
                                                                  .withOpacity(
                                                                      0.6)),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      5.ss),
                                                          child: CircleAvatar(
                                                            radius: 3,
                                                            backgroundColor:
                                                                AppColors
                                                                    .titleColor
                                                                    .withOpacity(
                                                                        0.6),
                                                          ),
                                                        ),
                                                        //Text("9 min away",style: CustomTextStyle(fontSize: 12.fss,fontWeight: FontWeight.w400,color: AppColors.colorAppBlack.withOpacity(0.6))),
                                                        Text(
                                                            "${controller.initRideData.value?.distanceMatrix?.param?.duration?.text} ${AppStrings.away.tr}",
                                                            style: CustomTextStyle(
                                                                fontSize:
                                                                    12.fss,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: AppColors
                                                                    .titleColor
                                                                    .withOpacity(
                                                                        0.6))),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${controller.countryModel.value.currencySymbol} ${controller.selectedCharge.value?.price?.round()}",
                                                  /* controller.userData!.value!.id!=null?
                                                                    "${controller.userData!.value!.currency!.symbol} ${controller.selectedCharge.value!.price!.round()}"
                                                                    :
                                                              "₹ ${controller.selectedCharge.value!.price!.round()}",*/
                                                  overflow: TextOverflow.clip,
                                                  style: CustomTextStyle(
                                                      fontSize: 16.fss,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                                Gap(5.ss),
                                                Text(
                                                  "${controller.countryModel.value.currencySymbol} ${controller.selectedCharge.value?.price?.round()}",
                                                  /* controller.userData!.value!.id!=null?
                                                                    "${controller.userData!.value!.currency!.symbol} ${controller.selectedCharge.value!.price!.round()}"
                                                                   : "₹ ${controller.selectedCharge.value!.price!.round()}",*/
                                                  overflow: TextOverflow.clip,
                                                  style: CustomTextStyle(
                                                      fontSize: 12.fss,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .titleColor
                                                          .withOpacity(0.6)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(20.ss),
                                Container(
                                  decoration:
                                      BoxDecoration(color: Color(0xFFFBF8FF)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.ss, horizontal: 20.ss),
                                  child: Text(
                                      "${AppStrings.recommendedPriceMessage.tr} ${controller.initRideData.value?.distanceMatrix?.param!.duration?.text.toString()}."),
                                ),
                                Gap(20.ss),
                                /* Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.ss),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(ImageUtils.source),
                                      HorizontalGap(10.ss),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TitleText(
                                                context,
                                                controller.initRideData?.value
                                                        ?.origin!.getAddress ??
                                                    ""),
                                            Text(
                                              controller.initRideData?.value
                                                      ?.origin!.description ??
                                                  "",
                                              style: CustomTextStyle(
                                                  fontSize: 12.ss,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0.ss),
                                  child: Image.asset(ImageUtils.verticalLine),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.ss),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(ImageUtils.destination),
                                      HorizontalGap(10.ss),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TitleText(
                                                context,
                                                controller
                                                        .initRideData
                                                        ?.value
                                                        ?.destination!
                                                        .address ??
                                                    ""),
                                            Text(
                                              controller
                                                      .initRideData
                                                      ?.value
                                                      ?.destination!
                                                      .description ??
                                                  "",
                                              style: CustomTextStyle(
                                                  fontSize: 12.ss,
                                                  fontWeight: FontWeight.w400),
                                              overflow: TextOverflow.clip,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),*/
                                (controller.stoppageList.isEmpty)
                                    ? RideRouteWidget(
                                        sourceAddress: controller
                                            .initRideData.value?.origin,
                                        destinationAddress: controller
                                            .initRideData.value?.destination,
                                        sourceDistence:
                                            "${controller.initRideData.value?.distanceMatrix?.param?.distance?.value ?? ""} away (Pickup)",
                                        destinationDistecnce:
                                            "${controller.initRideData.value?.distanceMatrix?.param?.distance?.value ?? ""} (Drop-off)",
                                      )
                                    : ShareRideRouteWidget(
                                  padding: EdgeInsets.symmetric(horizontal: 20.ss),
                                        source: Address(
                                            address: controller
                                                    .initRideData
                                                    .value
                                                    ?.origin!
                                                    .getAddress ??
                                                ""),
                                        destination: Address(
                                            address: controller
                                                    .initRideData
                                                    .value
                                                    ?.destination!
                                                    .description ??
                                                ""),
                                        multiStop: controller.stoppageList),
                                Gap(20.ss),
                                Divider(
                                    color:
                                        AppColors.titleColor.withOpacity(0.5),
                                    thickness: 0.5.ss),
                                Gap(10.ss),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0.ss),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(ImageUtils.dollar),
                                          HorizontalGap(10.ss),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TitleText(
                                                context,
                                                /*controller.userData!.value!.id!=null?
                                                                    "${controller.userData!.value!.currency!.symbol} ${controller.selectedCharge.value.price?.round() ?? ""}"
                                                                    :"₹ ${controller.selectedCharge.value.price?.round() ?? ""}"*/
                                                "${controller.countryModel.value.currencySymbol} ${controller.originalPrice.round()}",
                                              ),
                                              Text(
                                                AppStrings
                                                    .recommendedFareAdjustable
                                                    .tr,
                                                style: CustomTextStyle(),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                          onTap: () {
                                            // controller
                                            //     .showNegotiateBottomSheet(context);
                                            controller.manageMapState(RideStatus
                                                .RIDE_NEGOTIATION_BOTTOM_SHEET_SHOWING);
                                          },
                                          child: Text(
                                            AppStrings.negotiate.tr,
                                            style: CustomTextStyle(
                                                color: Theme.of(context)
                                                            .brightness !=
                                                        Brightness.dark
                                                    ? Color(0XFF11DCC9)
                                                    : Colors.white),
                                          ))
                                    ],
                                  ),
                                ),
                                Gap(20.ss),
                                CommonTextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor:
                                          AppColors.colorgrey.withOpacity(0.4),
                                      hintText: controller.reasonChangingPrice
                                              .text.isNotEmpty
                                          ? controller.reasonChangingPrice.text
                                          : AppStrings.anyCommentsForDriver.tr),
                                  onTap: () {
                                    controller
                                        .isCancelledTappedFromRideDetailsPage
                                        .value = true;
                                    controller.manageMapState(RideStatus
                                        .RIDE_NEGOTIATION_BOTTOM_SHEET_SHOWING_FOR_COMMENT);
                                  },
                                  readOnly: true,
                                ),
                              ],
                            ),
                          ),
                        ))
                      ],
                    );
                  }),
            ],
          ),
        );

      case RideStatus.RIDE_NEGOTIATION_BOTTOM_SHEET_SHOWING:
        return DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.48,
            maxChildSize: 0.6,
            expand: true,
            builder: (BuildContext context, ScrollController scrollController) {
              return ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 20.0.ss),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)),
                                child: Container(
                                  // height: size.height*3/4,
                                  decoration: BoxDecoration(
                                      color: AppColors.colorWhite,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30.ss),
                                        topLeft: Radius.circular(30.ss),
                                      )),
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Gap(10.ss),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 5.ss,
                                              width: 80.ss,
                                              color: AppColors.colorgrey,
                                            ),
                                          ],
                                        ),
                                        Gap(12.ss),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24.0.ss),
                                          child: Text(
                                            AppStrings.negotiate.tr,
                                            style: CustomTextStyle(
                                                fontSize: 16.fss,
                                                fontWeight: FontWeight.w900,
                                                color: AppColors.titleColor),
                                          ),
                                        ),
                                        Gap(16.ss),
                                        Divider(
                                            color: AppColors.titleColor
                                                .withOpacity(0.5),
                                            thickness: 0.3.ss),
                                        Gap(20.ss),
                                        (controller.stoppageList.isEmpty)
                                            ? RideRouteWidget(
                                                sourceAddress: controller
                                                    .initRideData.value?.origin,
                                                destinationAddress: controller
                                                    .initRideData
                                                    .value
                                                    ?.destination,
                                                sourceDistence:
                                                    "${controller.initRideData.value?.distanceMatrix?.param?.distance?.value ?? ""} away (Pickup)",
                                                destinationDistecnce:
                                                    "${controller.initRideData.value?.distanceMatrix?.param?.distance?.value ?? ""} (Drop-off)",
                                              )
                                            : ShareRideRouteWidget(
                                                source: Address(
                                                    address: controller
                                                            .initRideData
                                                            .value
                                                            ?.origin!
                                                            .getAddress ??
                                                        ""),
                                                destination: Address(
                                                    address: controller
                                                            .initRideData
                                                            .value
                                                            ?.destination!
                                                            .description ??
                                                        ""),
                                                multiStop:
                                                    controller.stoppageList),
                                        Gap(10.ss),
                                        Divider(
                                            color: AppColors.titleColor
                                                .withOpacity(0.5),
                                            thickness: 0.3.ss),
                                        Gap(10.ss),
                                        Obx(
                                          () => Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0.ss),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CommonButton(
                                                  label: "-5",
                                                  buttonWidth: 55,
                                                  fontWeight: FontWeight.w500,
                                                  onClicked: () {
                                                    controller
                                                        .negotiationPriceSetting(
                                                            controller
                                                                .minimumPrice
                                                                .value,
                                                            controller
                                                                .originalPrice
                                                                .value,
                                                            controller
                                                                .maximumPrice
                                                                .value,
                                                            false);
                                                  },
                                                ),
                                                Text(
                                                  "${controller.initRideData.value?.countryModel?.currencySymbol} ${controller.originalPrice}",
                                                  style: CustomTextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16.fss),
                                                ),
                                                CommonButton(
                                                  label: "+5",
                                                  labelColor:
                                                      AppColors.colorBlack,
                                                  fontWeight: FontWeight.w500,
                                                  borderColor:
                                                      AppColors.buttonColor,
                                                  solidColor:
                                                      AppColors.colorWhite,
                                                  onClicked: () {
                                                    controller
                                                        .negotiationPriceSetting(
                                                            controller
                                                                .minimumPrice
                                                                .value,
                                                            controller
                                                                .originalPrice
                                                                .value,
                                                            controller
                                                                .maximumPrice
                                                                .value,
                                                            true);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Gap(20.ss),
                                        Obx(() => controller
                                                .isLimitReachedMaximum.value
                                            ? Center(
                                                child: Text(
                                                "${AppStrings.maximumFare} ${controller.initRideData.value?.countryModel?.currencySymbol} ${controller.maximumPrice}",
                                                style: CustomTextStyle(
                                                    color: AppColors.textRed,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.fss),
                                              ))
                                            : const Offstage()),
                                        Obx(() => controller
                                                .isLimitReachedMinimum.value
                                            ? Center(
                                                child: Text(
                                                "${AppStrings.minimumFare} ${controller.initRideData.value?.countryModel?.currencySymbol} ${controller.minimumPrice}",
                                                style: CustomTextStyle(
                                                    color: AppColors.textRed,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.fss),
                                              ))
                                            : const Offstage()),
                                        Gap(20.ss),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });

      case RideStatus.RIDE_NEGOTIATION_BOTTOM_SHEET_SHOWING_FOR_COMMENT:
        return DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.28,
            maxChildSize: 0.4,
            expand: true,
            builder: (BuildContext context, ScrollController scrollController) {
              return ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 20.0.ss),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)),
                                child: Container(
                                  // height: size.height*3/4,
                                  decoration: BoxDecoration(
                                      color: AppColors.colorWhite,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30.ss),
                                        topLeft: Radius.circular(30.ss),
                                      )),
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Gap(10.ss),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 5.ss,
                                              width: 80.ss,
                                              color: AppColors.colorgrey,
                                            ),
                                          ],
                                        ),
                                        Gap(12.ss),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24.0.ss),
                                          child: Text(
                                            AppStrings.comments.tr,
                                            style: CustomTextStyle(
                                                fontSize: 16.fss,
                                                fontWeight: FontWeight.w900,
                                                color: AppColors.titleColor),
                                          ),
                                        ),
                                        Gap(20.ss),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24.0.ss),
                                          child: CommonTextFormField(
                                            controller:
                                                controller.reasonChangingPrice,
                                            margin: 0.0,
                                            padding: 0.0,
                                            decoration: InputDecoration(
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors
                                                        .buttonSolidColor),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors
                                                          .buttonSolidColor),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              hintText: 'Write a message',
                                              filled: true,
                                            ),
                                            textInputAction:
                                                TextInputAction.newline,
                                            textInputType:
                                                TextInputType.multiline,
                                            maxLine: 4,
                                          ),
                                        ),
                                        Gap(10.ss),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });

      case RideStatus.DRIVER_SEARCHING:
        return Obx(
          () => Stack(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                decoration:
                    BoxDecoration(color: AppColors.colorBlack.withOpacity(0.3)),
              ),
              DraggableScrollableSheet(
                  initialChildSize: controller.bottomSheetIntSize.value,
                  minChildSize: controller.bottomSheetMinSize.value,
                  maxChildSize: controller.bottomSheetMaxSize.value,
                  controller: DraggableScrollableController(),
                  expand: true,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Column(
                      children: [
                        Gap(20.ss),
                        Expanded(
                            child: LoaderWidget(
                          title: AppStrings.connectingYouToADriver.tr,
                          subTitle: controller.initRideData.value != null &&
                                  controller
                                          .initRideData.value!.distanceMatrix !=
                                      null
                              ? AppStrings.dropoffBy.tr +
                                  controller.initRideData.value!.distanceMatrix!
                                      .param!.duration!.text!
                              : "",
                          buttonText: AppStrings.cancelRide.tr,
                          onButtonClick: () {
                            controller.rideStatus.value =
                                RideStatus.WANT_TO_CANCEL_RIDE;
                            // controller.rideStatus.value =
                            //     RideStatus.DRIVER_BID_ARRIVED;
                          },
                        ))
                      ],
                    );
                  }),
            ],
          ),
        );

      case RideStatus.DRIVER_BID_ARRIVED:
        return Obx(
          () => DraggableScrollableSheet(
              initialChildSize: controller.bottomSheetIntSize.value,
              minChildSize: controller.bottomSheetMinSize.value,
              maxChildSize: controller.bottomSheetMaxSize.value,
              controller: DraggableScrollableController(),
              expand: true,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Column(
                  children: [
                    Expanded(
                        child: Container(
                      height: MediaQuery.sizeOf(context).height,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                          color: AppColors.colorBlack.withOpacity(0.3)),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.ss, vertical: 0.ss),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => controller.trip.value.bids != null &&
                                      controller.trip.value.bids!.isNotEmpty
                                  ? ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount:
                                          controller.trip.value.bids!.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                            onTap: () {},
                                            child: DriverArrivedCard(
                                              tripDuration: controller
                                                  .trip
                                                  .value
                                                  .settings
                                                  ?.bidAutoCancelTime,
                                              tripBid: controller
                                                  .trip.value.bids![index],
                                              trip: controller.trip.value.trip!,
                                              onAccept: () {
                                                controller.acceptDriver(
                                                    index: index,
                                                    tripId: controller
                                                        .trip.value.trip!.id
                                                        .toString(),
                                                    bidId: controller.trip.value
                                                        .bids![index].id
                                                        .toString());
                                              },
                                              onReject: () {
                                                controller.declineDriverRequest(
                                                    tripId: controller
                                                        .trip.value.trip!.id
                                                        .toString(),
                                                    bidId: controller.trip.value
                                                        .bids![index].id
                                                        .toString());
                                              },
                                              onAnimationEnd: () {
                                                controller.onAnimationEnd(
                                                    bids: controller.trip.value
                                                        .bids![index]);
                                              },
                                            )
                                            //  BookingRequestCard(index: index, context: context),
                                            );
                                      })
                                  : Offstage(),
                            ),
                            Gap(20.ss)
                          ],
                        ),
                      ),
                    ))
                  ],
                );
              }),
        );

      case RideStatus.RIDE_CONFIRMATION_PIN_BOTTOM_SHEET_SHOWING:
        debugPrint(
            "TripData=> ${controller.trip.value.trip?.toJson().toString()}",
            wrapWidth: 2048);
        return Obx(
          () => Stack(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                decoration:
                    BoxDecoration(color: AppColors.colorBlack.withOpacity(0.3)),
              ),
              DraggableScrollableSheet(
                  initialChildSize: controller.bottomSheetIntSize.value,
                  minChildSize: controller.bottomSheetMinSize.value,
                  maxChildSize: controller.bottomSheetMaxSize.value,
                  controller: DraggableScrollableController(),
                  expand: true,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Container(
                      //height: size.height*1/2,
                      decoration: BoxDecoration(
                          color: AppColors.colorWhite,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15.ss),
                            topLeft: Radius.circular(15.ss),
                          )),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(10.ss),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 5.ss,
                                  width: 80.ss,
                                  color: AppColors.colorgrey,
                                ),
                              ],
                            ),
                            Gap(10.ss),
                            Obx(
                              () => controller.driverStatus == "driverarrived"
                                  ? Center(
                                      child: Text(
                                        AppStrings.driverArrived.tr,
                                        style: CustomTextStyle(
                                            fontSize: 16.fss,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.titleColor),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            ImageUtils.confirmRide),
                                        HorizontalGap(10.ss),
                                        Text(
                                          AppStrings.ConfirmRide.tr,
                                          style: CustomTextStyle(
                                              fontSize: 16.fss,
                                              fontWeight: FontWeight.w900,
                                              color: AppColors.titleColor),
                                        ),
                                      ],
                                    ),
                            ),
                            Gap(10.ss),
                            Divider(
                                color: AppColors.titleColor.withOpacity(0.5),
                                thickness: 0.3.ss),
                            Gap(10.ss),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.ss, vertical: 5.ss),
                              // height: 60.ss,

                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    AppStrings.PinForRide.tr,
                                    style: CustomTextStyle(
                                        fontSize: 16.fss,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Pinput(
                                    androidSmsAutofillMethod:
                                        AndroidSmsAutofillMethod.none,
                                    controller: controller.pinController,
                                    length: 4,
                                    enabled: false,
                                    defaultPinTheme: controller.defaultPinTheme,
                                    focusedPinTheme: controller.focusedPinTheme,
                                    submittedPinTheme:
                                        controller.submittedPinTheme,
                                    validator: (s) {
                                      //  return s == '22222' ? null : 'Pin is incorrect';
                                    },
                                    pinputAutovalidateMode:
                                        PinputAutovalidateMode.onSubmit,
                                    showCursor: true,
                                    onCompleted: (pin) => print(pin),
                                  ),
                                ],
                              ),
                            ),
                            Gap(10.ss),
                            Divider(
                                color: AppColors.titleColor.withOpacity(0.5),
                                thickness: 0.3.ss),
                            Gap(10.ss),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 10.0.ss),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller
                                                .trip
                                                .value
                                                .bids?[controller
                                                    .acceptedBid.value]
                                                .driver
                                                ?.driverDocument
                                                ?.vehicleDetails
                                                ?.vehicleRegNo ??
                                            "",
                                        style: CustomTextStyle(
                                            fontSize: 18.fss,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Gap(5.ss),
                                      Text(
                                        controller
                                                .trip
                                                .value
                                                .bids?[controller
                                                    .acceptedBid.value]
                                                .driver
                                                ?.driverDocument
                                                ?.vehicleDetails
                                                ?.vehicleModel
                                                ?.name ??
                                            "",
                                        style: CustomTextStyle(
                                            fontSize: 12.fss,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.titleColor
                                                .withOpacity(0.4)),
                                      ),
                                    ],
                                  ),
                                  RatingWithCarWidget(
                                    carImage: controller
                                        .trip
                                        .value
                                        .bids?[controller.acceptedBid.value]
                                        .driver
                                        ?.driverDocument
                                        ?.vehicleDetails
                                        ?.vehicleImage,
                                    driverImage: controller
                                        .trip
                                        .value
                                        .bids?[controller.acceptedBid.value]
                                        .driver
                                        ?.profileImage,
                                    rating: "4.5",
                                  )
                                ],
                              ),
                            ),
                            Gap(10.ss),
                            Divider(
                                color: AppColors.titleColor.withOpacity(0.5),
                                thickness: 0.3.ss),
                            Gap(10.ss),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.ss),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      openDialPad(controller.startRideData.value
                                              ?.trip?.driver?.mobile ??
                                          "");
                                    },
                                    child: Container(
                                      height: 40.ss,
                                      width: 40.ss,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.ss)),
                                          color: AppColors.colorlightgrey2),
                                      child: Center(
                                          child: SvgPicture.asset(
                                              ImageUtils.phone)),
                                    ),
                                  ),
                                  HorizontalGap(10.ss),
                                  Obx(()=> Flexible(
                                      child: controller.isNewMessageArrived.value?badges.Badge(
                                          badgeStyle: badges.BadgeStyle(
                                            badgeColor: Colors.red,
                                          ),
                                          position:
                                          badges.BadgePosition.custom(bottom: 30.ss, end: 20.ss),
                                          badgeContent: Text("",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          child: CommonTextFormField(
                                            onTap: (){
                                              // controller.chatController.fetchMessages();
                                              Get.toNamed(Routes.CHAT_SCREEN);
                                              controller.isNewMessageArrived.value = false;
                                            },
                                            readOnly: true,
                                            width: controller.size.width - 90,
                                            fillColor:
                                            AppColors.colorgrey.withOpacity(0.5),
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                filled: true,
                                                fillColor: AppColors.colorlightgrey2,
                                                hintText: controller.isNewMessageArrived.value?
                                                controller.newMessage.value:AppStrings.anyPickupNotes.tr,
                                                hintStyle: CustomTextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.fss)),
                                          ),
                                        ):CommonTextFormField(
                                        onTap: (){
                                          // controller.chatController.fetchMessages();
                                          Get.toNamed(Routes.CHAT_SCREEN);
                                        },
                                        readOnly: true,
                                        width: controller.size.width - 90,
                                        fillColor:
                                        AppColors.colorgrey.withOpacity(0.5),
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            filled: true,
                                            fillColor: AppColors.colorlightgrey2,
                                            hintText:
                                            AppStrings.anyPickupNotes.tr,
                                            hintStyle: CustomTextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.fss)),
                                      )
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Gap(10.ss),
                            Divider(
                                color: AppColors.titleColor.withOpacity(0.5),
                                thickness: 0.3.ss),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0.ss),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(ImageUtils.shareIcon),
                                        HorizontalGap(5.ss),
                                        Text(
                                          AppStrings.shareTripStatus.tr,
                                          style: CustomTextStyle(
                                              fontSize: 12.fss,
                                              color: AppColors.titleColor,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 20.ss,
                                    width: 1.ss,
                                    decoration: BoxDecoration(
                                        color: AppColors.colordeepgrey),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(ImageUtils.shieldIcon),
                                        HorizontalGap(5.ss),
                                        Text(
                                          AppStrings.sosTools.tr,
                                          style: CustomTextStyle(
                                              fontSize: 12.fss,
                                              color: AppColors.textRed),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                                color: AppColors.titleColor.withOpacity(0.5),
                                thickness: 0.3.ss),
                            Padding(
                              padding: EdgeInsets.all(20.ss),
                              child: Text(
                                AppStrings.trip,
                                style: CustomTextStyle(
                                    fontSize: 16.ss,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            (controller.trip.value.trip?.isMultiStop ?? false)
                                ? ShareRideRouteWidget(
                              padding: EdgeInsets.symmetric(horizontal: 20.ss),
                                    source: Address(
                                      address: controller
                                          .trip.value.trip?.sceLocation,
                                      description: controller
                                          .trip.value.trip?.sceLocation,
                                      longitude: double.parse(
                                          controller.trip.value.trip?.sceLong ??
                                              0.0.toString()),
                                      latitude: double.parse(
                                          controller.trip.value.trip?.sceLat ??
                                              0.00.toString()),
                                      reachedAt: controller.trip.value.trip?.origin?.reachedAt??"",
                                      reachedAtHour: controller.trip.value.trip?.origin?.reachedAtHour??controller.trip.value.trip?.driverArrivedAtHour??controller.trip.value.trip?.rideStartedAtHour??"",
                                            expectedTime: controller.trip.value.trip?.origin?.expectedTime??"",
                                            expectedTimeHour: controller.trip.value.trip?.origin?.expectedTimeHour??""
                                    ),
                                    destination: Address(
                                        address: controller
                                            .trip.value.trip?.destLocation,
                                        description: controller
                                            .trip.value.trip?.destLocation,
                                        latitude: double.parse(controller
                                                .trip.value.trip?.destLat ??
                                            0.00.toString()),
                                        longitude: double.parse(controller
                                                .trip.value.trip?.destLong ??
                                            0.0.toString()),
                                        reachedAt: controller.trip.value.trip?.destination?.reachedAt??"",
                                        reachedAtHour: controller.trip.value.trip?.destination?.reachedAtHour??"",
                                        expectedTimeHour: controller.trip.value.trip?.destination?.expectedTimeHour??"",
                                        expectedTime: controller.trip.value.trip?.destination?.expectedTime??""
                                    ),
                                    multiStop:
                                        controller.trip.value.trip?.stoppages)
                                : RideRouteWidget(
                                    sourceAddress: Address(
                                        address: controller
                                                .trip.value.trip?.sceLocation ??
                                            "",
                                        description: controller
                                                .trip.value.trip?.sceLocation ??
                                            "",
                                        latitude: double.parse(controller
                                                .trip.value.trip?.sceLat ??
                                            0.00.toString()),
                                        longitude: double.parse(controller
                                                .trip.value.trip?.sceLong ??
                                            0.0.toString())),
                                    destinationAddress: Address(
                                        address: controller
                                            .trip.value.trip?.destLocation,
                                        description: controller
                                            .trip.value.trip?.destLocation,
                                        latitude: double.parse(controller
                                                .trip.value.trip?.destLat ??
                                            0.00.toString()),
                                        longitude: double.parse(controller
                                                .trip.value.trip?.destLong ??
                                            0.0.toString())),
                                  ),
                            Gap(20.ss),
                            Divider(
                                color: AppColors.titleColor.withOpacity(0.5),
                                thickness: 0.3.ss),
                            Gap(8.ss),
                            InkWell(
                                onTap: () {},
                                child: Center(
                                    child: Icon(
                                  Icons.add,
                                  size: 24.ss,
                                ))),
                            Gap(8.ss),
                            Center(
                              child: Text(
                                AppStrings.addOrUpdateStop.tr,
                                style: CustomTextStyle(
                                  fontSize: 12.fss,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Gap(8.ss),
                            Divider(
                                color: AppColors.titleColor.withOpacity(0.5),
                                thickness: 0.3.ss),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.ss, horizontal: 20.ss),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppColors.colorgrey,
                                          radius: 18.ss,
                                          child:
                                              SvgPicture.asset(ImageUtils.cash),
                                        ),
                                        HorizontalGap(10.ss),
                                        Text(
                                          AppStrings.cash.tr,
                                          style: CustomTextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 14.fss),
                                        )
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20.ss,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        );

      case RideStatus.RIDE_IN_PROGRESS:
        return Obx(
          () => Stack(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                decoration:
                    BoxDecoration(color: AppColors.colorBlack.withOpacity(0.3)),
              ),
              DraggableScrollableSheet(
                  initialChildSize: controller.bottomSheetIntSize.value,
                  minChildSize: controller.bottomSheetMinSize.value,
                  maxChildSize: controller.bottomSheetMaxSize.value,
                  expand: true,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      child: Container(
                        padding: EdgeInsets.only(top: 5.0.ss),
                        decoration: BoxDecoration(
                            color: AppColors.colorLoaderFill,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30.ss),
                              topLeft: Radius.circular(30.ss),
                            )),
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              child: Text(
                                "Drop off at ${controller.trip.value.trip?.destination?.reachedAtHour}",
                                style: CustomTextStyle(
                                    color: AppColors.colorWhite,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.fss),
                              ),
                            ),
                            Positioned(
                              top: 20.ss,
                              left: 0.ss,
                              right: 0.ss,
                              bottom: 0.ss,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.colorWhite,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30.ss),
                                      topLeft: Radius.circular(30.ss),
                                    )),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Gap(10.ss),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 5.ss,
                                            width: 80.ss,
                                            color: AppColors.colorgrey,
                                          ),
                                        ],
                                      ),
                                      Gap(10.ss),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0.ss),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  controller
                                                          .trip
                                                          .value
                                                          .bids?[controller
                                                              .acceptedBid
                                                              .value]
                                                          .driver
                                                          ?.driverDocument
                                                          ?.vehicleDetails
                                                          ?.vehicleRegNo ??
                                                      "",
                                                  style: CustomTextStyle(
                                                      fontSize: 18.fss,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                                Gap(5.ss),
                                                Text(
                                                  controller
                                                          .trip
                                                          .value
                                                          .bids?[controller
                                                              .acceptedBid
                                                              .value]
                                                          .driver
                                                          ?.driverDocument
                                                          ?.vehicleDetails
                                                          ?.vehicleModel
                                                          ?.name ??
                                                      "",
                                                  style: CustomTextStyle(
                                                      fontSize: 12.fss,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .titleColor
                                                          .withOpacity(0.4)),
                                                ),
                                              ],
                                            ),
                                            RatingWithCarWidget(
                                              carImage: controller
                                                  .trip
                                                  .value
                                                  .bids?[controller
                                                      .acceptedBid.value]
                                                  .driver
                                                  ?.driverDocument
                                                  ?.vehicleDetails
                                                  ?.vehicleImage,
                                              driverImage: controller
                                                  .trip
                                                  .value
                                                  .bids?[controller
                                                      .acceptedBid.value]
                                                  .driver
                                                  ?.profileImage,
                                              rating: "4.5",
                                            )
                                          ],
                                        ),
                                      ),
                                      Divider(
                                          color: AppColors.titleColor
                                              .withOpacity(0.5),
                                          thickness: 0.3.ss),
                                      Gap(10.ss),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0.ss),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                      ImageUtils.shareIcon),
                                                  HorizontalGap(5.ss),
                                                  Text(
                                                    AppStrings
                                                        .shareTripStatus.tr,
                                                    style: CustomTextStyle(
                                                        fontSize: 12.fss,
                                                        color: AppColors
                                                            .titleColor,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 20.ss,
                                              width: 1.ss,
                                              decoration: BoxDecoration(
                                                  color:
                                                      AppColors.colordeepgrey),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                      ImageUtils.shieldIcon),
                                                  HorizontalGap(5.ss),
                                                  Text(
                                                    AppStrings.sosTools.tr,
                                                    style: CustomTextStyle(
                                                        fontSize: 12.fss,
                                                        color:
                                                            AppColors.textRed),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: AppColors.colordivider,
                                      ),
                                      Gap(10.ss),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.ss, vertical: 10.ss),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppStrings.rideDetails.tr,
                                              style: CustomTextStyle(
                                                  color: AppColors.colorBlack,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.fss),
                                            ),
                                            Gap(20.ss),
                                            (controller.trip.value.trip?.isMultiStop ??
                                                    false)
                                                ? ShareRideRouteWidget(
                                                    source: Address(
                                                      address: controller
                                                          .trip
                                                          .value
                                                          .trip
                                                          ?.sceLocation,
                                                      description: controller
                                                          .trip
                                                          .value
                                                          .trip
                                                          ?.sceLocation,
                                                      latitude: double.parse(
                                                          controller
                                                                  .trip
                                                                  .value
                                                                  .trip
                                                                  ?.sceLat ??
                                                              0.00.toString()),
                                                      longitude: double.parse(
                                                          controller
                                                                  .trip
                                                                  .value
                                                                  .trip
                                                                  ?.sceLong ??
                                                              0.0.toString()),
                                                      progressStatus: TripTimelineStatus.done,
                                                      reachedAtHour: controller
                                                          .trip
                                                          .value
                                                          .trip
                                                          ?.origin?.reachedAtHour??"",
                                                        reachedAt: controller
                                                        .trip
                                                        .value
                                                        .trip
                                                        ?.origin?.reachedAt??"",
                                                      expectedTime: controller
                                                          .trip
                                                          .value
                                                          .trip
                                                          ?.origin?.expectedTime??controller
                                                          .trip
                                                          .value
                                                          .trip?.rideStartedAt??"",
                                                        expectedTimeHour: controller
                                                          .trip
                                                          .value
                                                          .trip
                                                          ?.origin?.expectedTimeHour??controller
                                                            .trip
                                                            .value
                                                            .trip?.rideStartedAtHour??""
                                                    ),
                                                    destination: Address(
                                                        address: controller
                                                            .trip
                                                            .value
                                                            .trip
                                                            ?.destLocation,
                                                        description: controller
                                                            .trip
                                                            .value
                                                            .trip
                                                            ?.destLocation,
                                                        latitude: double.parse(controller
                                                                .trip
                                                                .value
                                                                .trip
                                                                ?.destLat ??
                                                            0.00.toString()),
                                                        longitude: double.parse(
                                                            controller
                                                                    .trip
                                                                    .value
                                                                    .trip
                                                                    ?.destLong ??
                                                                0.0.toString())),
                                                    multiStop: controller.trip.value.trip?.stoppages)
                                                : RideRouteWidget(
                                                    sourceAddress: Address(
                                                        address: controller
                                                            .trip
                                                            .value
                                                            .trip
                                                            ?.sceLocation,
                                                        description: controller
                                                            .trip
                                                            .value
                                                            .trip
                                                            ?.sceLocation,
                                                        longitude: double.parse(
                                                            controller
                                                                    .trip
                                                                    .value
                                                                    .trip
                                                                    ?.sceLong ??
                                                                0.0.toString()),
                                                        latitude: double.parse(
                                                            controller
                                                                    .trip
                                                                    .value
                                                                    .trip
                                                                    ?.sceLat ??
                                                                0.00.toString())),
                                                    destinationAddress: Address(
                                                        address: controller
                                                            .trip
                                                            .value
                                                            .trip
                                                            ?.destLocation,
                                                        description: controller
                                                            .trip
                                                            .value
                                                            .trip
                                                            ?.destLocation,
                                                        latitude: double.parse(
                                                            controller
                                                                    .trip
                                                                    .value
                                                                    .trip
                                                                    ?.destLat ??
                                                                0.00
                                                                    .toString()),
                                                        longitude: double.parse(
                                                            controller
                                                                    .trip
                                                                    .value
                                                                    .trip
                                                                    ?.destLong ??
                                                                0.0.toString())),
                                                    sourceDistence: "",
                                                    destinationDistecnce: "",
                                                  ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: AppColors.colordivider,
                                      ),
                                      Gap(10.ss),
                                      Gap(10.ss),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        );

      case RideStatus.WANT_TO_CANCEL_RIDE:
        return Obx(
          () => Stack(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                decoration:
                    BoxDecoration(color: AppColors.colorBlack.withOpacity(0.3)),
              ),
              DraggableScrollableSheet(
                  initialChildSize: controller.bottomSheetIntSize.value,
                  minChildSize: controller.bottomSheetMinSize.value,
                  maxChildSize: controller.bottomSheetMaxSize.value,
                  expand: true,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 20.0.ss),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30)),
                                      child: Container(
                                        // height: size.height*3/4,
                                        decoration: BoxDecoration(
                                            color: AppColors.colorWhite,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30.ss),
                                              topLeft: Radius.circular(30.ss),
                                            )),
                                        child: SingleChildScrollView(
                                          controller: scrollController,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Gap(10.ss),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 5.ss,
                                                    width: 80.ss,
                                                    color: AppColors.colorgrey,
                                                  ),
                                                ],
                                              ),
                                              Gap(12.ss),
                                              Divider(
                                                  color: AppColors.titleColor
                                                      .withOpacity(0.5),
                                                  thickness: 0.3.ss),
                                              Gap(16.ss),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.0.ss),
                                                child: Text(
                                                  AppStrings
                                                      .areYouSureYouWantToCancel,
                                                  style: CustomTextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16.fss),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.0.ss),
                                                child: Text(
                                                  AppStrings
                                                      .yourTripIsBeingOffered,
                                                  style: CustomTextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          AppColors.titleColor,
                                                      fontSize: 14.fss),
                                                ),
                                              ),
                                              Gap(38.ss),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        );

      case RideStatus.WANT_TO_CANCEL_RIDE_AFTER_DRIVER_ACCEPT:
        return Obx(
          () => Stack(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                decoration:
                    BoxDecoration(color: AppColors.colorBlack.withOpacity(0.3)),
              ),
              DraggableScrollableSheet(
                  initialChildSize: controller.bottomSheetIntSize.value,
                  minChildSize: controller.bottomSheetMinSize.value,
                  maxChildSize: controller.bottomSheetMaxSize.value,
                  expand: true,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 20.0.ss),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30)),
                                      child: Container(
                                        // height: size.height*3/4,
                                        decoration: BoxDecoration(
                                            color: AppColors.colorWhite,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30.ss),
                                              topLeft: Radius.circular(30.ss),
                                            )),
                                        child: SingleChildScrollView(
                                          controller: scrollController,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Gap(10.ss),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 5.ss,
                                                    width: 80.ss,
                                                    color: AppColors.colorgrey,
                                                  ),
                                                ],
                                              ),
                                              Gap(12.ss),
                                              Center(
                                                child: Text(
                                                  "${AppStrings.cancelRide}?",
                                                  style: CustomTextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16.fss),
                                                ),
                                              ),
                                              Gap(15.ss),
                                              Divider(
                                                  color: AppColors.titleColor
                                                      .withOpacity(0.5),
                                                  thickness: 0.3.ss),
                                              Gap(16.ss),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.0.ss),
                                                child: Text(
                                                  AppStrings
                                                      .areYouSureYouWantToCancel,
                                                  style: CustomTextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16.fss),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.0.ss),
                                                child: Text(
                                                  AppStrings
                                                      .yourTripIsBeingOffered,
                                                  style: CustomTextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          AppColors.titleColor,
                                                      fontSize: 14.fss),
                                                ),
                                              ),
                                              Gap(18.ss),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        );

      case RideStatus.REASON_TO_CANCEL_RIDE:
        return Obx(
          () => Stack(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                decoration:
                    BoxDecoration(color: AppColors.colorBlack.withOpacity(0.3)),
              ),
              DraggableScrollableSheet(
                  initialChildSize: controller.bottomSheetIntSize.value,
                  minChildSize: controller.bottomSheetMinSize.value,
                  maxChildSize: controller.bottomSheetMaxSize.value,
                  expand: true,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 20.0.ss),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30)),
                                      child: Container(
                                        // height: size.height*3/4,
                                        decoration: BoxDecoration(
                                            color: AppColors.colorWhite,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30.ss),
                                              topLeft: Radius.circular(30.ss),
                                            )),
                                        child: SingleChildScrollView(
                                          controller: scrollController,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Gap(10.ss),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 5.ss,
                                                    width: 80.ss,
                                                    color: AppColors.colorgrey,
                                                  ),
                                                ],
                                              ),
                                              Gap(12.ss),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 24.0.ss),
                                                child: Text(
                                                  "${AppStrings.cancelRide}?",
                                                  style: CustomTextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16.fss),
                                                ),
                                              ),
                                              Gap(16.ss),
                                              Divider(
                                                  color: AppColors.titleColor
                                                      .withOpacity(0.5),
                                                  thickness: 0.3.ss),
                                              Gap(20.ss),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 24.0.ss),
                                                child: Text(
                                                  AppStrings
                                                      .WhyDoYouWantToCancel.tr,
                                                  style: CustomTextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14.fss),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 24.0.ss),
                                                child: Text(
                                                  AppStrings.required.tr,
                                                  style: CustomTextStyle(
                                                      color:
                                                          AppColors.titleColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12.fss),
                                                ),
                                              ),
                                              Gap(20.ss),
                                              Obx(
                                                () => controller
                                                        .isOtherReasonsTapped
                                                        .value
                                                    ? const Offstage()
                                                    : ListView.builder(
                                                        // controller:
                                                        //     scrollController,
                                                        shrinkWrap: true,
                                                        itemCount: controller
                                                            .cancelReasons
                                                            ?.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Container(
                                                            decoration: BoxDecoration(
                                                                border: Border(
                                                                    top: BorderSide(
                                                                        color: AppColors
                                                                            .colordivider),
                                                                    bottom: BorderSide(
                                                                        color: AppColors
                                                                            .colordivider))),
                                                            child: InkWell(
                                                              onTap: () {
                                                                controller
                                                                    .cancellationReason
                                                                    .value = controller
                                                                        .cancelReasons![
                                                                            index]
                                                                        .reason ??
                                                                    "";
                                                                print(
                                                                    "Reason:${controller.cancellationReason.value}");
                                                                controller
                                                                        .rideStatus
                                                                        .value =
                                                                    RideStatus
                                                                        .WANT_TO_CANCEL_RIDE_AFTER_DRIVER_ACCEPT;
                                                              },
                                                              child: ListTile(
                                                                  leading: Image.network(
                                                                      controller
                                                                              .cancelReasons![index]
                                                                              .icon ??
                                                                          ""),
                                                                  title: Text(
                                                                    controller
                                                                            .cancelReasons![index]
                                                                            .reason ??
                                                                        "",
                                                                    style: CustomTextStyle(
                                                                        color: AppColors
                                                                            .titleColor,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            14.fss),
                                                                  )),
                                                            ),
                                                          );
                                                        }),
                                              ),
                                              Gap(12.ss),
                                              InkWell(
                                                onTap: () {
                                                  controller
                                                      .isOtherReasonsTapped
                                                      .value = true;
                                                },
                                                child: ListTile(
                                                    leading: Icon(Icons
                                                        .more_horiz_rounded),
                                                    title: Text(
                                                      controller.isOtherReasonsTapped
                                                              .value
                                                          ? AppStrings
                                                              .writeYourReasonForCancellation
                                                              .tr
                                                          : AppStrings.Other.tr,
                                                      style: CustomTextStyle(
                                                          color: AppColors
                                                              .titleColor,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.fss),
                                                    )),
                                              ),
                                              Gap(12.ss),
                                              Obx(
                                                () => controller
                                                        .isOtherReasonsTapped
                                                        .value
                                                    ? Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    24.0.ss),
                                                        child:
                                                            CommonTextFormField(
                                                          controller: controller
                                                              .reasonForOtherCancellation,
                                                          margin: 0.0,
                                                          padding: 0.0,
                                                          decoration:
                                                              InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                            hintText:
                                                                'Write a message',
                                                            filled: true,
                                                          ),
                                                          textInputAction:
                                                              TextInputAction
                                                                  .newline,
                                                          textInputType:
                                                              TextInputType
                                                                  .multiline,
                                                          maxLine: 3,
                                                        ),
                                                      )
                                                    : const Offstage(),
                                              ),
                                              Gap(20.ss)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        );

      default:
        return Obx(
          () => DraggableScrollableSheet(
              initialChildSize: controller.bottomSheetIntSize.value,
              minChildSize: controller.bottomSheetMinSize.value,
              maxChildSize: controller.bottomSheetMaxSize.value,
              controller: DraggableScrollableController(),
              expand: true,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Column(
                  children: [
                    Gap(20.ss),
                    Expanded(
                        child: LoaderWidget(
                      title: AppStrings.connectingYouToADriver.tr,
                      subTitle: controller.initRideData.value != null &&
                              controller.initRideData.value!.distanceMatrix !=
                                  null
                          ? AppStrings.dropoffBy.tr +
                              controller.initRideData.value!.distanceMatrix!
                                  .param!.duration!.text!
                          : "",
                      buttonText: AppStrings.cancelRide.tr,
                      onButtonClick: () {
                        controller.rideStatus.value =
                            RideStatus.WANT_TO_CANCEL_RIDE;
                        // controller.rideStatus.value =
                        //     RideStatus.DRIVER_BID_ARRIVED;
                      },
                    ))
                  ],
                );
              }),
        );
    }
  }
}

import 'dart:async';
import 'dart:io';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pinput/pinput.dart';
import 'package:squch/core/common/common_text_form_field.dart';
import 'package:sizing/sizing.dart';
import 'package:squch/core/utils/app_strings.dart';
import 'package:squch/core/utils/fonts.dart';
import 'package:squch/core/widgets/gap.dart';
import 'package:squch/core/widgets/horizontal_gap.dart';
import 'package:squch/features/map_page_feature/data/models/ride_booking_bid_response.dart';
import 'package:squch/features/map_page_feature/presentation/controller/ride_status.dart';
import '../../../common/widget/dynamicTextField.dart';
import '../../../common/widget/rideTypeItem.dart';
import '../../../core/common/common_button.dart';
import '../../../core/service/page_route_service/routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/image_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/dash_line_view.dart';
import '../../../core/widgets/driver_arrived_card.dart';
import '../../../core/widgets/rating_with_car_widget.dart';
import '../../../core/widgets/loader_widget.dart';
import '../../../core/widgets/passenger_instruction_widget.dart';
import '../../../core/widgets/title_text.dart';
import 'controller/map_controller.dart';
import 'widgets/dragable_scroll_sheet_widget.dart';
import 'widgets/map_widget.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController controller =
      Get.put(MapController(mapRepository: Get.find(), sharedPref: Get.find()));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            child: Animarker(
              curve: Curves.bounceOut,
              rippleRadius: 0.2,
              rippleColor: AppColors.buttonColor,
              useRotation: false,
              duration: const Duration(milliseconds: 100),
              //markers: Set<Marker>.of(controller.markers.value.values),
              mapId: controller.mapController.future
                  .then<int>((value) => value.mapId),
              child: Obx(() => controller.customMarkers?.isEmpty ?? false
                  ? MapWidget()
                  : MapWidget()),
            ),
          ),
          Obx(() => Visibility(
                visible: controller.rideStatus !=
                        RideStatus.RIDE_TYPE_BOTTOM_SHEET_SHOWING &&
                    controller.rideStatus != RideStatus.RIDE_IN_PROGRESS &&
                    controller.rideStatus != RideStatus.DRIVER_SEARCHING &&
                    controller.rideStatus != RideStatus.DRIVER_BID_ARRIVED &&
                    controller.rideStatus !=
                        RideStatus.RIDE_CONFIRMATION_PIN_BOTTOM_SHEET_SHOWING &&
                    controller.isMapSearchBoxVisible.value,
                child: Positioned(
                  top: Platform.isIOS ? 50.ss : 40.ss,
                  right: 10.ss,
                  left: 10.ss,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.ss, vertical: 5.ss),
                    width: MediaQuery.sizeOf(context).width - 40,
                    decoration: BoxDecoration(
                        color: AppColors.colorWhite,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                            color: AppColors.titleColor.withOpacity(0.5),
                            width: 0.5.ss)),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              if (controller.rideStatus.value ==
                                  RideStatus.RIDE_TYPE_BOTTOM_SHEET_SHOWING) {
                                Get.back();
                              } else if (controller.rideStatus.value ==
                                  RideStatus
                                      .VEHICLE_TYPE_BOTTOM_SHEET_SHOWING) {
                                controller.manageMapState(
                                    RideStatus.RIDE_TYPE_BOTTOM_SHEET_SHOWING);
                              } else if (controller.rideStatus.value ==
                                  RideStatus
                                      .RIDE_DETAILS_BOTTOM_SHEET_SHOWING) {
                                controller.manageMapState(RideStatus
                                    .VEHICLE_TYPE_BOTTOM_SHEET_SHOWING);
                              } else {
                                controller.rideStatus.value = RideStatus
                                    .RIDE_DETAILS_BOTTOM_SHEET_SHOWING;
                              }
                            },
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 24.ss,
                            )),
                        Expanded(
                          child: CommonTextFormField(
                            onTap: () {
                              controller.isSourceEnable.value = true;
                            },
                            controller: controller.searchPickUpController.value,
                            fillColor: AppColors.colorlightgrey1,
                            decoration: InputDecoration(
                              // isDense:false,
                              fillColor: AppColors.colorgrey,
                              hintText: "Add source",
                              hintStyle: CustomTextStyle(
                                  color: Theme.of(context).brightness !=
                                          Brightness.dark
                                      ? Colors.black87
                                      : Colors.white),
                              // isCollapsed: true,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        HorizontalGap(5.ss),
                        SvgPicture.asset(
                          ImageUtils.add,
                          color: AppColors.titleColor.withOpacity(0.5),
                          height: 18.ss,
                          width: 18.ss,
                        )
                      ],
                    ),
                  ),
                ),
              )),
          DragableScrollSheetWidget(),
        ],
      ),
      bottomNavigationBar: Obx(() => controller.rideStatus ==
                  RideStatus.DRIVER_SEARCHING ||
              controller.rideStatus == RideStatus.DRIVER_BID_ARRIVED
          ? Offstage()
          : controller.rideStatus == RideStatus.RIDE_IN_PROGRESS
              ? Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.ss,
                  ),
                  child: Wrap(
                    children: [
                      Gap(10.ss),
                      controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : InkWell(
                              onTap: () {
                                controller.findReasonToCancelRide();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 5.ss),
                                // height: 60.ss,
                                child: Center(
                                  child: Text(
                                    AppStrings.stopRide.tr,
                                    textAlign: TextAlign.center,
                                    style: CustomTextStyle(
                                        fontSize: 14.fss,
                                        color: AppColors.textRed,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                )
              : controller.rideStatus ==
                      RideStatus.RIDE_NEGOTIATION_BOTTOM_SHEET_SHOWING
                  ? Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.ss,
                      ),
                      child: Wrap(
                        children: [
                          Gap(10.ss),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.ss),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0.ss),
                                    child: Obx(
                                      () => controller.isLimitReachedMaximum
                                                  .isTrue ||
                                              controller
                                                  .isLimitReachedMinimum.isTrue
                                          ? CommonButton(
                                              solidColor: AppColors.textRed,
                                              buttonWidth:
                                                  controller.size.width - 100,
                                              buttonHeight: 50.ss,
                                              label: AppStrings.raiseFare.tr,
                                              onClicked: null,
                                            )
                                          : CommonButton(
                                              buttonWidth:
                                                  controller.size.width - 100,
                                              buttonHeight: 50.ss,
                                              label: AppStrings.raiseFare.tr,
                                              onClicked: () {
                                                controller
                                                    .isCancelledTappedFromRideDetailsPage
                                                    .value = false;
                                                controller.manageMapState(RideStatus
                                                    .RIDE_DETAILS_BOTTOM_SHEET_SHOWING);
                                              },
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(20.ss),
                          Divider(
                            color: AppColors.colorLightGrey,
                          ),
                          InkWell(
                            onTap: () {
                              controller.manageMapState(
                                  RideStatus.RIDE_DETAILS_BOTTOM_SHEET_SHOWING);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5.ss),
                              // height: 60.ss,
                              child: Center(
                                child: Text(
                                  AppStrings.cancel.tr,
                                  textAlign: TextAlign.center,
                                  style: CustomTextStyle(
                                      fontSize: 14.fss,
                                      color: AppColors.textRed,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : controller.rideStatus ==
                          RideStatus
                              .RIDE_NEGOTIATION_BOTTOM_SHEET_SHOWING_FOR_COMMENT
                      ? Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10.ss,
                          ),
                          child: Wrap(
                            children: [
                              Gap(10.ss),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.ss),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0.ss),
                                        child: CommonButton(
                                          buttonWidth:
                                              controller.size.width - 100,
                                          buttonHeight: 50.ss,
                                          label: AppStrings.done.tr,
                                          onClicked: () {
                                            if (controller.reasonChangingPrice
                                                    .text.isNotEmpty ||
                                                controller.reasonChangingPrice
                                                        .text !=
                                                    "") {
                                              controller.manageMapState(RideStatus
                                                  .RIDE_DETAILS_BOTTOM_SHEET_SHOWING);
                                            } else {
                                              showFailureSnackbar(
                                                  "Comment field is blank",
                                                  "Comment field can ot be empty");
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Gap(20.ss),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 20.0.ss),
                                child: CommonButton(
                                  label: AppStrings.back,
                                  labelColor: AppColors.colorBlack,
                                  solidColor: AppColors.buttonSolidColor,
                                  fontWeight: FontWeight.w500,
                                  onClicked: () {
                                    if (controller
                                        .isCancelledTappedFromRideDetailsPage
                                        .value) {
                                      controller.manageMapState(RideStatus
                                          .RIDE_DETAILS_BOTTOM_SHEET_SHOWING);
                                    } else {
                                      controller.manageMapState(RideStatus
                                          .RIDE_NEGOTIATION_BOTTOM_SHEET_SHOWING);
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      : controller.rideStatus ==
                              RideStatus
                                  .RIDE_CONFIRMATION_PIN_BOTTOM_SHEET_SHOWING
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10.ss,
                              ),
                              child: Wrap(
                                children: [
                                  Gap(10.ss),
                                  controller.isLoading.value
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : InkWell(
                                          onTap: () {
                                            controller.findReasonToCancelRide();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.ss),
                                            // height: 60.ss,
                                            child: Center(
                                              child: Text(
                                                AppStrings.cancel.tr,
                                                textAlign: TextAlign.center,
                                                style: CustomTextStyle(
                                                    fontSize: 14.fss,
                                                    color: AppColors.textRed,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            )
                          : controller.rideStatus ==
                                  RideStatus.RIDE_TYPE_BOTTOM_SHEET_SHOWING
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.ss,
                                  ),
                                  child: Wrap(
                                    children: [
                                      Gap(10.ss),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5.ss),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.0.ss),
                                                child: CommonButton(
                                                  buttonWidth:
                                                      controller.size.width -
                                                          100,
                                                  buttonHeight: 50.ss,
                                                  label:
                                                      AppStrings.findARide.tr,
                                                  onClicked: () {
                                                    controller.callInitRideApi(
                                                        context);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Gap(20.ss),
                                      Divider(
                                        color: AppColors.colorLightGrey,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.clearTextFields();
                                          Get.back();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.ss),
                                          // height: 60.ss,
                                          child: Center(
                                            child: Text(
                                              AppStrings.cancel.tr,
                                              textAlign: TextAlign.center,
                                              style: CustomTextStyle(
                                                  fontSize: 14.fss,
                                                  color: AppColors.textRed,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : controller.rideStatus !=
                                          RideStatus.INITIAL_MAP &&
                                      controller.rideStatus !=
                                          RideStatus
                                              .RIDE_TYPE_BOTTOM_SHEET_SHOWING
                                  ? controller.rideStatus ==
                                          RideStatus.WANT_TO_CANCEL_RIDE
                                      ? Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.ss,
                                              horizontal: 20.ss),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Gap(10.ss),
                                              controller.isLoading.isTrue
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5.ss),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: CommonButton(
                                                              solidColor: AppColors
                                                                  .buttonSolidColor,
                                                              buttonWidth:
                                                                  controller
                                                                          .size
                                                                          .width -
                                                                      100,
                                                              buttonHeight:
                                                                  50.ss,
                                                              label: AppStrings
                                                                  .cancelRequest
                                                                  .tr,
                                                              labelColor:
                                                                  AppColors
                                                                      .textRed,
                                                              onClicked: () {
                                                                //No driver found Cancel Ride(Loading State)
                                                                controller
                                                                    .cancelRide(
                                                                        "");
                                                                controller
                                                                        .rideStatus
                                                                        .value =
                                                                    RideStatus
                                                                        .RIDE_DETAILS_BOTTOM_SHEET_SHOWING;
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                              Gap(5.ss),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5.ss),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: CommonButton(
                                                        buttonWidth: controller
                                                                .size.width -
                                                            100,
                                                        buttonHeight: 50.ss,
                                                        label: AppStrings
                                                            .waitForDriver.tr,
                                                        onClicked: () {
                                                          controller.rideStatus
                                                                  .value =
                                                              RideStatus
                                                                  .DRIVER_SEARCHING;
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : controller.rideStatus ==
                                              RideStatus
                                                  .WANT_TO_CANCEL_RIDE_AFTER_DRIVER_ACCEPT
                                          ? Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.ss,
                                                  horizontal: 20.ss),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Gap(10.ss),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5.ss),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: CommonButton(
                                                            solidColor: AppColors
                                                                .buttonSolidColor,
                                                            buttonWidth:
                                                                controller.size
                                                                        .width -
                                                                    100,
                                                            buttonHeight: 50.ss,
                                                            label: AppStrings
                                                                .cancelRequest
                                                                .tr,
                                                            labelColor:
                                                                AppColors
                                                                    .textRed,
                                                            onClicked: () {
                                                              controller.cancelRide(controller
                                                                      .isOtherReasonsTapped
                                                                      .value
                                                                  ? controller
                                                                      .reasonForOtherCancellation
                                                                      .text
                                                                  : controller
                                                                      .cancellationReason
                                                                      .value);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Gap(5.ss),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5.ss),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: CommonButton(
                                                            buttonWidth:
                                                                controller.size
                                                                        .width -
                                                                    100,
                                                            buttonHeight: 50.ss,
                                                            label: AppStrings
                                                                .waitForDriver
                                                                .tr,
                                                            onClicked: () {
                                                              controller
                                                                      .rideStatus
                                                                      .value =
                                                                  RideStatus
                                                                      .RIDE_CONFIRMATION_PIN_BOTTOM_SHEET_SHOWING;
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : controller.rideStatus ==
                                                  RideStatus
                                                      .REASON_TO_CANCEL_RIDE
                                              ? Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.ss,
                                                      horizontal: 20.ss),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      controller
                                                              .isOtherReasonsTapped
                                                              .value
                                                          ? Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          5.ss),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        CommonButton(
                                                                      solidColor:
                                                                          AppColors
                                                                              .buttonSolidColor,
                                                                      buttonWidth:
                                                                          controller.size.width -
                                                                              100,
                                                                      buttonHeight:
                                                                          50.ss,
                                                                      label: AppStrings
                                                                          .cancelRequest
                                                                          .tr,
                                                                      labelColor:
                                                                          AppColors
                                                                              .textRed,
                                                                      onClicked:
                                                                          () {},
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          : const Offstage(),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5.ss),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child:
                                                                  CommonButton(
                                                                buttonWidth:
                                                                    controller
                                                                            .size
                                                                            .width -
                                                                        100,
                                                                buttonHeight:
                                                                    50.ss,
                                                                label: AppStrings
                                                                    .KeepMyRide
                                                                    .tr,
                                                                onClicked: () {
                                                                  // controller.rideStatus.value = RideStatus.RIDE_CONFIRMATION_PIN_BOTTOM_SHEET_SHOWING;
                                                                  controller
                                                                      .isOtherReasonsTapped
                                                                      .value = false;
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.ss,
                                                      horizontal: 20.ss),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                CircleAvatar(
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .colorgrey,
                                                                  radius: 18.ss,
                                                                  child: SvgPicture.asset(
                                                                      ImageUtils
                                                                          .cash),
                                                                ),
                                                                HorizontalGap(
                                                                    10.ss),
                                                                Text(
                                                                  AppStrings
                                                                      .cash.tr,
                                                                  style: CustomTextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      fontSize:
                                                                          14.fss),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .arrow_forward_ios_rounded,
                                                            size: 20.ss,
                                                          )
                                                        ],
                                                      ),
                                                      Gap(10.ss),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5.ss),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child:
                                                                  CommonButton(
                                                                buttonWidth:
                                                                    controller
                                                                            .size
                                                                            .width -
                                                                        100,
                                                                buttonHeight:
                                                                    50.ss,
                                                                label: AppStrings
                                                                    .findADriver
                                                                    .tr,
                                                                onClicked: () {
                                                                  if (controller
                                                                          .rideStatus
                                                                          .value ==
                                                                      RideStatus
                                                                          .VEHICLE_TYPE_BOTTOM_SHEET_SHOWING) {
                                                                    controller
                                                                        .selectedCharge
                                                                        .value = controller
                                                                            .charges[
                                                                        controller
                                                                            .selectedCarTypeChargeIndex
                                                                            .value];
                                                                    controller
                                                                            .rideStatus
                                                                            .value =
                                                                        RideStatus
                                                                            .RIDE_DETAILS_BOTTOM_SHEET_SHOWING;
                                                                  } else if (controller
                                                                          .rideStatus
                                                                          .value ==
                                                                      RideStatus
                                                                          .RIDE_DETAILS_BOTTOM_SHEET_SHOWING) {
                                                                    controller.callFindADriverApi(
                                                                        context:
                                                                            context,
                                                                        vehicleId: controller
                                                                            .selectedCharge
                                                                            .value
                                                                            .vehicleTypeId
                                                                            .toString(),
                                                                        askingPrice: controller
                                                                            .originalPrice
                                                                            .value
                                                                            .toString(),
                                                                        paymentMode:
                                                                            "cash");
                                                                  }
                                                                  controller
                                                                      .update();
                                                                  // controller.showRideDetailsBottomSheet(
                                                                  //     context);
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                  :
      Offstage()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';
import 'package:squch/core/utils/app_colors.dart';
import 'package:squch/core/utils/app_strings.dart';
import 'package:squch/core/utils/utils.dart';
import 'package:squch/core/widgets/common_app_bar.dart';
import 'package:squch/core/widgets/gap.dart';
import 'package:squch/features/map_page_feature/presentation/controller/map_controller.dart';

import '../../../common/widget/dynamicTextField.dart';
import '../../../core/common/see_all_button.dart';
import '../../../core/service/page_route_service/routes.dart';
import '../../../core/utils/fonts.dart';
import 'controller/ride_status.dart';

class SearchRide extends GetView<MapController> {
  late MapController controller;

  SearchRide({super.key}) {
    if (Get.isRegistered<MapController>()) {
      controller = Get.find<MapController>();
      controller.onInit();
    } else {
      controller = Get.put(
          MapController(sharedPref: Get.find(), mapRepository: Get.find()));
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: CommonAppbar(
        title: AppStrings.PlanYourRide.tr,
        isIconShow: true,
        onPressed: (){
          controller.isNegetiveActive.value = false;
          Get.back();
        },
        backgroundColor: AppColors.colorWhite,
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          color: AppColors.titleColor,
          size: 18.ss,
        ),
        centerTitle: true,
        /* backgroundColor: AppColors.colorWhite,
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.titleColor,
            size: 18.ss,
          ),
        ),*/
      ),
      body: Obx(
        () => Container(
          padding: EdgeInsets.symmetric(horizontal: 10.ss),
          child: Column(
            // shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.ss),
                child: DynamicTextField(
                    numberOfTextFields: controller.numberOfTextFields.value,
                    isNegetiveActive: controller.isNegetiveActive.value,
                    context: context,
                    onTapForSource: () {
                      controller.locationList.clear();
                      controller.desableInsertStopage();
                      controller.enableInsertSource();
                      print("Source Tap:${controller.isSourceEnable.value}");
                    },
                    onTapForDest: () {
                      controller.locationList.clear();

                      controller.desableInsertSource();
                      controller.desableInsertStopage();
                      print("Source Tap:${controller.isSourceEnable.value}");
                    },
                    onEditingComplete: () {
                      if (controller.sourceAddress.value?.latitude != null &&
                          controller.destinationAddress.value?.latitude !=
                              null) {
                        if (controller.isStoppage.value) {
                        } else {
                          controller.manageMapState(
                              RideStatus.RIDE_TYPE_BOTTOM_SHEET_SHOWING);
                          Get.toNamed(Routes.MAP_PAGE);
                          controller.createMarker();
                        }
                      }
                    },
                    onStoppageEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                    onAddNewTextField: () {
                      TextEditingController textEditingController =
                          new TextEditingController();
                      if (controller.maxTextFields.value >
                          controller.numberOfTextFields.value) {
                        controller.numberOfTextFields =
                            controller.numberOfTextFields + 1;
                        controller.textEditingControllers
                            .add(textEditingController);

                        if (controller.numberOfTextFields > 0) {
                          controller.isNegetiveActive.value = true;
                        }
                        controller.tappedStoppageIndex.value = controller.textEditingControllers.length-1;
                        textEditingController.addListener(controller.onSearchChangedStoppage);
                      }
                      else{showFailureSnackbar("Opps", AppStrings.maxStoppageLimitReached.tr);
                      }
                      print(
                          "numberOfTextFields:${controller.numberOfTextFields}");
                    },
                    onRemoveTextField: (){

                      if(controller.numberOfTextFields.value!= 0) {
                        controller.numberOfTextFields.value = controller.numberOfTextFields.value - 1;
                      }
                      if(controller.textEditingControllers.isNotEmpty){
                        controller.textEditingControllers.last.removeListener(controller.onSearchChangedStoppage);
                        controller.textEditingControllers.removeLast();
                        if(controller.stoppageList.isNotEmpty){
                          controller.stoppageList.removeLast();
                        }
                      }

                      if(controller.numberOfTextFields.value== 0) controller.isNegetiveActive.value = false;
                    },
                    controllerForSource:
                        controller.searchPickUpController.value,
                    controllerForDest: controller.searchDestController.value,
                    maxTextFields: controller.maxTextFields.value,
                    textEditingControllers: controller.textEditingControllers,
                    onTapForStoppage: (int value) {
                      controller.locationList.clear();
                      controller.enableInsertStopage();
                      controller.tappedStoppageIndex.value = value;
                    }),
              ),
              Gap(10.ss),
              Visibility(
                visible: !controller.enableSearch.value,
                child: Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0.ss, vertical: 10.ss),
                        child: Row(
                          children: [
                            Text(
                              AppStrings.SavedPlace,
                              style: CustomTextStyle(
                                  fontSize: 18.fss,
                                  fontWeight: FontWeight.w800),
                              overflow: TextOverflow.clip,
                            ),
                            Spacer(),
                            SeeAllButton(
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: controller.savedList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  controller.tappedOnSaved(
                                      address: controller.savedList[index]);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10.ss),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10.ss,
                                          ),
                                          CircleAvatar(
                                            radius: 15.ss,
                                            backgroundColor:
                                                AppColors.colorgrey,
                                            child: SvgPicture.asset(controller
                                                .savedList[index]
                                                .image as String),
                                          ),
                                          SizedBox(
                                            width: 10.ss,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  controller.savedList[index]
                                                      .getDescription,
                                                  style: CustomTextStyle(
                                                      fontSize: 14.fss,
                                                      color:
                                                          AppColors.titleColor,
                                                      fontWeight:
                                                          FontWeight.w800)),
                                              SizedBox(
                                                height: 5.ss,
                                              ),
                                              Text(
                                                  controller.savedList[index]
                                                      .getAddress,
                                                  style: CustomTextStyle(
                                                      fontSize: 12.fss,
                                                      fontWeight:
                                                          FontWeight.w400))
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12.ss,
                                      ),
                                      Divider(
                                        height: 1.ss,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: controller.enableSearch.value,
                child: Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.0.ss, vertical: 10.ss),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 5),
                          child: Text(
                            AppStrings.SuggestedPlaces.tr,
                            style: CustomTextStyle(
                                fontSize: 18.fss, fontWeight: FontWeight.w800),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Expanded(
                          child: Obx(()=>
                             ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: controller.locationList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    print(
                                        "Source Enable : ${controller.isSourceEnable.value}");
                                    FocusScope.of(context).unfocus();

                                    // controller.enableSearch.value =
                                    //     !controller.enableSearch.value;

                                    List<Location> locations =
                                        await locationFromAddress(controller
                                            .locationList[index]
                                            .getDescription); //,localeIdentifier: "in_IN"
                                    controller.locationList[index].latitude =
                                        locations[0].latitude;
                                    controller.locationList[index].longitude =
                                        locations[0].longitude;
                                    print(
                                        "LOCATION: ${controller.locationList[index].toJson()}");

                                    if(controller.isStoppage.value){
                                      controller.stoppageList.insert(controller.tappedStoppageIndex.value,controller.locationList[index]);
                                      controller.textEditingControllers[controller.tappedStoppageIndex.value].text = controller.locationList[index].getAddress;
                                    }else {
                                      if (controller.isSourceEnable.isTrue) {
                                        controller.searchPickUpController.value
                                            .removeListener(
                                            controller.onSearchChangedPickup);
                                        controller
                                            .searchPickUpController.value.text =
                                            controller
                                                .locationList[index]
                                                .getDescription;
                                        controller.enableSearch.value = false;
                                        Future.delayed(
                                            Duration(milliseconds: 100));
                                        controller.searchPickUpController.value
                                            .addListener(
                                            controller.onSearchChangedPickup);
                                        /*  if (controller.routeList.isNotEmpty) {
                                        controller.routeList.removeAt(0);
                                      }
                                       controller.routeList.insert(0, controller.locationList[index]);*/

                                        controller.sourceAddress.value =
                                        controller.locationList[index];
                                      }
                                      else {
                                        controller.searchDestController.value
                                            .removeListener(
                                            controller.onSearchChangedDropOff);
                                        controller.searchDestController.value
                                            .text =
                                            controller
                                                .locationList[index]
                                                .getDescription;
                                        /*   if (controller.routeList.length > 1) {
                                        controller.routeList.removeAt(1);
                                      }
                                      controller.routeList.insert(1, controller.locationList[index]);*/

                                        controller.destinationAddress.value =
                                        controller.locationList[index];
                                        controller.enableSearch.value = false;

                                        Future.delayed(
                                            Duration(milliseconds: 100));
                                        controller.searchDestController.value
                                            .addListener(
                                            controller.onSearchChangedDropOff);
                                        debugPrint("Route List => " +
                                            controller.routeList.length
                                                .toString());
                                        controller.manageMapState(RideStatus
                                            .RIDE_TYPE_BOTTOM_SHEET_SHOWING);
                                        controller.enableSearch.value = false;

                                        Get.toNamed(Routes.MAP_PAGE);
                                        controller.createMarker();
                                        controller.callInitRideApi(context,
                                            isDragChange: true);
                                      }
                                    }
                                    controller.locationList.clear();
                                    controller.enableSearch.value = false;
                                    print("Route List ===>>> " +
                                        controller.routeList.length.toString());
                                  },
                                  child: builderItem(
                                    title: controller
                                        .locationList[index].getAddress.split(",").first,
                                    subTitle:
                                        controller.locationList[index].getDescription,
                                    showEdit: false,
                                    index: index,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget builderItem(
      {required String title,
      required String subTitle,
      required bool showEdit,
      required int index}) {
    return Column(
      children: [
        ListTile(
          title: Text(title,
              overflow: TextOverflow.ellipsis, style: Get.textTheme.titleSmall),
          subtitle: Text(subTitle,
              overflow: TextOverflow.clip, style: CustomTextStyle( fontWeight: FontWeight.w500,fontSize: 12.fss,color: AppColors.colorBlack.withOpacity(0.7))),
          //trailing: showEdit? Image.asset(Assets.edit): const Offstage(),
        ),
        const Divider(
          color: Colors.black12,
          height: 5,
          thickness: 1,
        ),
      ],
    );
  }
}

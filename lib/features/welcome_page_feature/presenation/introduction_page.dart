import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squch/core/common/common_dropdown.dart';
import 'package:squch/core/service/page_route_service/routes.dart';
import 'package:squch/core/widgets/horizontal_gap.dart';
import 'package:squch/features/user_auth_feature/presentation/login_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../../../core/shared_pref/shared_pref.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/fonts.dart';
import 'package:sizing/sizing.dart';
import '../../../core/utils/image_utils.dart';
import '../../../core/widgets/gap.dart';
import '../../../core/widgets/title_text.dart';
import 'package:video_player/video_player.dart';

import 'controller/introduction_controller.dart';


class IntroductionPage extends GetView<IntroductionController> {
   IntroductionPage({super.key});

  final Uri _url = Uri.parse('http://tinyurl.com/axfzahct');
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      top: true,
      child:  Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height/12),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.ss),
              width: MediaQuery.of(context).size.width,
              height: 45,
              // color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    child: Icon(Icons.arrow_back_ios_new_outlined),

                    onTap: () {
                      Get.back();
                    },
                  ),
                  Expanded(
                    child: Text(
                      AppStrings.InstructionVideo.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w800,fontSize: 18.ss),
                    ),
                  ),

                  InkWell(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 8.0.ss),
                      child: Text(AppStrings.skip.tr,style: CustomTextStyle(color: Theme.of(context).brightness != Brightness.dark   ? AppColors.titleColor.withOpacity(0.6):Colors.white,fontSize: 16.fss),),
                    ),
                    onTap: () async{
                      SharedPref sharedPref = Get.find();
                      await sharedPref.setIntroScreenShown(true);
                      Get.offAllNamed(Routes.HOME);

                    },
                  ),
                ],
              ),
            )
        ),
        body:Obx(()=> SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.ss),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(20.ss),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.ss),

                      )
                  ),
                  height: MediaQuery.sizeOf(context).height/2.5,

                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.sizeOf(context).height/2.5,
                        width: MediaQuery.sizeOf(context).width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: FutureBuilder(
                            future:  controller.initializeVideoPlayerFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                // If the VideoPlayerController has finished initialization, use
                                // the data it provides to limit the aspect ratio of the video.
                                return AspectRatio(
                                  aspectRatio:  1,
                                  child: VideoPlayer(controller.video_controller.value),
                                );
                              } else {
                                // If the VideoPlayerController is still initializing, show a
                                // loading spinner.
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      Center(
                        child: InkWell(
                          onTap: (){
                            controller.video_controller.value.value.isPlaying
                                ?   controller.video_controller.value.pause()
                                :   controller.video_controller.value.play();
                          },
                          child: CircleAvatar(
                            backgroundColor: AppColors.colorWhite,
                            radius: 20.ss,
                            child: Icon(  controller.video_controller.value.value.isPlaying?Icons.pause: Icons.play_arrow, color: Colors.black,),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Gap(20.ss),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppStrings.vedioNotPlaying.tr,
                      textAlign: TextAlign.center,
                      style: CustomTextStyle(
                          fontSize: 14.fss,
                          fontWeight: FontWeight.bold
                      ),),
                  ],
                ),
                Gap(20.ss),
                InkWell(
                  onTap: ()async{
                    if (!await launchUrl(_url,mode: LaunchMode.inAppWebView)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.ss, vertical: 15.ss),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(width: 0.5.ss,color: AppColors.colorgrey)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text("http://tinyurl.com/axfzahct",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: CustomTextStyle(
                              fontSize: 14.fss,
                              color: AppColors.buttonColor,
                              decoration: TextDecoration.underline,
                            ),),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(20.ss),

                TitleText(context,AppStrings.ChangeLanguage.tr),
                Gap(10.ss),

                Obx(() => CommonDropdown(
                  selectedValue: controller.selectedLanguage.value,
                  //DropdownModel(label: "Select",id: "-1",uniqueid: -1,dependentId: "-1"),
                  options: controller.languageList,
                  onChange: (newValue)async{
                    controller.selectedLanguage.value = newValue;
                    await controller.changeLanguage();
                  },
                  borderColor: AppColors.colorgrey,
                  borderRadius: 10.ss,
                  margin: 0,
                )),
                Gap(20.ss),
                TitleText(context,AppStrings.HelpSupport.tr),
                Gap(10.ss),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.ss,vertical: 10.ss),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.colorgrey,width: 0.5.ss),
                      borderRadius: BorderRadius.all(Radius.circular(10.ss))
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap:(){
                          controller.getIntroData("how-to-use");
                          Get.toNamed(Routes.HOW_TO_USE_PAGE);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(ImageUtils.howToUse),
                                HorizontalGap(10.ss),
                                Text(AppStrings.HowToUse.tr,style: CustomTextStyle(),overflow: TextOverflow.clip,),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios_rounded,size: 16.ss,),


                          ],
                        ),
                      ),
                      Divider(thickness: 1.ss,color: AppColors.colorgrey,),
                      InkWell(
                        onTap: (){
                          controller.getIntroData("driver-canellation-policy");
                          Get.toNamed(Routes.CANCEL_BY_DRIVER);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(ImageUtils.cancelBy),
                                HorizontalGap(10.ss),
                                Text(AppStrings.cancelByDriverMenuText.tr,
                                  maxLines: 2,
                                  style: CustomTextStyle(),
                                  overflow: TextOverflow.clip,),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios_rounded,size: 16.ss,),


                          ],
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      )),
    );
  }

}

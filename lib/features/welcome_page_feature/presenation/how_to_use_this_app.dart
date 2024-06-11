import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:squch/core/utils/image_utils.dart';
import 'package:squch/features/user_auth_feature/presentation/login_page.dart';
import 'package:squch/features/user_auth_feature/presentation/signup_page.dart';

import '../../../core/common/common_button.dart';
import '../../../core/common/see_all_button.dart';
import '../../../core/service/page_route_service/routes.dart';
import '../../../core/shared_pref/shared_pref.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/fonts.dart';
import 'package:sizing/sizing.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../core/widgets/gap.dart';
import '../../../core/widgets/title_text.dart';
import 'package:get/get.dart';

import 'controller/introduction_controller.dart';
class HowToUseThisApp extends GetView<IntroductionController> {
  const HowToUseThisApp({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      top: true,
      child: Scaffold(
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
                      child: SvgPicture.asset(ImageUtils.close),

                      onTap: () {
                        Get.back();
                      },
                    ),
                    Expanded(
                      child: Text(
                        AppStrings.HowToUse.tr,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w800,fontSize: 18.ss),
                      ),
                    ),

                    Container(width: 10.ss,)
                  ],
                ),
              )
          ),
          body: Obx(()=>
          controller.isLoading.value?
          Center(
            child: CircularProgressIndicator(),
          )
              :SingleChildScrollView(
            child: Container(

              margin: EdgeInsets.symmetric(horizontal: 20.ss),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(20.ss),
                  Container(
                    height: 250.ss,
                    width: size.width,
                    child:  Column(children: [
                      Expanded(
                          child:
                          CarouselSlider.builder(
                            carouselController: controller.controllerEvents,
                            itemCount: controller.imgList.length,
                            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                                Container(
                                  height: 250.ss,
                                  width: size.width*1.8/2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10.ss)),
                                      image: DecorationImage(image: NetworkImage( controller.imgList[pageViewIndex]),fit: BoxFit.fill)
                                  ),

                                ),
                            options: CarouselOptions(
                                aspectRatio: 16/8,
                                viewportFraction: 1,
                                initialPage: 0,
                                enableInfiniteScroll: false, // (1) Set to false
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration: Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.3,
                                onPageChanged: (index, reason) {

                                  controller.currentEvent.value = index;
                                }),
                          )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  controller.imgList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => controller.controllerEvents.animateToPage(entry.key),
                            child: Container(
                              width: 8.0.ss,
                              height: 8.0.ss,
                              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : AppColors.buttonColor)
                                      .withOpacity(controller.currentEvent.value == entry.key ? 0.9 : 0.4)
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ]),
                  ),
                  Gap( 20.ss,),

                  Html(
                    data:  controller.howToUseAppData.value.content == null ?"":  controller.howToUseAppData.value.content?.pageContent??"",
                  ),


                  Gap(20.ss)

                ],
              ),
            ),
          )),
          bottomNavigationBar:  Obx(()=>
           controller.isLoading.value?
          Center(
            child: CircularProgressIndicator(),
          )
              :Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.0.ss,vertical: 10.ss),
            child: CommonButton(
              buttonWidth: MediaQuery.sizeOf(context).width-100,
              label:AppStrings.gotIt.tr,onClicked: ()async{
              SharedPref sharedPref = Get.find();
              await sharedPref.setIntroScreenShown(true);
              Get.offAllNamed(Routes.HOME);
            },),
          ),)
      ),
    );
  }
}
